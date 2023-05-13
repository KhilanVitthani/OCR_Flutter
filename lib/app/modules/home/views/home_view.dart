import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(() {
        return Column(
          children: [
            InkWell(
              onTap: () {
                controller.openGallery();
              },
              child: Center(
                child: Text(
                  'HomeView is working',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Text(
              controller.manifattura.value,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              controller.Ghamla.value,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              controller.venicieNumber.value,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              controller.talMagna.value,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              controller.fuel.value,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              controller.color.value,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              controller.sit.value,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              controller.number.value,
              style: TextStyle(fontSize: 20),
            ),
          ],
        );
      }),
    );
  }
}
