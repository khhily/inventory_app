// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryAdapter extends TypeAdapter<Inventory> {
  @override
  final int typeId = 1;

  @override
  Inventory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Inventory(
      goodsName: fields[2] as String,
      num: fields[3] as int,
      unit: fields[4] as String,
      createTime: fields[1] as DateTime,
      isSyncToDB: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Inventory obj) {
    writer
      ..writeByte(5)
      ..writeByte(2)
      ..write(obj.goodsName)
      ..writeByte(3)
      ..write(obj.num)
      ..writeByte(4)
      ..write(obj.unit)
      ..writeByte(0)
      ..write(obj.isSyncToDB)
      ..writeByte(1)
      ..write(obj.createTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inventory _$InventoryFromJson(Map<String, dynamic> json) => Inventory(
      goodsName: json['goodsName'] as String,
      num: (json['num'] as num).toInt(),
      unit: json['unit'] as String,
      createTime: DateTime.parse(json['createTime'] as String),
      isSyncToDB: json['isSyncToDB'] as bool? ?? false,
    );

Map<String, dynamic> _$InventoryToJson(Inventory instance) => <String, dynamic>{
      'isSyncToDB': instance.isSyncToDB,
      'createTime': instance.createTime.toIso8601String(),
      'goodsName': instance.goodsName,
      'num': instance.num,
      'unit': instance.unit,
    };
