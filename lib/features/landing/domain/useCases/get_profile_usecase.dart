import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

abstract class GetProfileUseCase {
  Future<ProfileResponseEntity> call();
}

class GetProfileUseCaseImpl implements GetProfileUseCase {

  GetProfileUseCaseImpl(this.repository);
  final GetProfileRepository repository;

  @override
  Future<ProfileResponseEntity> call() async {
    return await repository.getProfileData();
  }
}
