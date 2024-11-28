import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitService extends GetxService {
  static init() async {
    await Hive.initFlutter();
  }
}