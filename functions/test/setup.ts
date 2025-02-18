import * as dotenv from "dotenv";
import firebaseFunctionsTest from "firebase-functions-test";
import * as admin from "firebase-admin";

dotenv.config();
const test = firebaseFunctionsTest();

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
});

export {admin, test};
