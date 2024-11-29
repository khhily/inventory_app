import 'package:hive/hive.dart';

class SyncModel extends HiveObject {
  @HiveField(0)
  bool isSyncToDB = false;

  @HiveField(1)
  final DateTime createTime;

  SyncModel({required this.createTime, this.isSyncToDB = false});
}
