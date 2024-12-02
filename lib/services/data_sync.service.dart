import 'package:inventory_app/models/inventory.dart';
import 'package:inventory_app/models/operation_record.dart';
import 'package:inventory_app/models/sync_model.dart';
import 'package:inventory_app/services/data_access.service.dart';
import 'package:inventory_app/services/http.service.dart';

class DataSyncService {
  DataSyncService._();

  static final DataSyncService _instance = DataSyncService._();

  factory DataSyncService() => _instance;

  final DataAccessService dataAccess = DataAccessService();
  final HttpService http = HttpService();

  Future syncData() async {
    final config = await dataAccess.find<SyncModel>(SyncModel.cacheKey,
        key: SyncModel.putKey);

    if (config == null ||
        config.syncUrl == null ||
        config.syncUrl!.isEmpty ||
        config.syncUrl!.trim().isEmpty) return;

    // 提交，然后读取最新数据
    final allList = await dataAccess.getAll(OperationRecord.cacheKey);

    final syncTime = DateTime.now();

    final res = await http.post(
      url: config.syncUrl!.trim(),
      data: {'data': allList.map((e) => e.toJson()).toList(growable: false)},
    );

    final allInventory = (res as List<dynamic>)
        .map((d) => Inventory.fromJson(d))
        .toList(growable: false);

    for (final item in allInventory) {
      dataAccess.update<Inventory>(
        Inventory.cacheKey,
        key: item.name,
        updater: (v) {
          v.num = item.num;
          v.unit = item.unit;
          v.updateTime = item.updateTime;
          return v;
        },
        ifAbsent: () => Inventory(
          name: item.name,
          num: item.num,
          unit: item.unit,
          updateTime: item.updateTime,
        ),
      );
    }

    await dataAccess.delete<OperationRecord>(
      cacheKey: OperationRecord.cacheKey,
      predicator: (r) =>
          r.updateTime.millisecondsSinceEpoch <=
          syncTime.millisecondsSinceEpoch,
    );
    // 提交所有的记录
  }
}
