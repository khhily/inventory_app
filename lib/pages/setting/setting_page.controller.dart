import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/sync_model.dart';
import 'package:inventory_app/services/data_access.service.dart';
import 'package:inventory_app/services/data_sync.service.dart';

class SettingPageController extends GetxController {
  final DataAccessService dataAccessService = DataAccessService();

  final TextEditingController urlController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  Future _getData() async {
    final syncModel = await dataAccessService
        .find<SyncModel>(SyncModel.cacheKey, key: SyncModel.putKey);
    if (syncModel != null) {
      urlController.text = syncModel.syncUrl ?? '';
    }
  }

  Future save() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await dataAccessService.update<SyncModel>(
      SyncModel.cacheKey,
      key: SyncModel.putKey,
      updater: (v) {
        if (urlController.text.isEmpty || urlController.text.trim().isEmpty) {
          return v;
        }
        v.syncUrl = urlController.text.trim();
        return v;
      },
      ifAbsent: () => SyncModel(
        syncUrl: urlController.text,
      ),
    );

    await DataSyncService().syncData();
  }
}
