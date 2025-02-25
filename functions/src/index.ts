import * as admin from 'firebase-admin';

import { getWeatherForCity } from './weather_controller';

admin.initializeApp();

export { getWeatherForCity };

export * from './weather_controller';
export * from './weather_service';
