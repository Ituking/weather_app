import { assert, expect } from "chai";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import firebaseFunctionsTest from "firebase-functions-test";
import { WrappedV2CallableFunction } from "firebase-functions-test/lib/v2";
import * as sinon from "sinon";

if (!admin.apps.length) {
  admin.initializeApp();
}

import { getNewsForCity } from "../src/news_controller";
import * as newsService from "../src/news_service";
import { NewsArticle } from "../src/news_service";

const testEnv = firebaseFunctionsTest();

describe("getNewsForCityの動作検証 (Cloud Functions)", () => {
  let fetchNewsStub: sinon.SinonStub;
  let saveNewsStub: sinon.SinonStub;
  let getStub: sinon.SinonStub;
  let wrapped: WrappedV2CallableFunction<Promise<NewsArticle[] | NewsArticle>>;

  const mockArticles: NewsArticle[] = [
    {
      title: "テストニュース1",
      description: "内容1",
      url: "https://example.com/news1",
      publishedAt: "2023-01-01",
      source: "MockSource"
    },
    {
      title: "テストニュース2",
      description: "内容2",
      url: "https://example.com/news2",
      publishedAt: "2023-01-02",
      source: "MockSource"
    }
  ];

  const mockNewsData: NewsArticle = {
    title: "東京のニュース",
    description: "東京に関するニュース内容",
    url: "https://example.com/tokyo",
    publishedAt: "2023-01-03",
    source: "MockSource"
  };

  beforeEach(() => {
    wrapped = testEnv.wrap(getNewsForCity) as WrappedV2CallableFunction<Promise<NewsArticle[] | NewsArticle>>;

    fetchNewsStub = sinon.stub(newsService, "fetchNewsFromAPI").resolves(mockArticles);
    saveNewsStub = sinon.stub(newsService, "saveNewsToFirestore").resolves();

    // Firestore モック
    const collectionStub = sinon.stub();
    const docStub = sinon.stub();
    const articlesCollectionStub = sinon.stub();
    const orderByStub = sinon.stub();
    const limitStub = sinon.stub();
    getStub = sinon.stub();

    collectionStub.withArgs("news").returns({ doc: docStub });
    docStub.withArgs("東京").returns({ collection: articlesCollectionStub });
    articlesCollectionStub.withArgs("articles").returns({ orderBy: orderByStub });
    orderByStub.withArgs("publishedAt", "desc").returns({ limit: limitStub });
    limitStub.withArgs(1).returns({ get: getStub });

    sinon.stub(admin.firestore(), "collection").callsFake(collectionStub);
  });

  afterEach(() => sinon.restore());
  after(() => testEnv.cleanup());

  it("都市名が指定されていない場合、エラーをスローする", async () => {
    const mockRequest = {
      data: {},
      rawRequest: {},
      auth: null,
      acceptsStreaming: false
    } as unknown as functions.https.CallableRequest<{ city?: string }>;

    try {
      await wrapped(mockRequest);
      assert.fail("エラーがスローされるべきでした");
    } catch (error) {
      expect(error).to.have.property("code", "invalid-argument");
      expect(error).to.have.property("message", "都市名が必要です。");
    }
  });

  it("Firestoreにデータがある場合、APIを呼ばずにデータを返す", async () => {
    getStub.resolves({
      empty: false,
      docs: [{ data: () => mockNewsData }]
    } as unknown);

    const mockRequest = {
      data: { city: "東京" },
      rawRequest: {},
      auth: null,
      acceptsStreaming: false
    } as unknown as functions.https.CallableRequest<{ city: string }>;

    const result = await wrapped(mockRequest);

    expect(result).to.deep.equal(mockNewsData);
    assert.isFalse(fetchNewsStub.called);
    assert.isFalse(saveNewsStub.called);
  });

  it("Firestoreにデータがない場合、APIから取得して保存する", async () => {
    getStub.resolves({ empty: true, docs: [] } as unknown);

    const mockRequest = {
      data: { city: "東京" },
      rawRequest: {},
      auth: null,
      acceptsStreaming: false
    } as unknown as functions.https.CallableRequest<{ city: string }>;

    const result = await wrapped(mockRequest);

    assert.isTrue(fetchNewsStub.calledOnce);
    assert.isTrue(saveNewsStub.calledOnce);
    expect(result).to.deep.equal(mockArticles);
  });

  it("APIからのデータ取得に失敗した場合、エラーを伝播する", async () => {
    getStub.resolves({ empty: true, docs: [] } as unknown);
    const mockError = new Error("API error");
    fetchNewsStub.rejects(mockError);

    const mockRequest = {
      data: { city: "東京" },
      rawRequest: {},
      auth: null,
      acceptsStreaming: false
    } as unknown as functions.https.CallableRequest<{ city: string }>;

    try {
      await wrapped(mockRequest);
      assert.fail("エラーがスローされるべきでした");
    } catch (error) {
      expect(error).to.equal(mockError);
      assert.isTrue(fetchNewsStub.calledOnce);
      assert.isFalse(saveNewsStub.called);
    }
  });
});
