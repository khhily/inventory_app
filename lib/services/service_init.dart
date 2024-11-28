import 'package:get/get.dart';
import 'package:inventory_app/services/data_fetch.service.dart';
import 'package:inventory_app/services/hive_cache.service.dart';

abstract class ServiceInit {
  static init() async {
    Get.put(HiveCacheService(), tag: 'global_hive_cache', permanent: true);
    Get.put(DataFetchService(), tag: 'global_data_fetch', permanent: true);
  }
}