import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'sync_model.dart';

part 'goods.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Goods extends SyncModel {
  static const String cacheKey = "goods_cache_key";

  Goods({
    required this.name,
    this.description,
    required super.createTime,
    super.isSyncToDB,
  });

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String? description;

  factory Goods.fromJson(Map<String, dynamic> map) => _$GoodsFromJson(map);

  Map<String, dynamic> toJson() => _$GoodsToJson(this);
}
