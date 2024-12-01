import 'package:inventory_app/services/hive_cache.service.dart';

abstract class ServiceInit {
  static init() async {
    // await HiveCacheService().clearDatabase();
  }
}
