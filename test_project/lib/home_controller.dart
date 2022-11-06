import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<int> numbers = [1, 2, 3, 4, 5].obs;

  void restartGame() {
    numbers.addAll([1, 2, 3, 4, 5]);
  }

  void checkCorrectAnswer(data, int acceptType) {
    if (data % 2 == 0) {
      if (acceptType == 1) {
        showSnackbar(
            title: "Status", message: "Correct Answer", color: Colors.green);
      }
      if (acceptType == 0) {
        showSnackbar(
            title: "Status", message: "Incorrect Answer", color: Colors.red);
      }
      numbers.removeWhere((item) => item == data);
    } else if (data % 2 != 0) {
      if (acceptType == 0) {
        showSnackbar(
            title: "Status", message: "Correct Answer", color: Colors.green);
      } else {
        showSnackbar(
            title: "Status", message: "Incorrect Answer", color: Colors.red);
      }
      numbers.removeWhere((item) => item == data);
    }
  }

  void showSnackbar(
      {required String title,
        required String message,
        required Color color}) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}