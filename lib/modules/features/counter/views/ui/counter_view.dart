import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/modules/features/counter/controllers/counter_controller.dart';
import 'package:venturo_food/modules/global_controllers/analytics_controller.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final analyticsController = Get.find<AnalyticsController>();
    analyticsController.setCurrentScreen(screenName: 'Counter Screen');
    analyticsController.logPageView('Counter Page');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColor.primary,
        title: Text(
          "Counter App",
          style: GoogleFonts.roboto(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: MainColor.white,
          ),
        ),
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back),
          color: MainColor.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Jumlah Penambahan",
                style: GoogleFonts.roboto(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      CounterController.to.decrement();
                      analyticsController.logButtonClick('Decrement');
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Obx(
                    () => Text('${CounterController.to.count.value}'),
                  ),
                  IconButton(
                    onPressed: () {
                      CounterController.to.increment();
                      analyticsController.logButtonClick('Increment');
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
