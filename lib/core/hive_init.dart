import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_app/models/goods.dart';
import 'package:inventory_app/models/inventory.dart';

class HiveInitService extends GetxService {
  static init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(GoodsAdapter());
    Hive.registerAdapter(InventoryAdapter());
  }
}