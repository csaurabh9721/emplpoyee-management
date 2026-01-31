import '../entity/profile_entity.dart';

abstract class GetProfileRepository {
  Future<ProfileResponseEntity> getProfileData();
}