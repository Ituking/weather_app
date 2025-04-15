import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../features/weather/validator/city_name_validator.dart';

/// [CityNameValidator]を提供する[Provider]
final cityNameValidatorProvider = Provider((ref) => CityNameValidator());
