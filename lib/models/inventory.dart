import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'inventory.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Inventory extends HiveObject {
  static const String cacheKey = 'inventory_cache_key';
  @HiveField(0)
  final String name;

  @HiveField(1)
  int num;

  @HiveField(2)
  String unit;

  @HiveField(3)
  DateTime updateTime;

  Inventory({
    required this.name,
    required this.num,
    required this.unit,
    required this.updateTime,
  });

  factory Inventory.fromJson(Map<String, dynamic> map) => _$InventoryFromJson(map);

  Map<String, dynamic> toJson() => _$InventoryToJson(this);
}
