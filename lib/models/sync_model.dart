import 'package:hive/hive.dart';

part 'sync_model.g.dart';

@HiveType(typeId: 1)
class SyncModel extends HiveObject {
  @HiveField(0)
  DateTime syncTime;

  SyncModel({
    required this.syncTime,
  });
}
