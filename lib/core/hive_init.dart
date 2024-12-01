import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_app/models/inventory.dart';
import 'package:inventory_app/models/operation_record.dart';
import 'package:inventory_app/models/sync_model.dart';

class HiveInitService extends GetxService {
  static init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(InventoryAdapter());
    Hive.registerAdapter(OperationRecordAdapter());
    Hive.registerAdapter(SyncModelAdapter());
  }
}