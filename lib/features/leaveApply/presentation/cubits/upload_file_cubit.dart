
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/upload_file_entity.dart';

@immutable
class UploadFileState {

  const UploadFileState([this.uploadedFile]);
  final UploadedFileEntity? uploadedFile;
}

class UploadFileCubit extends Cubit<UploadFileState> {
  UploadFileCubit() : super(const UploadFileState());

  // Future<void> uploadFile(FilePickSource source) async {
  //   try {
  //     // File? file = await FilePickerHelper.pickFile(source);
  //     // UploadedFileEntity uploadedFile =
  //     //     UploadedFileEntity(name: file, path: file.path, type: source);
  //     emit(UploadFileState(uploadedFile));
  //   } catch (e) {
  //     emit(UploadFileState(null));
  //   }
  // }
}
