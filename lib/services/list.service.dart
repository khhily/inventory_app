import 'package:get/get.dart';
import 'package:inventory_app/services/data_access.service.dart';

class ListService<T> {
  int _page = 1;
  final int pageSize;
  final String url;
  final dynamic _condition = {};
  dynamic Function(dynamic)? conditionGenerator;
  final items = <T>[].obs;
  final String cacheKey;

  final refreshing = false.obs;
  final loading = false.obs;

  dynamic _searchCondition;

  ListService(
      {required this.cacheKey,
      required this.url,
      this.pageSize = 20,
      this.conditionGenerator});

  refresh() async {
    if (this.refreshing.value) return;

    this.refreshing.value = true;

    try {
      _searchCondition = this._condition;
      if (this._condition != null && this.conditionGenerator != null) {
        _searchCondition = this.conditionGenerator!.call(_searchCondition);
      }
      this.items.value =
          await DataAccessService().getList<T>(this.cacheKey, this._page, pageSize);
    } finally {
      this.refreshing.value = false;
    }
  }

  loadMore() async {
    if (this.refreshing.value) return;

    if (this.loading.value) return;
    this.loading.value = true;

    try {
      if (this.conditionGenerator != null) {
        _searchCondition = this.conditionGenerator!.call(_searchCondition);
      }
      final list = await DataAccessService().getList<T>(cacheKey, _page + 1, pageSize);
      _page++;
      this.items.addAll(list);
    } finally {
      this.loading.value = false;
    }



  }
}
