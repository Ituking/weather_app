import { onSchedule } from "firebase-functions/v2/scheduler";
import { clearAllWeatherData } from "../services/weather_cleanup_service";

/**
 * Cloud Scheduler による毎日の自動実行
 */
export const scheduledWeatherCleanup = onSchedule(
  {
    schedule: "1 0 * * *",
    timeZone: "Asia/Tokyo",
  },
  async () => {
    await clearAllWeatherData();
  }
);
