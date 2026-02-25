import 'package:clientone_ess/core/Enums/enums.dart';

class BaseApiResponse<T> {
  final ApiStatus status;
  final String message;
  final T? data;

  BaseApiResponse.initial()
      : status = ApiStatus.initial,
        message = 'Initial',
        data = null;

  BaseApiResponse.loading()
      : status = ApiStatus.loading,
        message = 'Loading',
        data = null;

  BaseApiResponse.success({required this.data})
      : status = ApiStatus.completed,
        message = 'Success';

  BaseApiResponse.successWithMessage({required this.data, required this.message}) : status = ApiStatus.completed;

  BaseApiResponse.error(this.message)
      : status = ApiStatus.error,
        data = null;
}
