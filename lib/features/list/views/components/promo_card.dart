import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PromoCard extends StatelessWidget {
  const PromoCard(
      {super.key,
      this.enableShadow,
      required this.promoName,
      required this.discountNominal,
      required this.thumbnailUrl,
      this.width,
      required this.onTap,
      required this.promoDesc});

  final bool? enableShadow;
  final String promoName;
  final String promoDesc;
  final String discountNominal;
  final String thumbnailUrl;
  final double? width;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        width: width ?? 282.w,
        height: 188.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.r),
          image: DecorationImage(
              image: CachedNetworkImageProvider(
                thumbnailUrl,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor.withAlpha(150),
                BlendMode.srcATop,
              )),
          boxShadow: [
            if (enableShadow == true)
              const BoxShadow(
                color: Color.fromARGB(115, 71, 70, 70),
                offset: Offset(0, 2),
                blurRadius: 8,
              ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                softWrap: true,
                textAlign: TextAlign.center,
                TextSpan(
                  text: promoName,
                  style: Get.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: ' $discountNominal',
                      style: Get.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w100,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                promoDesc,
                textAlign: TextAlign.center,
                style: Get.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
