import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:venturo_food/configs/themes/main_color.dart';
import 'package:venturo_food/shared/widgets/styles/google_text_style.dart';

class OrderDetailCard extends StatelessWidget {
  const OrderDetailCard({
    super.key,
    required this.menu,
  });

  final Map<String, dynamic> menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      child: Material(
        elevation: 1.5,
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.r),
          child: Ink(
            padding: EdgeInsets.all(0.r),
            height: 89.h,
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.darken,
              color: const Color.fromARGB(67, 219, 219, 219),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Colors.transparent,
                width: 2.w,
              ),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      height: 75.w,
                      width: 75.w,
                      margin: EdgeInsets.only(right: 12.r, left: 5.w),
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: const Color.fromARGB(255, 223, 223, 223),
                      ),
                      child: Hero(
                        tag: menu['id_menu'],
                        child: CachedNetworkImage(
                          imageUrl: menu['foto'],
                          useOldImageOnUrlChange: true,
                          color: const Color.fromARGB(255, 223, 223, 223),
                          colorBlendMode: BlendMode.darken,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu['name'],
                              style: GoogleTextStyle.w500
                                  .copyWith(fontSize: 23.sp),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                            Text(
                              'Rp ${NumberFormat('#,###', 'id_ID').format(
                                menu['harga'],
                              )}',
                              style: GoogleTextStyle.w800.copyWith(
                                fontSize: 18.sp,
                                color: MainColor.primary,
                              ),
                            ),
                            Text(
                              menu['catatan'] == 'Tambahkan Catatan'
                                  ? "Normal"
                                  : menu['catatan'],
                              overflow: TextOverflow.ellipsis,
                              style: GoogleTextStyle.w500.copyWith(
                                fontSize: 12.sp,
                                color: MainColor.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Text(
                        '${menu['jumlah']}',
                        style: GoogleTextStyle.w500.copyWith(fontSize: 18.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
