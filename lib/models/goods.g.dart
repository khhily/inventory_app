// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoodsAdapter extends TypeAdapter<Goods> {
  @override
  final int typeId = 0;

  @override
  Goods read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Goods(
      name: fields[2] as String,
      description: fields[3] as String?,
      createTime: fields[1] as DateTime,
      isSyncToDB: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Goods obj) {
    writer
      ..writeByte(4)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
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
      other is GoodsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goods _$GoodsFromJson(Map<String, dynamic> json) => Goods(
      name: json['name'] as String,
      description: json['description'] as String?,
      createTime: DateTime.parse(json['createTime'] as String),
      isSyncToDB: json['isSyncToDB'] as bool? ?? false,
    );

Map<String, dynamic> _$GoodsToJson(Goods instance) => <String, dynamic>{
      'isSyncToDB': instance.isSyncToDB,
      'createTime': instance.createTime.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
    };
