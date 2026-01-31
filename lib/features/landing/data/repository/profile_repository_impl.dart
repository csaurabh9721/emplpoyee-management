import '../../../../core/exceptions/api_exceptions.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../dataSource/profile_source.dart';
import '../models/address_info_model.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements GetProfileRepository {
  ProfileRepositoryImpl(this._remoteSource);

  final ProfileSource _remoteSource;

  @override
  Future<ProfileResponseEntity> getProfileData() async {
    try {
      final ProfileInfo profileInfo = await _getProfileInfo();
      final AddressInfo addressInfo = await _getAddressInfo();
      return _dtoToModel(profileInfo, addressInfo);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<ProfileInfo> _getProfileInfo() async {
    final ProfileInfoModel response = await _remoteSource.getProfileInfo();
    if (response.status != 200) {
      throw AppException(response.message);
    }
    if (response.profileInfo == null) {
      throw AppException("Failed to get Profile info.");
    }
    return response.profileInfo!;
  }

  Future<AddressInfo> _getAddressInfo() async {
    final AddressInfoModel response = await _remoteSource.getAddressInfo();
    if (response.status != 200) {
      throw AppException(response.message);
    }
    if (response.addressInfo == null) {
      throw AppException("Failed to get Address info.");
    }
    return response.addressInfo!;
  }

  ProfileResponseEntity _dtoToModel(ProfileInfo pInfo, AddressInfo aInfo) {
    final PersonalDetailsEntity personalDetails = PersonalDetailsEntity(
      profileImage: pInfo.employeephoto,
      name: pInfo.employeename,
      fatherName: pInfo.fathername,
      motherName: pInfo.mothername,
      spouseName: pInfo.spousename,
      aadhaarNo: pInfo.aadharno,
      email: pInfo.emailid,
      dob: pInfo.dateofbirth,
      bloodGroup: pInfo.bloodgroup,
      gender: pInfo.gender,
      empCode: pInfo.employeecode,
      doj: pInfo.dateofjoining,
      grade: pInfo.gradecode,
      designation: pInfo.designationname,
      department: pInfo.departmentname,
    );

    final AccountDetailsEntity accountDetails = AccountDetailsEntity(
        uanNo: pInfo.uanno,
        pfNo: pInfo.pfnumber,
        bankAccountNo: pInfo.bankaccountno,
        ifscCode: pInfo.ifsccode,
        bankName: pInfo.bankname);
    final EmergencyContactEntity emergencyContact = EmergencyContactEntity(
        name: pInfo.emergencycontactname,
        mobile: pInfo.emergencycontactnumber,
        relation: pInfo.emergencycontactrelationship);

    final AddressEntity permanentAddress = AddressEntity(
      address: (aInfo.permanentaddress1.isNotEmpty ? "${aInfo.permanentaddress1}," : "") +
          (aInfo.permanentaddress2.isNotEmpty ? " ${aInfo.permanentaddress2}," : "") +
          (aInfo.permanentaddress3.isNotEmpty ? " ${aInfo.permanentaddress3}" : ""),
      district: aInfo.permanentdistrict,
      city: aInfo.permanentdistrict,
      postalCode: aInfo.permanentpin.toString(),
      state: aInfo.permanentstatename,
      country: aInfo.permanentcountryname,
    );

    final AddressEntity currentAddress = AddressEntity(
      address: (aInfo.currentaddress1.isNotEmpty ? "${aInfo.currentaddress1}," : "") +
          (aInfo.currentaddress2.isNotEmpty ? " ${aInfo.currentaddress2}," : "") +
          (aInfo.currentaddress3.isNotEmpty ? " ${aInfo.currentaddress3}" : ""),
      district: aInfo.currentdistrict,
      city: aInfo.currentdistrict,
      postalCode: aInfo.currentpin.toString(),
      state: aInfo.currentstatename,
      country: aInfo.currentcountryname,
    );

    return ProfileResponseEntity(
        userId: "",
        personalDetails: personalDetails,
        accountDetails: accountDetails,
        emergencyContact: emergencyContact,
        permanentAddress: permanentAddress,
        correspondenceAddress: currentAddress);
  }
}
