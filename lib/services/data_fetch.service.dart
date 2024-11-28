import 'package:get/get.dart';

class DataFetchService extends GetxService {
  DataFetchService._();
  static DataFetchService _instance = DataFetchService._();
  factory DataFetchService() => _instance;
}