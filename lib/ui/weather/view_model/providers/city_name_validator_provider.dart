import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/validator/city_name_validator.dart';

/// [CityNameValidator]を提供する[Provider]
final cityNameValidatorProvider =
    Provider.family<CityNameValidator, AppLocalizations>(
  (ref, l10n) => CityNameValidator(l10n),
);
