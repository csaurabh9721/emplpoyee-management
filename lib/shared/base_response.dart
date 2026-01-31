// import 'package:jaypee_chat/core/Enums/enums.dart';
// import 'package:jaypee_chat/shared/components/snackbar.dart';
//
// class BaseApiResponse<T> {
//   final ApiStatus status;
//   final T? data;
//   final String message;
//
//   const BaseApiResponse._({
//     required this.status,
//     this.data,
//     required this.message,
//   });
//
//   const BaseApiResponse.initial()
//     : status = ApiStatus.initial,
//       data = null,
//       message = "Fetching Data...";
//
//   const BaseApiResponse.loading()
//     : status = ApiStatus.loading,
//       data = null,
//       message = "Loading...";
//
//   const BaseApiResponse.completed(
//     T this.data, {
//     this.message = "Data fetched successfully",
//   }) : status = ApiStatus.completed;
//
//   const BaseApiResponse.error({
//     this.data,
//     this.message = "Something went wrong.",
//   }) : status = ApiStatus.error;
//
//   static BaseApiResponse<T> noDataFound<T>(String message) {
//     AppSnackBar.warningSnackBar(message: message);
//     return BaseApiResponse<T>.error(message: message);
//   }
// }
