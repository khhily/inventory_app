import 'package:get/get.dart';
import 'package:inventory_app/pages/history/history_page.controller.dart';
import 'package:inventory_app/pages/history/history_page.dart';
import 'package:inventory_app/pages/home/home_page.controller.dart';
import 'package:inventory_app/pages/home/home_page.dart';
import 'package:inventory_app/pages/inventory/add_inventory_page.controller.dart';
import 'package:inventory_app/pages/inventory/add_inventory_page.dart';
import 'package:inventory_app/pages/setting/setting_page.controller.dart';
import 'package:inventory_app/pages/setting/setting_page.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: '/',
    page: () => const HomePage(),
    binding: BindingsBuilder(
      () {
        Get.put(HomePageController());
      },
    ),
  ),
  GetPage(
    name: '/add-inventory',
    page: () => const AddInventoryPage(),
    binding: BindingsBuilder(() {
      Get.put(AddInventoryPageController());
    }),
  ),
  GetPage(
    name: '/history',
    page: () => const HistoryPage(),
    binding: BindingsBuilder(() {
      Get.put(HistoryPageController());
    }),
  ),
  GetPage(
    name: '/setting',
    page: () => const SettingPage(),
    binding: BindingsBuilder(() {
      Get.put(SettingPageController());
    }),
  ),
];
