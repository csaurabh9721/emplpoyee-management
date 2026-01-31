import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:clientone_ess/main.dart';

import '../../../../shared/app_color.dart';
import '../../../../shared/components/primary_button.dart';
import '../../../../shared/constants/png_images.dart' show SvgImages;
import '../../domain/entity/dashboard_response_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../bloc/drawerCubit/drawer_cubit.dart';
import '../bloc/drawerCubit/drawer_state.dart';
import '../bloc/landing_bloc.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.routes, this.profileData});
  final List<AppDashboardRoutes> routes;
  final ProfileResponseEntity? profileData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      backgroundColor: AppColors.white,
      width: size.width * 0.8,
      child: Column(
        children: [
          profileData != null
              ? InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    context
                        .read<LandingBloc>()
                        .add(const LandingPageChangeEvent(1));
                  },
                  child: SizedBox(
                    height: size.height * 0.20,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          SvgImages.profileBg,
                          fit: BoxFit.cover,
                          height: size.height * 0.2,
                          width: double.infinity,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: profileData!
                                      .personalDetails.profileImage.isNotEmpty
                                  ? Image.memory(
                                      profileData!.personalDetails.bytes,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: AppColors.lightBlue,
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        size: 50,
                                        color: AppColors.darkBlue,
                                      )),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              profileData!.personalDetails.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              profileData!.personalDetails.empCode,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.grey600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(
                  height: 100,
                ),
          Divider(height: 0, thickness: 5, color: AppColors.grey300),
          BlocProvider(
            create: (context) => DrawerCubit(),
            child: Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  BlocSelector<DrawerCubit, DrawerState, bool>(
                    selector: (state) => state.isEmpSelfExpanded,
                    builder: (context, isExpanded) {
                      return _buildExpandableSection(
                        title: "Employee Self Service",
                        isExpanded: isExpanded,
                        onToggle: () =>
                            context.read<DrawerCubit>().onExpandedEmpSelf(),
                        items: routes,
                      );
                    },
                  ),
                  BlocSelector<DrawerCubit, DrawerState, bool>(
                    selector: (state) => state.isGeneralExpanded,
                    builder: (context, isExpanded) {
                      return _buildExpandableSection(
                        title: "General",
                        isExpanded: isExpanded,
                        onToggle: () =>
                            context.read<DrawerCubit>().onExpandedGeneral(),
                        items: [
                          AppDashboardRoutes(
                              route: '/change_password',
                              name: "Change Password"),
                          AppDashboardRoutes(route: '/logout', name: "Logout"),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required List<AppDashboardRoutes> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 0, thickness: 2, color: AppColors.grey300),
        ListTile(
          leading: const Icon(Icons.list_alt),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
          onTap: onToggle,
        ),
        Divider(height: 0, thickness: 2, color: AppColors.grey300),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            child: Column(
              children: List.generate(
                  items.length,
                  (index) => InkWell(
                        onTap: () async {
                          if (items[index].route == '/logout') {
                            final bool res = await _showConfirmationDialog();
                            if (res) {
                              Sessions.erase();
                              Navigator.pushNamedAndRemoveUntil(
                                  navigatorKey.currentContext!,
                                  RoutesName.login,
                                  (route) => false);
                            }
                          } else {
                            Navigator.pop(navigatorKey.currentContext!);
                            Navigator.pushNamed(navigatorKey.currentContext!,
                                items[index].route);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (index != 0)
                                    Container(
                                      height: 3,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  const Icon(Icons.fiber_manual_record,
                                      size: 16, color: Colors.grey),
                                  if (index != items.length - 1)
                                    Container(
                                      height: 30,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Text(items[index].name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.grey800,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      )),
            ),
          )
      ],
    );
  }

  Future<bool> _showConfirmationDialog() async {
    return await showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) {
            return Dialog(
              insetPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x80E9EFFF),
                          Color(0x80A7B1E9),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: const Text('Confirmation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Do you want to Logout?"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SecondaryButton(
                        width: 80,
                        height: 36,
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        label: "No",
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      PrimaryButton(
                        width: 80,
                        height: 36,
                        color: AppColors.darkBlue,
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                        label: "Yes",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            );
          },
        ) ??
        false;
  }
}
