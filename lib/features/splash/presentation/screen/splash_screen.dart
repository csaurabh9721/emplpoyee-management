import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import '../../../../shared/app_color.dart';
import '../../../../shared/constants/app_strings.dart';
import '../../../../shared/constants/png_images.dart';
import '../splashBloc/splash_bloc.dart';
import '../splashBloc/splash_events.dart';
import '../splashBloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(const SplashVersionEvent());
    context.read<SplashBloc>().add(const SplashNavigate());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(PngImages.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.2),
              child: Image.asset(PngImages.splashLogo,
                  height: width * 0.7, width: width * 0.7),
            ),
            Column(
              children: [
                Image.asset(PngImages.jilit),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "${AppString.version} ",
                      style: TextStyle(color: AppColors.white, fontSize: 13),
                    ),
                    BlocConsumer<SplashBloc, SplashState>(
                      listener: (context, state) {
                        if (state is SplashLoaded && state.onNavigate) {
                          if (Sessions.isLoggedIn()) {
                            Navigator.pushReplacementNamed(
                                context, RoutesName.landingPage);
                          } else {
                            Navigator.pushReplacementNamed(
                                context, RoutesName.login);
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is SplashLoaded) {
                          return Text(
                            state.version,
                            style: const TextStyle(
                                color: AppColors.white, fontSize: 13),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
                const Text(
                  AppString.designedAndDeveloped,
                  style: TextStyle(color: AppColors.white, fontSize: 15),
                ),
                Text(
                  AppString.jil,
                  style: const TextStyle(color: AppColors.white, fontSize: 15)
                      .copyWith(overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 5),
              ],
            )
          ],
        ),
      ),
    );
  }
}
