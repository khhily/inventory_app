import 'package:get/get.dart';
import 'package:inventory_app/pages/home/home_page.controller.dart';
import 'package:inventory_app/pages/home/home_page.dart';

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
];
