import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:PhotoAid/common_widgets/common_button.dart';
import 'package:PhotoAid/common_widgets/common_height_sized_box.dart';
import 'package:PhotoAid/common_widgets/common_text_feild.dart';
import 'package:PhotoAid/common_widgets/common_width_sized_box.dart';
import 'package:PhotoAid/config/app_colors.dart';
import 'package:PhotoAid/config/app_icons.dart';
import 'package:PhotoAid/config/app_images.dart';
import 'package:PhotoAid/config/app_size.dart';
import 'package:PhotoAid/config/app_strings.dart';
import 'package:PhotoAid/config/font_family.dart';
import 'package:PhotoAid/controllers/get_started_controller.dart';
import 'package:PhotoAid/view/otp/otp_screen.dart';

class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({super.key});


  final GetStartedController getStartedController =
      Get.put(GetStartedController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;



    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Center(
        child: Container(
          color: AppColors.lightTheme,
          width: kIsWeb ? AppSize.size800 : null,
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(AppSize.size0),
                child: AppBar(
                  backgroundColor: AppColors.lightTheme,
                  elevation: AppSize.size0,
                )),
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(
                  left: AppSize.size20,
                  right: AppSize.size20,
                  bottom: AppSize.size30),
              child: Obx(() => ButtonCommon(
                    onTap: () {
                      getStartedController.isValidPhoneNumber.value
                          ? Get.to(() => OtpScreen())
                          : null;
                    },
                    text: AppStrings.proceed,
                    height: AppSize.size54,
                    buttonColor: getStartedController.isValidPhoneNumber.value
                        ? Color.fromARGB(255, 9, 81, 27) // Change to red when valid
                        : AppColors.smallTextColor,
                  )),
            ),
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
                      AppStrings.letsGetStarted,
                      style: TextStyle(
                        color: AppColors.blackTextColor,
                        fontFamily: FontFamily.latoBold,
                        fontSize: AppSize.size20,
                      ),
                    ),
                  ),
                  const CommonHeightSizedBox(height: AppSize.size12),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: AppSize.size20, right: AppSize.size50),
                    child: Text(
                      AppStrings.thisNumber,
                      style: TextStyle(
                        color: AppColors.smallTextColor,
                        fontFamily: FontFamily.latoRegular,
                        fontSize: AppSize.size12,
                      ),
                    ),
                  ),
                  const CommonHeightSizedBox(height: AppSize.size40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.size20),
                    child: Container(
                      height: AppSize.size54,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: AppSize.size66,
                          spreadRadius: AppSize.size0,
                        )
                      ]),
                      child: CustomTextField(
                        contentPadding: const EdgeInsets.only(bottom: AppSize.size6,top: AppSize.size6),
                        onChanged: (p0) {
                          getStartedController.checkPhoneNumberValidity(p0);
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(AppSize.ten),
                        ],
                        fillFontFamily: FontFamily.latoSemiBold,
                        fillFontSize: AppSize.size14,
                        colorText: AppColors.blackTextColor,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,

                        prefixIcon: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: GestureDetector(
                            onTap: () async {
                              final code = await getStartedController.countryPicker
                                  ?.showPicker(
                                context: context,
                              );
                              if (code != null) {
                                getStartedController.countryCode = code;
                                getStartedController.countryTextController.text =
                                    code.name;
                                getStartedController.isChanged.toggle();
                              }
                            },
                            child: Obx(() => getStartedController.isChanged.value
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(left: AppSize.size16,right: AppSize.size8),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: AppSize.size19,
                                            width: AppSize.size19,
                                            child: getStartedController.countryCode
                                                    ?.flagImage() ??
                                                Image.asset(AppIcons.india)),
                                        const CommonWidthSizedBox(
                                            width: AppSize.size4),
                                        SizedBox(
                                            height: AppSize.size12,
                                            width: AppSize.size12,
                                            child: Center(
                                                child: Image.asset(
                                                    AppIcons.arrowDown))),
                                        const CommonWidthSizedBox(
                                            width: AppSize.size10),
                                        Container(
                                          height: AppSize.size12,
                                          width: AppSize.size1,
                                          decoration: const BoxDecoration(
                                              color: AppColors.smallTextColor),
                                        ),
                                        const CommonWidthSizedBox(
                                            width: AppSize.size10),
                                        Text(
                                            getStartedController
                                                    .countryCode?.dialCode ??
                                                AppStrings.indiaCode,
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        const EdgeInsets.only(left: AppSize.size16,right: AppSize.size8),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: AppSize.size19,
                                            width: AppSize.size19,
                                            child: getStartedController.countryCode
                                                    ?.flagImage() ??
                                                Image.asset(AppIcons.india)),
                                        const CommonWidthSizedBox(
                                            width: AppSize.size4),
                                        SizedBox(
                                            height: AppSize.size12,
                                            width: AppSize.size12,
                                            child: Center(
                                                child: Image.asset(
                                                    AppIcons.arrowDown))),
                                        const CommonWidthSizedBox(
                                            width: AppSize.size10),
                                        Container(
                                          height: AppSize.size12,
                                          width: AppSize.size1,
                                          decoration: const BoxDecoration(
                                              color: AppColors.smallTextColor),
                                        ),
                                        const CommonWidthSizedBox(
                                            width: AppSize.size10),
                                        Text(
                                            getStartedController
                                                    .countryCode?.dialCode ??
                                                AppStrings.indiaCode,
                                            style: const TextStyle(
                                                fontFamily: FontFamily.latoSemiBold,
                                                fontSize: AppSize.size14,
                                                color: AppColors.blackTextColor)),
                                      ],
                                    ),
                                  )),
                          ),
                        ),
                        fillColor: AppColors.backGroundColor,
                        controller: getStartedController.phoneController,
                      ),
                    ),
                  ),
                  const CommonHeightSizedBox(height: AppSize.size60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bgImage(
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      color: AppColors.lightTheme,
      height: height / 3.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(

                left: AppSize.size20,
                bottom: AppSize.size20),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:
                      Image.asset(AppIcons.arrowBack, height: AppSize.size20)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  AppImages.getStartedImage,
                  height: height / AppSize.size4_8,
                ),
                //Positioned(
                  //  bottom: -AppSize.size7,
                  //  right: AppSize.size30,
                  //  child: Image.asset(
                   //   AppImages.starContainer,
                   //   width: kIsWeb ? AppSize.size90 : (width / AppSize.size4_5),
                   // ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
