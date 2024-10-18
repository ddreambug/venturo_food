import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_food/features/main_menu/controllers/list_controller.dart';
import 'package:venturo_food/features/main_menu/views/components/custom_bottomnavbar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => CustomBottomnavbar(
          currentIndex: ListController.to.currentNavBarIndex.value,
        ),
      ),
      body: const Center(
        child: Text('ini profil'),
      ),
    );
  }
}
