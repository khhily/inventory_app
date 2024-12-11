import 'package:inventory_app/services/data_sync.service.dart';
import 'package:inventory_app/services/http.service.dart';
import 'package:inventory_app/services/sqlite.service.dart';

abstract class ServiceInit {
  static init() async {
    // await HiveCacheService().clearDatabase();
    await SqliteService().init();
    HttpService().init();
    DataSyncService().syncData();
  }
}
