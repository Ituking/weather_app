import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'forecast_repository.dart';

final Provider<ForecastRepository> forecastRepositoryProvider =
    Provider((ref) => ForecastRepository());
