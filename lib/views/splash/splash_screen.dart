import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/splash/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashViewModel splashViewModel = Get.put(SplashViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.imagesBgSplash,
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.center,
            child: Obx(
              () => AnimatedOpacity(
                opacity: splashViewModel.isShow.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Image.asset(
                  Assets.imagesLogo,
                  width: 60.w,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextBodyMedium(
              text: StringConstants.copyright,
            ),
          ),
        ],
      ),
    );
  }
}
