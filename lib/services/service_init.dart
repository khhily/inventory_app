import 'package:inventory_app/services/data_sync.service.dart';
import 'package:inventory_app/services/http.service.dart';

abstract class ServiceInit {
  static init() async {
    // await HiveCacheService().clearDatabase();
    HttpService().init();
    DataSyncService().syncData();
  }
}
