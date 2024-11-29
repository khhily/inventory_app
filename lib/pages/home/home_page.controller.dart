import 'package:get/get.dart';
import 'package:inventory_app/models/inventory.dart';
import 'package:inventory_app/services/list.service.dart';

class HomePageController extends GetxController {
  final listService = ListService<Inventory>(cacheKey: Inventory.cacheKey, url: '');

  @override
  void onInit() {
    super.onInit();
    refresh();
  }

  // 从 Hive 加载数据
  void refresh() async {
    await listService.refresh();
  }

  void loadMore() async {
    await listService.loadMore();
  }

  // 添加新数据
  void addItem(Inventory item) async {
    refresh(); // 重新加载数据
  }

  // 删除数据
  void removeItem(int index) async {
    refresh(); // 重新加载数据
  }

  void addInventory() async {
    await Get.toNamed('/add-inventory');
    refresh();
  }
}
