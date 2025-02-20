import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import test from "firebase-functions-test";
import {expect} from "chai";

// FirebaseFunctionsTestを初期化
const firebaseTest = test();

describe("FirebaseFunctionsのロードテスト", () => {
  before(() => {
    admin.initializeApp();
  });

  after(() => {
    firebaseTest.cleanup();
  });

  it("FirebaseFunctionsが正常にロードされる", () => {
    expect(functions).to.be.an("object");
  });
});
