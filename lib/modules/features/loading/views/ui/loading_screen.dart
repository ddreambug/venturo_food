import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/modules/features/loading/controllers/loading_controller.dart';
import 'package:venturo_food/modules/features/loading/views/components/no_connection.dart';
import 'package:venturo_food/modules/features/loading/views/components/search_location.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key, this.searchLocation = false});
  final bool searchLocation;

  @override
  Widget build(BuildContext context) {
    final loadingController = Get.find<LoadingController>();

    Widget content;

    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return AnimatedPositioned(
              curve: Curves.ease,
              top: loadingController.animationPlay.value ? 20.r : 50.r,
              left: 0,
              right: 0,
              duration: const Duration(seconds: 4),
              child: Center(
                child: Image.asset(
                  ImageConstant.patternBackground,
                  width: 300.w,
                  color: MainColor.primary,
                ),
              ),
            );
          }),

          //ubah widget sesuai kegunaan
          searchLocation
              ? content = const SearchLocation()
              : content = const NoConnection(),
          content
        ],
      ),
    );
  }
}
