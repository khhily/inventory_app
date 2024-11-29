import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/goods.dart';
import 'package:inventory_app/models/inventory.dart';
import 'package:inventory_app/services/data_access.service.dart';

class AddInventoryPageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController unitController = TextEditingController(text: 'g');

  void saveAndClose(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text;
      final count = int.tryParse(numberController.text, radix: 10);
      final unit = unitController.text;
      final dataAccess = DataAccessService();

      Goods? good = await dataAccess.find<Goods>(Goods.cacheKey, key: name);

      good ??= await dataAccess.add<Goods>(
          Goods.cacheKey, Goods(name: name, createTime: DateTime.now()),
          key: name);

      Inventory? old = await dataAccess.find(Inventory.cacheKey, key: name);

      old ??= await dataAccess.add<Inventory>(
        Inventory.cacheKey,
        Inventory(goodsName: good.name,
            num: 0,
            createTime: DateTime.now(),
            unit: unit),
        key: name,);

      old.num += count!;

      old.save();

      Get.back(result: {
        'name': name,
        'count': count,
      });
    }
  }
}
