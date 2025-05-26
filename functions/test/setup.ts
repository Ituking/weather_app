import * as chai from "chai";
import chaiAsPromised from "chai-as-promised";
import * as dotenv from "dotenv";
import * as admin from "firebase-admin";
import firebaseFunctionsTest from "firebase-functions-test";

chai.use(chaiAsPromised);

export const expect = chai.expect;

dotenv.config();
const test = firebaseFunctionsTest();

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
});

export { admin, test };
