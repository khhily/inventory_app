import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/operation_type.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'home_page.controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.refresh();
          },
          icon: const Icon(Icons.sync),
        ),
        title: const Text('库存列表'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/history');
            },
            icon: Icon(Icons.history),
          ),
          IconButton(
            onPressed: () {
              controller.addInventory();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(
        () => SmartRefresher(
          physics: const BouncingScrollPhysics(),
          enablePullDown: false,
          enablePullUp: true,
          onRefresh: () async {
            await controller.refresh();
          },
          onLoading: () async {
            await controller.loadMore();
          },
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                return const Text('上拉加载更多');
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("加载失败！单击重试！");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("释放以加载更多");
              } else {
                body = const Text("没有更多数据了");
              }
              return Center(child: body);
            },
          ),
          controller: controller.refreshController,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              final item = controller.listService.items[index];

              return ListTile(
                onTap: () {
                  controller.addInventory(item: item);
                },
                title: Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.indigo,
                  ),
                ),
                trailing: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: item.num.toStringAsFixed(0),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                      const TextSpan(
                        text: '  ',
                      ),
                      TextSpan(
                          text: item.unit.isEmpty ? 'g' : item.unit,
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 16,
                          ))
                    ],
                  ),
                ),
              );
            },
            itemCount: controller.listService.items.length,
          ),
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
