import 'package:hive/hive.dart';
import 'package:inventory_app/models/operation_record.dart';
import 'package:inventory_app/services/hive_cache.service.dart';

class DataAccessService {
  DataAccessService._();

  static final DataAccessService _instance = DataAccessService._();

  factory DataAccessService() => _instance;

  Future<List<T>> getList<T>(String name, int page, int pageSize) async {
    final list = await HiveCacheService().getList<T>(name, page, pageSize);
    return list;
  }

  Future<List<T>> getAll<T>(String cacheKey) async {
    final list = await HiveCacheService().getAll<T>(cacheKey);
    return list;
  }

  Future<T?> find<T>(String cacheKey,
      {dynamic key, bool Function(T)? predicator}) async {
    final box = await HiveCacheService().getBox<T>(cacheKey);

    if (key != null) {
      return box.get(key);
    } else if (predicator != null) {
      return box.values.firstWhere(predicator);
    }

    return null;
  }

  Future update<T extends HiveObject>(
    String cacheKey, {
    required dynamic key,
    required T Function(T) updater,
    required T Function() ifAbsent,
    OperationRecord Function()? record,
  }) async {
    final box = await HiveCacheService().getBox<T>(cacheKey);
    T? cache = box.get(key);
    if (cache == null) {
      cache = ifAbsent();
      await box.put(key, cache);
    } else {
      updater(cache);
      cache.save();
    }

    if (record != null) {
      await addOperationRecord(record());
    }
  }

  Future addOperationRecord(OperationRecord record) async {
    final box = await HiveCacheService()
        .getBox<OperationRecord>(OperationRecord.cacheKey);
    await box.add(record);
  }

  Future delete<T>({ required String cacheKey, required bool Function(T) predicator }) async {
    final box = await HiveCacheService().getBox<T>(cacheKey);
    final futureList = box.keys.where((k) => predicator(box.get(k) as T)).map<Future>((k) => box.delete(k)).toList(growable: false);
    await Future.wait(futureList);
  }
}
