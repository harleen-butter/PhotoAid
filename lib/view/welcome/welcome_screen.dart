import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:PhotoAid/common_widgets/common_height_sized_box.dart';
import 'package:PhotoAid/common_widgets/common_width_sized_box.dart';
import 'package:PhotoAid/config/app_colors.dart';
import 'package:PhotoAid/config/app_icons.dart';
import 'package:PhotoAid/config/app_images.dart';
import 'package:PhotoAid/config/app_size.dart';
import 'package:PhotoAid/config/app_strings.dart';
import 'package:PhotoAid/config/font_family.dart';
import 'package:PhotoAid/view/lets_get_started/lets_get_started_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(AppSize.size0),
              child: AppBar(
                backgroundColor: AppColors.backGroundColor,
                elevation: AppSize.size0,
              )),
          backgroundColor: AppColors.backGroundColor,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
                bottom: AppSize.size30,
                right: AppSize.size20,
                left: AppSize.size20),
            child: GestureDetector(  onTap: () {
              Get.to(() => GetStartedScreen());
            },
              child: Container(
                height: AppSize.size54,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 9, 81, 27),
                    borderRadius: BorderRadius.circular(AppSize.size10)),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppStrings.letsGetStarted,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.backGroundColor,
                              fontFamily: FontFamily.latoSemiBold,
                              fontSize: AppSize.size16),
                        ),
                        const CommonWidthSizedBox(
                          width: AppSize.size10,
                        ),
                        Image.asset(
                          AppIcons.arrowRight,
                          height: AppSize.size20,
                          width: AppSize.size20,
                        )
                      ],
                    )),
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * AppSize.size0_65,
                child: Column(
                  children: [
                    const CommonHeightSizedBox(height: AppSize.size20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSize.size50),
                          child: Center(                         
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        //Container(
                        //  height: height / AppSize.size2_5,
                        //  width: double.infinity,
                         // decoration: const BoxDecoration(
                         //     image: DecorationImage(
                         //         image: AssetImage(AppImages.cloud),
                        //          fit: kIsWeb ? BoxFit.fill : BoxFit.contain)),
                       // ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: AppSize.size25,
                                right: AppSize.size25,
                                top: AppSize.size120),
                            height: height / AppSize.size3_2,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImages.carImage),
                                    
                                   // fit: kIsWeb ? BoxFit.contain : BoxFit.fill
                                    ))),
                      ],
                    ),
                  ],
                ),
              ),
              // const Expanded(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: AppSize.size20),
              //     child: Column(
              //       children: [
              //         Column(
              //           children: [
              //             Text(
              //               AppStrings.bookYourRide,
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                   color: Color.fromARGB(255, 26, 72, 129),
              //                   fontFamily: FontFamily.latoMedium,
              //                   fontSize: AppSize.size28),
              //             ),
              //             CommonHeightSizedBox(height: AppSize.size12),
              //             Padding(
              //               padding:
              //                   EdgeInsets.symmetric(horizontal: AppSize.size40),
              //               child: Text(
              //                 AppStrings.loremIpsum,
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                     color: AppColors.smallTextColor,
              //                     fontFamily: FontFamily.latoRegular,
              //                     fontSize: AppSize.size14),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
