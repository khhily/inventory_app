import 'package:hive/hive.dart';
import 'package:inventory_app/models/sync_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Inventory extends SyncModel {
  static const String cacheKey = 'inventory_cache_key';
  @HiveField(2)
  final String goodsName;
  
  @HiveField(3)
  int num;
  
  @HiveField(4)
  final String unit;

  Inventory({required this.goodsName, required this.num, required this.unit, required super.createTime, super.isSyncToDB = false });

  factory Inventory.fromJson(Map<String, dynamic> map) => _$InventoryFromJson(map);

  Map<String, dynamic> toJson() => _$InventoryToJson(this);
}