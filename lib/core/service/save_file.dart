import 'dart:io';
import 'dart:typed_data';

import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  FileDownloader([this._isOpenFile = true]);
  final bool _isOpenFile;

  Future<String> _getAppDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final jilitFolder = Directory('${dir.path}/JILIT');

    if (!await jilitFolder.exists()) {
      await jilitFolder.create(recursive: true);
    }

    return jilitFolder.path;
  }

  Future<String> saveFile(Uint8List bytes, String fileName) async {
    try {
      fileName = fileName.replaceAll(RegExp(r'[\\/:"*?<>|]+'), '_');

      final directoryPath = await _getAppDirectory();
      String filePath = '$directoryPath/$fileName';
      final String baseName = fileName.contains('.')
          ? fileName.substring(0, fileName.lastIndexOf('.'))
          : fileName;
      final String extension = fileName.contains('.')
          ? fileName.substring(fileName.lastIndexOf('.'))
          : '';

      int counter = 1;
      while (await File(filePath).exists()) {
        filePath = '$directoryPath/$baseName($counter)$extension';
        counter++;
      }

      final file = File(filePath);
      await file.writeAsBytes(bytes.toList(), flush: true);
      if (_isOpenFile) {
        final result = await OpenFile.open(file.path);
        if (result.type != ResultType.done) {
          throw AppException(
              'File saved, but failed to open: ${result.message}');
        }
      }
      return filePath;
    } catch (e) {
      throw AppException('Failed to save file: $e');
    }
  }
}
