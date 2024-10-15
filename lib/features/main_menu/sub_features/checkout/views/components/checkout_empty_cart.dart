import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/cil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutEmptyCart extends StatelessWidget {
  const CheckoutEmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Iconify(
            Cil.face_dead,
            size: 50.w,
          ),
          const Text('Pesanan Kosong!'),
        ],
      ),
    );
  }
}
