import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/modules/features/list/views/components/custom_appbar.dart';
import 'package:venturo_food/modules/features/list/views/components/custom_bottomnavbar.dart';
import 'package:venturo_food/modules/features/list/views/components/promo_card.dart';

class PromoDetailView extends StatelessWidget {
  const PromoDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    ///variable dari list item
    final arguments = Get.arguments as Map<String, dynamic>;
    final index = arguments['index'];
    final thumbnailUrl = arguments['thumbnailUrl'];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: const CustomAppbar(appBarTitle: 'Promo Detail'),
        bottomNavigationBar: CustomBottomnavbar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            SizedBox(
              height: 150,
              width: 300,
              child: Hero(
                tag: 'promo $index',
                child: PromoCard(
                  onTap: () {},
                  enableShadow: false,
                  promoName: 'Promo $index',
                  discountNominal: '${index * 10}',
                  thumbnailUrl: thumbnailUrl,
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
                        'Berhasil mereferensikan rekan atau teman untuk menjadi karyawan',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: MainColor.primary,
                            fontWeight: FontWeight.w900),
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
                          const Text('Syarat dan Ketentuan')
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                        child: Text(
                          '''Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea vommodo consequat.\n\n Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et''',
                          softWrap: true,
                          style: Theme.of(context).textTheme.labelMedium,
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
