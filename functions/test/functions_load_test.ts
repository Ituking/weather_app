import { expect } from 'chai';
import * as functions from 'firebase-functions';
import test from 'firebase-functions-test';

// FirebaseFunctionsTestを初期化
const firebaseTest = test();

describe('FirebaseFunctionsのロードテスト', () => {
  after(() => {
    firebaseTest.cleanup();
  });

  it('FirebaseFunctionsが正常にロードされる', () => {
    expect(functions).to.be.an('object');
  });
});
