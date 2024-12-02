import 'package:inventory_app/services/data_sync.service.dart';

abstract class ServiceInit {
  static init() async {
    // await HiveCacheService().clearDatabase();
    DataSyncService().syncData();
  }
}
