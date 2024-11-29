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

  Future<T> add<T>(String cacheKey, T obj, { dynamic key }) async {
    return await HiveCacheService().add(cacheKey, obj, key: key);
  }

  Future<T?> find<T>(String cacheKey, { dynamic key, bool Function(T)? predicator }) async {
    return await HiveCacheService().find(cacheKey, predicator: predicator, key: key);
  }
}
