import * as chai from "chai";
import chaiAsPromised from "chai-as-promised";
import * as admin from "firebase-admin";
import * as sinon from "sinon";

import { waitForTranslations } from "../../src/services/wait_for_translation_ready";

chai.use(chaiAsPromised);
const { expect } = chai;

interface ForecastData {
  city: string;
  city_translations?: Record<string, string>;
  description: string;
  description_translations?: Record<string, string>;
  humidity: number;
  temperature: number;
  minTemp?: number;
  maxTemp?: number;
  windSpeed: number;
  icon: string;
  timestamp: number;
}

describe("waitForTranslationsの動作検証 (Cloud Functions)", () => {
  let getStub: sinon.SinonStub;
  let fakeDocRef: Pick<admin.firestore.DocumentReference<ForecastData>, "get">;

  afterEach(() => {
    sinon.restore();
  });

  it("翻訳が存在する場合、すぐに返却する", async () => {
    getStub = sinon.stub().resolves({
      data: () => ({
        city_translations: { ja: "東京" },
        description_translations: { ja: "晴れ" },
        city: "Tokyo",
        description: "Sunny",
        humidity: 30,
        temperature: 25,
        windSpeed: 5,
        icon: "01d",
        timestamp: 1234567890,
      }),
    });
    fakeDocRef = { get: getStub };

    const result = await waitForTranslations(fakeDocRef);

    expect(result.city_translations?.ja).to.equal("東京");
    expect(result.description_translations?.ja).to.equal("晴れ");
  });

  it("翻訳が存在する場合まで再試行する", async () => {
    getStub = sinon.stub();
    getStub.onCall(0).resolves({ data: () => ({}) });
    getStub.onCall(1).resolves({
      data: () => ({
        city_translations: { ja: "大阪" },
        description_translations: { ja: "曇り" },
        city: "Osaka",
        description: "Cloudy",
        humidity: 40,
        temperature: 20,
        windSpeed: 4,
        icon: "02d",
        timestamp: 1234567890,
      }),
    });
    fakeDocRef = { get: getStub };

    const result = await waitForTranslations(fakeDocRef);

    expect(result.city_translations?.ja).to.equal("大阪");
  });

  it("翻訳が一度も表示されない場合、10秒後にエラーをスローする", async () => {
    getStub = sinon.stub().callsFake(() =>
      Promise.resolve({ data: () => ({}) })
    );
    fakeDocRef = { get: getStub };

    const start = Date.now();

    await expect(waitForTranslations(fakeDocRef, { timeoutSeconds: 1, pollingIntervalMs: 100 })).to.be.rejectedWith(
      "複数回の試行後も翻訳が完了していません。"
    );

    const duration = Date.now() - start;
    expect(duration).to.be.greaterThan(80); // 実際の待機時間が80ms以上であること
  });
})