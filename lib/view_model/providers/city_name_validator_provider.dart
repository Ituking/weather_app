import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/validator/city_name_validator.dart';

// CityNameValidatorを提供するProvider
final cityNameValidatorProvider = Provider((ref) => CityNameValidator());