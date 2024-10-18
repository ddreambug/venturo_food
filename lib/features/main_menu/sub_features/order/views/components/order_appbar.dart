import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_food/features/main_menu/sub_features/order/controllers/order_controller.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class OrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OrderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 68.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.r),
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 10,
                spreadRadius: -2,
                offset: Offset(0, -1)),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: TabBar(
          controller: OrderController.to.tabController,
          tabs: const [
            Tab(text: 'Sedang Berjalan'),
            Tab(text: 'Riwayat'),
          ],
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 1.w,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.black,
          labelStyle: GoogleTextStyle.w600.copyWith(fontSize: 16.sp),
          indicatorPadding: EdgeInsets.only(
            bottom: 15.w,
            right: 35.w,
            left: 35.w,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: (value) => OrderController.to.orderAppbarValue.value = value,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
