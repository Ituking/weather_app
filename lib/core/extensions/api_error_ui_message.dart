import '../../core/network/api_error.dart';
import 'api_error_type_messages.dart';

extension ApiErrorUIMessage on ApiError {
  String get uiMessage {
    return type.displayMessage;
  }
}
