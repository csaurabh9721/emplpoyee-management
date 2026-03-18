//import '../../../core/network/apiClients/get_api_base.dart';
import '../models/profile_model.dart';

class ProfileService {
 // final GetApiBase _apiClient = GetApiBase.instance;

  Future<ProfileModel> getProfileData() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      return ProfileModel(
        employeeId: "EMP001",
        firstName: "Alex",
        lastName: "Johnson",
        email: "alex.johnson@company.com",
        phone: "+91 98765 43210",
        department: "Engineering",
        designation: "Senior Software Engineer",
        dateOfJoining: "15 Jan 2021",
        employmentType: "Full Time",
        workLocation: "Bangalore Office",
        manager: "Sarah Williams",
        profileImage: "https://picsum.photos/seed/alexjohnson/200/200.jpg",
        address: "123, Tech Park Avenue",
        city: "Bangalore",
        state: "Karnataka",
        postalCode: "560001",
        country: "India",
        emergencyContactName: "Emily Johnson",
        emergencyContactPhone: "+91 98765 43211",
        emergencyContactRelation: "Spouse",
        bloodGroup: "O+",
        dateOfBirth: "15 Mar 1990",
        gender: "Male",
        maritalStatus: "Married",
        panNumber: "ABCDE1234F",
        aadharNumber: "1234 5678 9012",
        bankName: "State Bank of India",
        bankAccountNumber: "1234567890123456",
        bankIfscCode: "SBIN0001234",
        pfNumber: "PF1234567890",
        esiNumber: "ESI1234567890",
      );
    } catch (e) {
      throw Exception('Failed to load profile data: $e');
    }
  }
}
