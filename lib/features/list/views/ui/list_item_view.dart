import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/constants/cores/assets/image_constant.dart';
import 'package:venturo_food/features/list/controllers/list_controller.dart';
import 'package:venturo_food/features/list/repositories/list_repository.dart';
import 'package:venturo_food/features/list/views/components/custom_bottomnavbar.dart';
import 'package:venturo_food/features/list/views/components/list_category.dart';
import 'package:venturo_food/features/list/views/components/list_item.dart';
import 'package:venturo_food/features/list/views/components/list_promo.dart';

import '../components/search_app_bar.dart';
import '../components/section_header.dart';

class ListItemView extends StatelessWidget {
  const ListItemView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> promoRepo = ListRepository().promo;
    final listController = ListController.to;

    return SafeArea(
      child: GestureDetector(
        onTap: ListController.to.focusNode.unfocus,
        child: Scaffold(
          backgroundColor: MainColor.white,
          appBar: SearchAppBar(
              onChange: (value) => ListController.to.keyword(value)),
          bottomNavigationBar: Obx(
            () => CustomBottomnavbar(
              currentIndex: listController.currentNavBarIndex.value,
            ),
          ),
          body: NestedScrollView(
              physics: const ClampingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(child: 22.verticalSpace),
                  // list of promo
                  SliverToBoxAdapter(
                    child: SectionHeader(
                      icon: Image.asset(
                        ImageConstant.promoIcon,
                        height: 14.h,
                      ),
                      title: 'Promo Yang Tersedia (${promoRepo.length})',
                      isHeader: true,
                    ),
                  ),
                  SliverToBoxAdapter(child: 22.verticalSpace),
                  const ListPromo(),
                  SliverToBoxAdapter(child: 22.verticalSpace),
                ];
              },
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // List item Header
                  const ListCategory(),
                  SizedBox(height: 10.w),
                  //List Item
                  const ListItem(),
                ],
              )),
        ),
      ),
    );
  }
}
