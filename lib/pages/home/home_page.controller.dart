import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:inventory_app/models/goods.dart';

class HomePageController extends GetxController {
  var items = <Goods>[].obs; // 数据列表，使用 Rx 监听
  Box<Goods>? _box;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  // 从 Hive 加载数据
  void loadData() async {
    final box = await _openBox('myBox');
    items.value = box.values.toList();
  }

  // 添加新数据
  void addItem(Goods item) async {
    final box = await _openBox('myBox');
    await box.add(item);
    loadData(); // 重新加载数据
  }

  // 删除数据
  void removeItem(int index) async {
    final box = await _openBox('myBox');
    await box.deleteAt(index);
    loadData(); // 重新加载数据
  }

  Future<Box<Goods>> _openBox(String name) async {
    if (_box != null && _box!.isOpen) return _box!;

    return _box = await Hive.openBox<Goods>(name);
  }
}
