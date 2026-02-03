import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/Enums/enums.dart';
import '../../../../shared/app_color.dart';
import '../../../../shared/components/section_header.dart';
import '../../../../shared/constants/png_images.dart';
import '../../domain/entity/profile_entity.dart';
import '../bloc/profileCubit/profile_cubit.dart';
import '../bloc/profileCubit/profile_state.dart';
import '../widgets/profile_build_row.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, });


  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Stack(
            //   alignment: Alignment.center,
            //   children: [
            //     SvgPicture.asset(
            //       SvgImages.profileBg,
            //       fit: BoxFit.cover,
            //       height: size.height * 0.2,
            //       width: size.width,
            //     ),
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         GestureDetector(
            //           onTap: () {
            //             if (data.personalDetails.profileImage.isNotEmpty) {
            //               showDialog(
            //                 context: context,
            //                 builder: (BuildContext context) {
            //                   return Dialog(
            //                     child: SizedBox(
            //                       width: size.width * 0.8,
            //                       height: size.width * 0.8,
            //                       child: Hero(
            //                         tag: 'profileImage',
            //                         child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(12),
            //                           child: Image.memory(
            //                             data.personalDetails.bytes,
            //                             fit: BoxFit.fill,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               );
            //             }
            //           },
            //           child: Hero(
            //             tag: 'profileImage',
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(12),
            //               child: data.personalDetails.profileImage.isNotEmpty
            //                   ? Image.memory(
            //                       data.personalDetails.bytes,
            //                       height: 100,
            //                       width: 100,
            //                       fit: BoxFit.cover,
            //                     )
            //                   : Container(
            //                       height: 100,
            //                       width: 100,
            //                       decoration: BoxDecoration(
            //                         color: AppColors.lightBlue,
            //                         borderRadius: BorderRadius.circular(12),
            //                       ),
            //                       child: Icon(
            //                         Icons.person,
            //                         size: 80,
            //                         color: AppColors.grey600,
            //                       ),
            //                     ),
            //             ),
            //           ),
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           data.personalDetails.name,
            //           style: Theme.of(context)
            //               .textTheme
            //               .titleMedium!
            //               .copyWith(fontWeight: FontWeight.bold),
            //         ),
            //         Text(
            //           data.personalDetails.empCode,
            //           style: Theme.of(context)
            //               .textTheme
            //               .titleSmall!
            //               .copyWith(fontWeight: FontWeight.bold, color: AppColors.grey600),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            // Divider(
            //   thickness: 5,
            //   color: AppColors.grey200,
            //   height: 0,
            // ),
            // BlocBuilder<ProfileCubit, ProfileState>(
            //   builder: (context, state) {
            //     return SizedBox(
            //       height: 50,
            //       child: Row(
            //         children: [
            //           Expanded(
            //             child: InkWell(
            //               onTap: () {
            //                 context.read<ProfileCubit>().changeTab(ProfileTab.values[0]);
            //               },
            //               child: Center(
            //                 child: Text(
            //                   "Personal Info",
            //                   style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //                         color: state.currentTab == ProfileTab.personal
            //                             ? AppColors.primary
            //                             : AppColors.grey700,
            //                       ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           VerticalDivider(
            //             thickness: 2,
            //             color: AppColors.grey200,
            //             width: 0,
            //           ),
            //           Expanded(
            //             child: InkWell(
            //               onTap: () {
            //                 context.read<ProfileCubit>().changeTab(ProfileTab.values[1]);
            //               },
            //               child: Center(
            //                 child: Text(
            //                   "Address info",
            //                   style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //                         color: state.currentTab == ProfileTab.address
            //                             ? AppColors.primary
            //                             : AppColors.grey700,
            //                       ),
            //                 ),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     );
            //   },
            // ),
            // BlocBuilder<ProfileCubit, ProfileState>(
            //   builder: (context, state) {
            //     if (state.currentTab == ProfileTab.personal) {
            //       return _personalInfo();
            //     } else {
            //       return _addressInfo();
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildProfileBoxDecoration() {
    return const BoxDecoration(
      color: Color(0xfff0f0f0),
      borderRadius:
          BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
      border: Border(
        left: BorderSide(color: AppColors.grey, width: 1),
        right: BorderSide(color: AppColors.grey, width: 1),
        bottom: BorderSide(color: AppColors.grey, width: 1),
      ),
    );
  }

  // Widget _personalInfo() {
  //   final PersonalDetailsEntity pDetails = widget.profileData.personalDetails;
  //   final AccountDetailsEntity aDetails = widget.profileData.accountDetails;
  //   final EmergencyContactEntity eDetails = widget.profileData.emergencyContact;
  //   return Column(
  //     children: [
  //       const SectionHeader(
  //         icon: Icons.person,
  //         label: "Personal Details",
  //       ),
  //       Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 8),
  //         decoration: _buildProfileBoxDecoration(),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             ProfileBuildRow("Father's Name", pDetails.fatherName),
  //             ProfileBuildRow("Mother's Name", pDetails.motherName),
  //             ProfileBuildRow("Spouse Name", pDetails.spouseName),
  //             ProfileBuildRow("Aadhaar No", pDetails.aadhaarNo),
  //             ProfileBuildRow("Email", pDetails.email),
  //             ProfileBuildRow("Date of Birth", pDetails.dob),
  //             ProfileBuildRow("Blood Group", pDetails.bloodGroup),
  //             ProfileBuildRow("Gender", pDetails.gender),
  //             ProfileBuildRow("Emp. Code", pDetails.empCode),
  //             ProfileBuildRow("Date of Joining", pDetails.doj),
  //             ProfileBuildRow("Grade", pDetails.grade),
  //             ProfileBuildRow("Designation", pDetails.designation),
  //             ProfileBuildRow("Department", pDetails.department),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       const SectionHeader(
  //         icon: Icons.account_balance,
  //         label: "Account Detail",
  //       ),
  //       Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 8),
  //         decoration: _buildProfileBoxDecoration(),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             ProfileBuildRow("UAN No", aDetails.uanNo),
  //             ProfileBuildRow("PF No.", aDetails.pfNo),
  //             ProfileBuildRow("Bank A/c No.", aDetails.bankAccountNo),
  //             ProfileBuildRow("IFSC Code", aDetails.ifscCode),
  //             ProfileBuildRow("Bank Name", aDetails.bankName),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       const SectionHeader(
  //         icon: Icons.contact_emergency,
  //         label: "Emergency Contact",
  //       ),
  //       Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 8),
  //         decoration: _buildProfileBoxDecoration(),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             ProfileBuildRow("Name", eDetails.name),
  //             ProfileBuildRow("Mobile Number", eDetails.mobile),
  //             ProfileBuildRow("Relation", eDetails.relation),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //     ],
  //   );
  // }
  //
  // Widget _addressInfo() {
  //   final AddressEntity pAddress = widget.profileData.permanentAddress;
  //   final AddressEntity cAddress = widget.profileData.correspondenceAddress;
  //
  //   return Column(
  //     children: [
  //       const SectionHeader(
  //         icon: Icons.location_pin,
  //         label: "Permanent Address",
  //       ),
  //       Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 8),
  //         decoration: _buildProfileBoxDecoration(),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             ProfileBuildRow("Address", pAddress.address),
  //             ProfileBuildRow("District", pAddress.district),
  //             ProfileBuildRow("City", pAddress.city),
  //             ProfileBuildRow("Postal Code ", pAddress.postalCode),
  //             ProfileBuildRow("State", pAddress.state),
  //             ProfileBuildRow("Country", pAddress.country),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       const SectionHeader(
  //         icon: Icons.location_pin,
  //         label: "Correspondence Address",
  //       ),
  //       Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 8),
  //         decoration: _buildProfileBoxDecoration(),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             ProfileBuildRow("Address", cAddress.address),
  //             ProfileBuildRow("District", cAddress.district),
  //             ProfileBuildRow("City", cAddress.city),
  //             ProfileBuildRow("Postal Code ", cAddress.postalCode),
  //             ProfileBuildRow("State", cAddress.state),
  //             ProfileBuildRow("Country", cAddress.country),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //     ],
  //   );
  // }
}
