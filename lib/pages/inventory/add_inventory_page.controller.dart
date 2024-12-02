import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/inventory.dart';
import 'package:inventory_app/models/operation_record.dart';
import 'package:inventory_app/models/operation_type.dart';
import 'package:inventory_app/services/data_access.service.dart';
import 'package:inventory_app/services/data_sync.service.dart';
import 'package:uuid/uuid.dart';

class AddInventoryPageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController unitController = TextEditingController(text: 'g');
  final operationType = OperationType.increase.obs;
  final nameReadonly = false.obs;
  final dataSync = DataSyncService();

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['operationType'] != null) {
        operationType.value = Get.arguments['operationType'];
      }
      if (Get.arguments['item'] != null) {
        final item = Get.arguments['item'] as Inventory;
        nameController.text = item.name;
        unitController.text = item.unit;
      }
      nameReadonly.value = true;
    }
    super.onInit();
  }

  void saveAndClose(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text.trim();

      int? count = int.tryParse(numberController.text, radix: 10);
      if (count == null) throw Exception('number format error');

      final operationCount =
          operationType.value == OperationType.increase ? count : (0 - count);

      final unit = unitController.text.trim();
      final dataAccess = DataAccessService();

      await dataAccess.update<Inventory>(
        Inventory.cacheKey,
        key: name,
        updater: (v) {
          v.num += operationCount;
          v.updateTime = DateTime.now();
          v.unit = unit;
          return v;
        },
        ifAbsent: () => Inventory(
          name: name,
          num: count,
          unit: unit,
          updateTime: DateTime.now(),
        ),
        record: () => OperationRecord(
          id: const Uuid().v4(),
          type: operationType.value,
          data: json.encode(
              {'type': operationType.value, 'name': name, 'count': count, 'unit': unit }),
          updateTime: DateTime.now(),
        ),
      );

      await dataSync.syncData();

      Get.back(result: {
        'name': name,
        'count': count,
      });
    }
  }
}
