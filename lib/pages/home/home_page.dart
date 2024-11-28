import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('库存列表'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          // final item = controller.items[index];

          return ListTile(
            title: const Text('Content'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete_rounded),
            ),
          );
        },
        itemCount: controller.items.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '操作',
        child: const Icon(Icons.add),
      ),
    );
  }
}
