import 'package:clientone_ess/core/Enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/routes_name.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6FA),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C3E50)),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF3498DB)),
            onPressed: () {
              Get.toNamed(RoutesName.editProfile);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<ProfileController>(
          builder: (_) {
            if (controller.profileData.status == ApiStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF3498DB)),
              );
            }
            if (controller.profileData.status == ApiStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      controller.profileData.message,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.refreshProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3498DB),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: controller.refreshProfile,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _ProfileHeader(profile: controller.profileData.data!),
                    const SizedBox(height: 24),
                    _PersonalInfoSection(profile: controller.profileData.data!),
                    const SizedBox(height: 24),
                    _WorkInfoSection(profile: controller.profileData.data!),
                    const SizedBox(height: 24),
                    _EmergencyContactSection(profile: controller.profileData.data!),
                    const SizedBox(height: 24),
                    _BankingInfoSection(profile: controller.profileData.data!),
                    const SizedBox(height: 24),
                    _GovernmentInfoSection(profile: controller.profileData.data!),
                    const SizedBox(height: 24),
                    _SettingsSection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final dynamic profile;

  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF3498DB), width: 3),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(profile.profileImage),
              radius: 50,
            ),
          ),
          const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.fullName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              profile.designation,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF7F8C8D),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF3498DB).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                profile.employeeId,
                style: const TextStyle(
                  color: Color(0xFF3498DB),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF3498DB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final String? icon;

  const _InfoRow({
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              icon != null ?  "$icon $label" :   label,
              style: const TextStyle(
                color: Color(0xFF7F8C8D),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF2C3E50),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalInfoSection extends StatelessWidget {
  final dynamic profile;

  const _PersonalInfoSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Personal Information',
      icon: Icons.person,
      children: [
        _InfoRow(label: 'Full Name', value: profile.fullName),
        _InfoRow(label: 'Email', value: profile.email, icon: "✉︎" ),
        _InfoRow(label: 'Phone', value: profile.phone, icon:"✆"),
        _InfoRow(label: 'Date of Birth', value: profile.dateOfBirth),
        _InfoRow(label: 'Gender', value: profile.gender),
        _InfoRow(label: 'Blood Group', value: profile.bloodGroup),
        _InfoRow(label: 'Marital Status', value: profile.maritalStatus),
        _InfoRow(
          label: 'Address',
          value: '${profile.address}, ${profile.city}, ${profile.state} - ${profile.postalCode}',
          icon: "🌍",
        ),
      ],
    );
  }
}

class _WorkInfoSection extends StatelessWidget {
  final dynamic profile;

  const _WorkInfoSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Work Information',
      icon: Icons.work,
      children: [
        _InfoRow(label: 'Department', value: profile.department),
        _InfoRow(label: 'Designation', value: profile.designation),
        _InfoRow(label: 'Date of Joining', value: profile.dateOfJoining),
        _InfoRow(label: 'Employment Type', value: profile.employmentType),
        _InfoRow(label: 'Work Location', value: profile.workLocation),
        _InfoRow(label: 'Reporting Manager', value: profile.manager),
      ],
    );
  }
}

class _EmergencyContactSection extends StatelessWidget {
  final dynamic profile;

  const _EmergencyContactSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Emergency Contact',
      icon: Icons.contact_phone,
      children: [
        _InfoRow(label: 'Name', value: profile.emergencyContactName),
        _InfoRow(label: 'Relation', value: profile.emergencyContactRelation),
        _InfoRow(label: 'Phone', value: profile.emergencyContactPhone),
      ],
    );
  }
}

class _BankingInfoSection extends StatelessWidget {
  final dynamic profile;

  const _BankingInfoSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Banking Information',
      icon: Icons.account_balance,
      children: [
        _InfoRow(label: 'Bank Name', value: profile.bankName),
        _InfoRow(label: 'Account Number', value: profile.bankAccountNumber),
        _InfoRow(label: 'IFSC Code', value: profile.bankIfscCode),
        _InfoRow(label: 'PF Number', value: profile.pfNumber),
        _InfoRow(label: 'ESI Number', value: profile.esiNumber),
      ],
    );
  }
}

class _GovernmentInfoSection extends StatelessWidget {
  final dynamic profile;

  const _GovernmentInfoSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Government IDs',
      icon: Icons.badge,
      children: [
        _InfoRow(label: 'PAN Number', value: profile.panNumber),
        _InfoRow(label: 'Aadhar Number', value: profile.aadharNumber),
      ],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Account Settings',
      icon: Icons.settings,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.lock_outline, color: Color(0xFF3498DB)),
          title: const Text(
            'Change Password',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Color(0xFF7F8C8D)),
          onTap: () {
            Get.toNamed(RoutesName.changePassword);
          },
        ),
      ],
    );
  }
}
