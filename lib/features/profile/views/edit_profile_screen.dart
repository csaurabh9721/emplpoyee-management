import 'package:clientone_ess/core/Enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6FA),
        elevation: 0,
        title: const Text(
          'Edit Profile',
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
          GetBuilder<EditProfileController>(
            builder: (_) => TextButton(
              onPressed: controller.updateResponse.status == ApiStatus.loading
                  ? null
                  : () {
                      if (controller.validateForm()) {
                        controller.updateProfile();
                      }
                    },
              child: controller.updateResponse.status == ApiStatus.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF3498DB),
                      ),
                    )
                  : const Text(
                      'Save',
                      style: TextStyle(
                        color: Color(0xFF3498DB),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<EditProfileController>(
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
                      onPressed: () => controller.loadProfileData(),
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
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _PersonalInfoSection(),
                  const SizedBox(height: 24),
                  _AddressSection(),
                  const SizedBox(height: 24),
                  _EmergencyContactSection(),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
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

class _PersonalInfoSection extends StatelessWidget {
  final EditProfileController controller = Get.find<EditProfileController>();

  _PersonalInfoSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Personal Information',
      icon: Icons.person,
      children: [
        Row(
          children: [
            Expanded(
                child: _TextField(
              controller: controller.firstNameController,
              label: 'First Name*',
              hint: 'Enter first name',
              maxLines: 1,
            )),
            const SizedBox(width: 12),
            Expanded(
                child: _TextField(
                    controller: controller.lastNameController, label: 'Last Name*', hint: 'Enter last name')),
          ],
        ),
        const SizedBox(height: 16),
        _TextField(
            controller: controller.emailController,
            label: 'Email*',
            hint: 'Enter email address',
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 16),
        _TextField(
            controller: controller.phoneController,
            label: 'Phone*',
            hint: 'Enter phone number',
            keyboardType: TextInputType.phone),
      ],
    );
  }
}

class _AddressSection extends StatelessWidget {
  final EditProfileController controller = Get.find<EditProfileController>();

  _AddressSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Address Information',
      icon: Icons.location_on,
      children: [
        _TextField(controller: controller.addressController, label: 'Street Address', hint: 'Enter street address'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _TextField(controller: controller.cityController, label: 'City', hint: 'Enter city')),
            const SizedBox(width: 12),
            Expanded(child: _TextField(controller: controller.stateController, label: 'State', hint: 'Enter state')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: _TextField(
                    controller: controller.postalCodeController, label: 'Postal Code', hint: 'Enter postal code')),
            const SizedBox(width: 12),
            Expanded(
                child: _TextField(controller: controller.countryController, label: 'Country', hint: 'Enter country')),
          ],
        ),
      ],
    );
  }
}

class _EmergencyContactSection extends StatelessWidget {
  final EditProfileController controller = Get.find<EditProfileController>();

  _EmergencyContactSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Emergency Contact',
      icon: Icons.contact_phone,
      children: [
        _TextField(
            controller: controller.emergencyContactNameController,
            label: 'Contact Name',
            hint: 'Enter emergency contact name'),
        const SizedBox(height: 16),
        _TextField(
            controller: controller.emergencyContactPhoneController,
            label: 'Contact Phone',
            hint: 'Enter emergency contact phone',
            keyboardType: TextInputType.phone),
        const SizedBox(height: 16),
        _TextField(
            controller: controller.emergencyContactRelationController,
            label: 'Relationship',
            hint: 'Enter relationship (e.g., Spouse, Parent)'),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;

  const _TextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF2C3E50),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(
            color: Color(0xFF2C3E50),
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF95A5A6),
              fontSize: 14,
            ),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3498DB), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}
