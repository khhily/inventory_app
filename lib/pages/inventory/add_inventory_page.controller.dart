import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/inventory.dart';
import 'package:inventory_app/models/operation_record.dart';
import 'package:inventory_app/models/operation_type.dart';
import 'package:inventory_app/services/data_access.service.dart';
import 'package:uuid/uuid.dart';

class AddInventoryPageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController unitController = TextEditingController(text: 'g');
  final operationType = OperationType.increase.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['operationType'] != null) {
        operationType.value = Get.arguments['operationType'];
      }
      if (Get.arguments['name'] != null) {
        nameController.text = Get.arguments['name'];
      }
    }
    super.onInit();
  }

  void saveAndClose(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text;

      int? count = int.tryParse(numberController.text, radix: 10);
      if (count == null) throw Exception('number format error');

      final operationCount =
          operationType.value == OperationType.increase ? count : (0 - count);

      final unit = unitController.text;
      final dataAccess = DataAccessService();

      await dataAccess.update<Inventory>(
        Inventory.cacheKey,
        key: name,
        updater: (v) {
          v.num += operationCount;
          v.updateTime = DateTime.now();
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
              {'type': operationType.value, 'name': name, 'count': count}),
          updateTime: DateTime.now(),
        ),
      );

      Get.back(result: {
        'name': name,
        'count': count,
      });
    }
  }
}
