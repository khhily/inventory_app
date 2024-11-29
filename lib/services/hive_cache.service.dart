import 'package:hive/hive.dart';

class HiveCacheService {
  HiveCacheService._();

  static final HiveCacheService _instance = HiveCacheService._();

  factory HiveCacheService() => _instance;

  final Map<String, dynamic> _boxMap = <String, dynamic>{};

  Future<List<T>> getList<T>(String cacheKey, int page, int pageSize) async {
    final box = await getBox<T>(cacheKey);
    return box.values.skip((page - 1) * pageSize).take(pageSize).toList();
  }

  Future<Box<T>> getBox<T>(String cacheKey) async {
    if (_boxMap.containsKey(cacheKey) && _boxMap[cacheKey]!.isOpen) {
      return _boxMap[cacheKey] as Box<T>;
    }

    final box = await Hive.openBox<T>(cacheKey);

    _boxMap.update(cacheKey, (v) => box, ifAbsent: () => box);

    return _boxMap[cacheKey] as Box<T>;
  }

  Future<List<T>> getAll<T>(String cacheKey) async {
    final box = await getBox<T>(cacheKey);
    return box.values.toList(growable: false);
  }

  Future<T> add<T>(String cacheKey, T obj, { dynamic key }) async {
    final box = await getBox<T>(cacheKey);
    if (key != null) {
      await box.put(key, obj);
      return obj;
    } else {
      await box.add(obj);
      return obj;
    }
  }

  Future<T?> find<T>(String cacheKey,
      {bool Function(T)? predicator, dynamic key}) async {
    final box = await getBox<T>(cacheKey);
    if (predicator != null) {
      return box.values.firstWhere(predicator);
    }

    if (key != null) {
      return box.get(key);
    }

    throw new Exception('predicator和key不能同时为空');
  }
}
