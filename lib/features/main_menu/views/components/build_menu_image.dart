import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildMenuImage extends StatelessWidget {
  const BuildMenuImage({
    super.key,
    required this.idMenu,
    required this.fotoMenu,
  });

  final int idMenu;
  final String? fotoMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.w,
      width: 75.w,
      margin: EdgeInsets.only(right: 12.r, left: 5.w),
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: const Color.fromARGB(255, 223, 223, 223),
      ),
      child: CachedNetworkImage(
        imageUrl: fotoMenu ??
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
        useOldImageOnUrlChange: true,
        errorWidget: (context, url, error) => Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png'),
        color: const Color.fromARGB(255, 223, 223, 223),
        colorBlendMode: BlendMode.darken,
        fit: BoxFit.contain,
      ),
    );
  }
}
