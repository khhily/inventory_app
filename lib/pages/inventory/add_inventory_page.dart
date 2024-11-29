import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_inventory_page.controller.dart';

class AddInventoryPage extends GetView<AddInventoryPageController> {
  const AddInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('货物新增')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: '名称'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.numberController,
                decoration: const InputDecoration(labelText: '数量'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.unitController,
                decoration: const InputDecoration(labelText: '单位'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.saveAndClose(context),
                child: const Text('保存'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
