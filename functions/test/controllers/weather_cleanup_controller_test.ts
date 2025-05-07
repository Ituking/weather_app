import { assert } from "chai";
import * as admin from "firebase-admin";
import { describe, it } from "mocha";
import * as sinon from "sinon";

if (!admin.apps.length) {
  admin.initializeApp();
}

import { ScheduledEvent } from "firebase-functions/v2/scheduler";
import { scheduledWeatherCleanup } from "../../src/controllers/weather_cleanup_controller";
import * as weatherCleanupService from "../../src/services/weather_cleanup_service";

describe("scheduledWeatherCleanupの動作検証 (Cloud Scheduler)", () => {
  let clearStub: sinon.SinonStub;
  const dummyEvent = {} as ScheduledEvent;

  beforeEach(() => {
    clearStub = sinon.stub(weatherCleanupService, "clearAllWeatherData").resolves();
  });

  afterEach(() => {
    sinon.restore();
  });

  it("clearAllWeatherDataが正常に呼び出される場合、1回だけ呼ばれる", async () => {
    await scheduledWeatherCleanup.run(dummyEvent);

    assert.isTrue(clearStub.calledOnce, "clearAllWeatherDataは1回呼び出されるべき");
  });
});
