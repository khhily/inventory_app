import 'package:get/get.dart';
import 'package:inventory_app/models/inventory.dart';
import 'package:inventory_app/models/operation_type.dart';
import 'package:inventory_app/services/list.service.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomePageController extends GetxController {
  final listService = ListService<Inventory>(cacheKey: Inventory.cacheKey);

  late final RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: true);
  }

  // 从 Hive 加载数据
  Future refresh() async {
    print('调用refresh');
    try {
      if (listService.refreshing.value) return;
      print('开始刷新数据');
      await listService.refresh();

      final resetFooterState = listService.hasMore.value;

      refreshController.refreshCompleted(resetFooterState: resetFooterState);
    } catch (e) {
      refreshController.refreshFailed();
    }

    print('调用refresh完成');
  }

  Future loadMore() async {
    print('调用loadMore');
    try {
      await listService.loadMore();

      if (!listService.hasMore.value) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      print('调用loadMore完成');
    } catch (e) {
      refreshController.loadFailed();
      rethrow;
    }
  }

// 添加新数据
  void addItem(Inventory item) async {
    refresh(); // 重新加载数据
  }

// 删除数据
  void removeItem(int index) async {
    refresh(); // 重新加载数据
  }

  void addInventory({Inventory? item}) async {
    dynamic arg = null;
    if (item != null) {
      arg = { 'operationType': OperationType.decrease, 'name': item.name };
    }
    await Get.toNamed('/add-inventory', arguments: arg);
    refresh();
  }
}
