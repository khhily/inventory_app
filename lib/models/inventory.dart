import 'package:hive/hive.dart';
part 'inventory.g.dart';

@HiveType(typeId: 0)
class Inventory extends HiveObject {
  static const String cacheKey = 'inventory_cache_key';
  @HiveField(0)
  final String name;

  @HiveField(1)
  int num;

  @HiveField(2)
  final String unit;

  @HiveField(3)
  DateTime updateTime;

  Inventory({
    required this.name,
    required this.num,
    required this.unit,
    required this.updateTime,
  });
}
