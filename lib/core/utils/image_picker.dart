// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../Enums/enums.dart';
// import '../exceptions/api_exceptions.dart';
//
// class FilePickerHelper {
//   static final ImagePicker _imagePicker = ImagePicker();
//
//   static Future<File> pickFile(FilePickSource source) async {
//     try {
//       if (source == FilePickSource.gallery) {
//         final picked = await _imagePicker.pickImage(source: ImageSource.gallery);
//         if (picked != null) {
//           return File(picked.path);
//         } else {
//           throw AppException("Field to pick image");
//         }
//       } else if (source == FilePickSource.camera) {
//         final picked = await _imagePicker.pickImage(source: ImageSource.camera);
//         if (picked != null) {
//           return File(picked.path);
//         } else {
//           throw AppException("Field to pick image");
//         }
//       } else {
//         final result = await FilePicker.platform.pickFiles(
//           type: FileType.custom,
//           allowedExtensions: ['pdf'],
//         );
//         if (result != null && result.files.single.path != null) {
//           return File(result.files.single.path!);
//         } else {
//           throw AppException("Field to pick file");
//         }
//       }
//     } catch (e) {
//       throw AppException(e.toString());
//     }
//   }
// }
