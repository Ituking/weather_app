import * as dotenv from "dotenv";
import * as admin from "firebase-admin";
import firebaseFunctionsTest from "firebase-functions-test";

dotenv.config();
const test = firebaseFunctionsTest();

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
});

export { admin, test };
