import 'dart:io';

import '../../../../core/Enums/enums.dart';

class UploadedFileEntity {

  UploadedFileEntity({required this.name, required this.path, required this.type});
  final File name;
  final String path;
  final FilePickSource type;
}
