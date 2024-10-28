import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_appbar.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_bottomnavbar.dart';
import 'package:venturo_food/features/main_menu/views/components/promo_card.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class PromoDetailView extends StatelessWidget {
  const PromoDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    ///variable dari list item
    final arguments = Get.arguments as Map<String, dynamic>;
    final item = arguments['promoItem'];
    final List<String> promoRequirement = item['promo_requirement'];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: const CustomAppbar(
          appBarTitle: 'Promo',
          icon: ImageConstant.promoIcon,
        ),
        bottomNavigationBar: Obx(
          () => CustomBottomnavbar(
            currentIndex: ListController.to.currentNavBarIndex.value,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            SizedBox(
              height: 181.h,
              width: 378.w,
              child: Hero(
                tag: 'promo $item',
                child: PromoCard(
                  onTap: () {},
                  enableShadow: false,
                  promoName: item['promo_name'],
                  promoDesc: item['promo_description'],
                  discountNominal: item['promo_property'],
                  thumbnailUrl: item['promo_thumbnail'],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20.h),
                decoration: const BoxDecoration(
                  color: MainColor.white,
                  borderRadius: BorderRadiusDirectional.vertical(
                      top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(21, 24, 24, 24),
                      blurRadius: 15,
                      spreadRadius: -1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Promo',
                        style: TextStyle(fontSize: 16.h),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        item['promo_description'],
                        style: GoogleTextStyle.w700.copyWith(
                          fontSize: 20.sp,
                          color: MainColor.primary,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const Divider(
                        color: MainColor.grey,
                        thickness: 0.5,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          const Icon(Icons.format_list_bulleted_rounded),
                          SizedBox(width: 10.w),
                          Text(
                            'Syarat dan Ketentuan',
                            style: GoogleTextStyle.w600.copyWith(
                              fontSize: 16.sp,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 300.h,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                          itemCount: promoRequirement.length,
                          itemBuilder: (context, index) {
                            return Text(
                              '- ${promoRequirement[index]}',
                              style: GoogleTextStyle.w400.copyWith(
                                fontSize: 12.sp,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
