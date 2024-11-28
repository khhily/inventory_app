import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HiveCacheService extends GetxService {
  HiveCacheService._();
  static HiveCacheService _instance = HiveCacheService._();
  factory HiveCacheService() => _instance;

  final Map<String, Box> _boxMap = new Map<String, Box>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getList<T>(String name) async {

  }

  getBox(String name) async {
    if (_boxMap.containsKey(name)) {

    }
  }
}