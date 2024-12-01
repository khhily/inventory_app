import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operation_record.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class OperationRecord extends HiveObject {
  static const String cacheKey = 'operation_record_cache_key';
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String type;
  @HiveField(2)
  final String data;
  @HiveField(3)
  DateTime updateTime;

  OperationRecord({
    required this.id,
    required this.type,
    required this.data,
    required this.updateTime,
  });
}
