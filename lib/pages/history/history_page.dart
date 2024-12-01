import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/pages/history/history_page.controller.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HistoryPage extends GetView<HistoryPageController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('操作记录'),
        centerTitle: true,
      ),
      body: Obx(
        () => SmartRefresher(
          controller: controller.refreshController,
          physics: const BouncingScrollPhysics(),
          enablePullUp: true,
          enablePullDown: true,
          onRefresh: () async {
            await controller.refresh();
          },
          onLoading: () async {
            await controller.loadMore();
          },
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              final item = controller.listService.items[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      item.type,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        item.data,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: controller.listService.items.length,
          ),
        ),
      ),
    );
  }
}
