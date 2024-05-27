import 'dart:async';

import 'package:get/get.dart';
import 'package:PhotoAid/config/app_strings.dart';

class BookCarController extends GetxController {
  RxBool isBookingOpen = false.obs;
  RxBool isDriverSearch = false.obs;
  RxString appBarTitle = AppStrings.requestPhotographer.obs;
  Timer? _timer;

  void toggleBooking() {
    isBookingOpen.value = !isBookingOpen.value;

    if (!isDriverSearch.value && !isBookingOpen.value) {
      appBarTitle.value = AppStrings.requestPhotographer;
    } else if (isBookingOpen.value) {
      appBarTitle.value =AppStrings.requestPhotographer;
    }
  }

  void toggleDriver() {
    isDriverSearch.value = !isDriverSearch.value;

    if (!isDriverSearch.value && !isBookingOpen.value) {
      appBarTitle.value = AppStrings.requestPhotographer;
    } else if (isDriverSearch.value) {
      appBarTitle.value = AppStrings.requestPhotographer;
    }
  }

  void startTimerAndToggleBooking() {
    _timer = Timer(const Duration(seconds: 10), () {
      isBookingOpen.value = false;
      isDriverSearch.value = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}