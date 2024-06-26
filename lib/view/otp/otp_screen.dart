import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:PhotoAid/common_widgets/common_height_sized_box.dart';
import 'package:PhotoAid/config/app_colors.dart';
import 'package:PhotoAid/config/app_icons.dart';
import 'package:PhotoAid/config/app_images.dart';
import 'package:PhotoAid/config/app_size.dart';
import 'package:PhotoAid/config/app_strings.dart';
import 'package:PhotoAid/config/font_family.dart';
import 'package:PhotoAid/controllers/get_started_controller.dart';
import 'package:PhotoAid/controllers/otp_controller.dart';
import 'package:PhotoAid/view/location_permission/location_permission_screen.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final OtpController otpController = Get.put(OtpController());
  final GetStartedController getStartedController =
      Get.put(GetStartedController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //   ),
    // );

    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bgImage(context, height, width),
                const CommonHeightSizedBox(height: AppSize.size50),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.size20),
                  child: Text(
                    AppStrings.enterTheOtp,
                    style: TextStyle(
                      color: AppColors.blackTextColor,
                      fontFamily: FontFamily.latoBold,
                      fontSize: AppSize.size20,
                    ),
                  ),
                ),
                const CommonHeightSizedBox(height: AppSize.size12),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppSize.size20, right: AppSize.size50),
                  child: Text(
                    "${AppStrings.weHaveSent}${getStartedController.phoneController.text}",
                    style: const TextStyle(
                      color: AppColors.smallTextColor,
                      fontFamily: FontFamily.latoRegular,
                      fontSize: AppSize.size12,
                    ),
                  ),
                ),
                const CommonHeightSizedBox(height: AppSize.size68),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.size20),
                  child: pinPutField(context),
                ),
                const CommonHeightSizedBox(height: AppSize.size24),
                Obx(() => otpController.isTimerExpired.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSize.size20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              AppStrings.didNotReceive,
                              style: TextStyle(
                                color: AppColors.smallTextColor,
                                fontFamily: FontFamily.latoRegular,
                                fontSize: AppSize.size12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                otpController.resendOTP();
                                otpController.isTimerExpired.value = false;
                              },
                              child: const Text(
                                AppStrings.resendOtp,
                                style: TextStyle(
                                  color: AppColors.blackTextColor,
                                  fontFamily: FontFamily.latoRegular,
                                  fontSize: AppSize.size12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSize.size20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              AppStrings.resendOtpIn,
                              style: TextStyle(
                                  fontFamily: FontFamily.latoRegular,
                                  fontSize: AppSize.size12,
                                  color: AppColors.smallTextColor),
                            ),  Text(
                              "${ otpController.timer.value}s",
                              style: const TextStyle(
                                  fontFamily: FontFamily.latoRegular,
                                  fontSize: AppSize.size12,
                                  color: AppColors.blackTextColor),
                            ),
                          ],
                        ),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pinPutField(context) {
    return Pinput(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      controller: otpController.pinPutController,
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        width: AppSize.size56,
        height: AppSize.size54,
        padding:
            const EdgeInsets.only(left: AppSize.size23, right: AppSize.size23),
        textStyle: TextStyle(
          fontSize: AppSize.size14,
          fontFamily: FontFamily.latoSemiBold,
          color: Theme.of(context).appBarTheme.titleTextStyle?.color,
        ),
        decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: AppSize.size66,
              spreadRadius: AppSize.size0,
            )
          ],
          borderRadius: BorderRadius.circular(AppSize.size10
          ),
          border: Border.all(color: AppColors.borderColor),
        ),
      ),
      onChanged: (value) {
        otpController.otp.value = value;
        if (value.length == 4) {
          Get.to(() => const LocationPermission());
        }
      },
    );
  }

  Widget bgImage(
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      color: AppColors.lightTheme,
      height: height / AppSize.size3_2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: AppSize.size20,
                left: AppSize.size20,
                bottom: AppSize.size30),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                   Get.back();
                   otpController.resendOTP();
                   otpController.isTimerExpired.value = false;
                  },
                  child:
                      Image.asset(AppIcons.arrowBack, height: AppSize.size20)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              AppImages.otpImage,
              height: height / AppSize.size5_2,
            ),
          ),
        ],
      ),
    );
  }
}
