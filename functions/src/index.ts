import * as admin from "firebase-admin";
if (!admin.apps.length) {
  admin.initializeApp();
}

export * from "./weather_controller";
export * from "./weather_service";

export * from "./news_controller";
export * from "./news_service";

