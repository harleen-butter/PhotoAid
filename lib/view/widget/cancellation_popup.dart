import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:PhotoAid/config/app_colors.dart';
import 'package:PhotoAid/config/app_icons.dart';
import 'package:PhotoAid/config/app_size.dart';
import 'package:PhotoAid/config/app_strings.dart';
import 'package:PhotoAid/config/font_family.dart';
import 'package:PhotoAid/view/home/home_screen.dart';

class CancellationPopup extends StatelessWidget {
  const CancellationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSize.size20,
            right: AppSize.size20,
          ),
          child: Container(
            padding: const EdgeInsets.only(
              top: AppSize.size40,
              right: AppSize.size16,
              left: AppSize.size16,
              bottom: AppSize.size40,
            ),
            width: AppSize.size311,
            height: AppSize.size362,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.backGroundColor,
              borderRadius: BorderRadius.circular(AppSize.size16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppIcons.sadEmojiIcon,
                  width: AppSize.size94,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.weSadAboutYourCancellation,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppSize.size16,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.latoBold,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: AppSize.size12,
                        bottom: AppSize.size24,
                      ),
                      child: Text(
                        AppStrings.cancellationString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppSize.size12,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.latoRegular,
                          color: AppColors.smallTextColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => HomeScreen());
                      },
                      child: Container(
                        height: AppSize.size54,
                        decoration: BoxDecoration(
                          color: AppColors.blackTextColor,
                          borderRadius: BorderRadius.circular(AppSize.size10),
                        ),
                        child: const Center(
                          child: Text(
                            AppStrings.done,
                            style: TextStyle(
                              fontSize: AppSize.size16,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.latoSemiBold,
                              color: AppColors.backGroundColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}