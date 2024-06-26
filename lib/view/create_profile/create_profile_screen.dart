import 'package:PhotoAid/view/destination/select_route_with_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
import 'package:PhotoAid/controllers/create_profile_controller.dart';
import 'package:PhotoAid/controllers/home_controller.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CreateProfileScreen extends StatelessWidget {
  CreateProfileScreen({super.key});
  final HomeController homeController=Get.put(HomeController());
  final CreateProfileController createProfileController =
      Get.put(CreateProfileController());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController enterCode = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

   void saveProfileData() async {
   try {
      // Collect data from TextControllers or any other inputs
      var fullName = phoneController.text.trim(); // Assuming phoneController is for full name as in your form
      var email = enterCode.text.trim();
      var gender = createProfileController.male.value
          ? "male"
          : createProfileController.female.value
            ? "female"
            : "other";

      // Create a map of data to be saved
      Map<String, dynamic> profileData = {
        'fullName': fullName,
        'email': email,
        'gender': gender,
      };

      // Save data to Firestore
      await firestore.collection('profiles').add(profileData);
      Get.to(() => SelectRouteWithMapScreen()); // Navigate after saving data
    } catch (e) {
      print("Error saving data: $e");
      // Optionally handle errors or show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(AppSize.size0),
                child: AppBar(
                  backgroundColor: AppColors.lightTheme,
                  elevation: AppSize.size0,
                )),
            body: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bgImage(context, height, width),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonHeightSizedBox(
                                      height: height / AppSize.fifteen),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppSize.size20),
                                    child: Text(
                                      AppStrings.createYourProfile,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.blackTextColor,
                                        fontFamily: FontFamily.latoBold,
                                        fontSize: AppSize.size20,
                                      ),
                                    ),
                                  ),
                                  CommonHeightSizedBox(
                                      height: height / AppSize.seventy),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppSize.size20),
                                    child: Text(
                                      AppStrings.pleaseCreateYourAccount,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.smallTextColor,
                                        fontFamily: FontFamily.latoRegular,
                                        fontSize: AppSize.size12,
                                      ),
                                    ),
                                  ),
                                  CommonHeightSizedBox(
                                      height: height / AppSize.size20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppSize.size20),
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
                                        prefixIcon: const SizedBox(
                                          width: AppSize.size16,
                                        ),
                                        prefixIconConstraints: const BoxConstraints(
                                          minWidth: AppSize.size16,
                                        ),
                                        hintColor: AppColors.smallTextColor,
                                        fontFamily: FontFamily.latoRegular,
                                        fontSize: AppSize.size14,
                                        hintText: AppStrings.enterFullName,
                                        fillFontFamily: FontFamily.latoSemiBold,
                                        fillFontSize: AppSize.size14,
                                        colorText: AppColors.blackTextColor,
                                        textInputAction: TextInputAction.done,
                                        fillColor: AppColors.backGroundColor,
                                        controller: phoneController,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CommonHeightSizedBox(height: height / AppSize.size60),
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: AppSize.size20),
                            child: Text(
                              AppStrings.gender,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.smallTextColor,
                                fontFamily: FontFamily.latoRegular,
                                fontSize: AppSize.size14,
                              ),
                            ),
                          ),
                          CommonHeightSizedBox(height: height / AppSize.size70),
                          _buildGenderRow(),
                          CommonHeightSizedBox(height: height / AppSize.size35),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.size20),
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
                                prefixIcon: const SizedBox(
                                  width: AppSize.size16,
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  minWidth: AppSize.size16,
                                ),
                                hintColor: AppColors.smallTextColor,
                                fontFamily: FontFamily.latoRegular,
                                fontSize: AppSize.size14,
                                hintText: AppStrings.enterEmail,
                                fillFontFamily: FontFamily.latoSemiBold,
                                fillFontSize: AppSize.size14,
                                colorText: AppColors.blackTextColor,
                                textInputAction: TextInputAction.done,
                                fillColor: AppColors.backGroundColor,
                                controller: enterCode,
                              ),
                            ),
                          ),
                          CommonHeightSizedBox(height: height / AppSize.size50),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.size20),
                            child: Row(
                              children: [
                                // Obx(
                                //   () => Container(
                                //     height: AppSize.size16,
                                //     width: AppSize.size16,
                                //     decoration: BoxDecoration(
                                //         borderRadius:
                                //             BorderRadius.circular(AppSize.size4)),
                                //     child: Checkbox(
                                //       value: createProfileController.check.value,
                                //       onChanged: (value) {
                                //         createProfileController.check.toggle();
                                //       },
                                //       checkColor: AppColors.backGroundColor,
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(AppSize.size4)),
                                //       activeColor: Color.fromARGB(255, 9, 81, 27),
                                //     ),
                                //   ),
                                // ),
                                const CommonWidthSizedBox(width: AppSize.size10),
                                // const Text(
                                //   AppStrings.receiveImportantUpdates,
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //     color: AppColors.blackTextColor,
                                //     fontFamily: FontFamily.latoMedium,
                                //     fontSize: AppSize.size14,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height / AppSize.size15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: AppSize.size20,
                                right: AppSize.size20,
                                bottom: AppSize.size20),
                            child: ButtonCommon(
                              onTap: saveProfileData,
                              text: AppStrings.proceed,
                              height: AppSize.size54,
                              buttonColor: Color.fromARGB(255, 9, 81, 27),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }

  Padding _buildGenderRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.size20),
      child: Row(
        children: [
          Obx(
            () => Expanded(
              child: GestureDetector(
                onTap: () {
                  createProfileController.male.value = true;
                  createProfileController.female.value = false;
                  createProfileController.other.value = false;
                },
                child: Container(
                  height: AppSize.size44,
                  decoration: BoxDecoration(
                      color: AppColors.backGroundColor,
                      border: Border.all(
                          color: createProfileController.male.value
                              ? Color.fromARGB(255, 9, 81, 27)
                              : AppColors.borderColor,
                          width: AppSize.size1),
                      borderRadius: BorderRadius.circular(AppSize.size8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: AppSize.size66,
                          spreadRadius: AppSize.size0,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      AppStrings.male,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: createProfileController.male.value
                            ? Color.fromARGB(255, 9, 81, 27)
                            : AppColors.blackTextColor,
                        fontFamily: FontFamily.latoRegular,
                        fontSize: AppSize.size14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const CommonWidthSizedBox(width: AppSize.size19),
          Obx(
            () => Expanded(
                child: GestureDetector(
                    onTap: () {
                      createProfileController.male.value = false;
                      createProfileController.female.value = true;
                      createProfileController.other.value = false;
                    },
                    child: Container(
                      height: AppSize.size44,
                      decoration: BoxDecoration(
                          color: AppColors.backGroundColor,
                          border: Border.all(
                              color: createProfileController.female.value
                                  ? Color.fromARGB(255, 9, 81, 27)
                                  : AppColors.borderColor,
                              width: AppSize.size1),
                          borderRadius: BorderRadius.circular(AppSize.size8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: AppSize.size66,
                              spreadRadius: AppSize.size0,
                            )
                          ]),
                      child: Center(
                        child: Text(
                          AppStrings.female,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: createProfileController.female.value
                                ? Color.fromARGB(255, 9, 81, 27)
                                : AppColors.blackTextColor,
                            fontFamily: FontFamily.latoRegular,
                            fontSize: AppSize.size14,
                          ),
                        ),
                      ),
                    ))),
          ),
          const CommonWidthSizedBox(width: AppSize.size19),
          Obx(() => Expanded(
                child: GestureDetector(
                  onTap: () {
                    createProfileController.male.value = false;
                    createProfileController.female.value = false;
                    createProfileController.other.value = true;
                  },
                  child: Container(
                    height: AppSize.size44,
                    decoration: BoxDecoration(
                        color: AppColors.backGroundColor,
                        border: Border.all(
                            color: createProfileController.other.value
                                ? Color.fromARGB(255, 9, 81, 27)
                                : AppColors.borderColor,
                            width: AppSize.size1),
                        borderRadius: BorderRadius.circular(AppSize.size8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: AppSize.size66,
                            spreadRadius: AppSize.size0,
                          )
                        ]),
                    child: Center(
                      child: Text(
                        AppStrings.other,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: createProfileController.other.value
                              ? Color.fromARGB(255, 9, 81, 27)
                              : AppColors.blackTextColor,
                          fontFamily: FontFamily.latoRegular,
                          fontSize: AppSize.size14,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
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
      height: height / AppSize.size3And5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: AppSize.size20, bottom: AppSize.size30),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child:
                      Image.asset(AppIcons.arrowBack, height: AppSize.size20)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              AppImages.createProfileImage,
              height: height / AppSize.size5and2,
            ),
          ),
        ],
      ),
    );
  }
}
