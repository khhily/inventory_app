// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationRecordAdapter extends TypeAdapter<OperationRecord> {
  @override
  final int typeId = 2;

  @override
  OperationRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OperationRecord(
      id: fields[0] as String,
      type: fields[1] as String,
      data: fields[2] as String,
      updateTime: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, OperationRecord obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationRecord _$OperationRecordFromJson(Map<String, dynamic> json) =>
    OperationRecord(
      id: json['id'] as String,
      type: json['type'] as String,
      data: json['data'] as String,
      updateTime: DateTime.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$OperationRecordToJson(OperationRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'data': instance.data,
      'updateTime': instance.updateTime.toIso8601String(),
    };
