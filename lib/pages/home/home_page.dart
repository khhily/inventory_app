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
      body: Obx(
        () => ListView.builder(
          itemBuilder: (ctx, index) {
            final item = controller.listService.items[index];

            if (index >= controller.listService.items.length) {
              controller.loadMore();
            }

            return ListTile(
              title: Text(item.goodsName),
              trailing: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: item.num.toStringAsFixed(0),
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    const TextSpan(
                      text: '  ',
                    ),
                    TextSpan(
                      text: item.unit.isEmpty ? 'g' : item.unit,
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: controller.listService.items.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addInventory();
        },
        tooltip: '操作',
        child: const Icon(Icons.add),
      ),
    );
  }
}
