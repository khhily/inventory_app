import 'package:get/get.dart';
import 'package:inventory_app/models/operation_record.dart';
import 'package:inventory_app/services/data_access.service.dart';
import 'package:inventory_app/services/list.service.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HistoryPageController extends GetxController {
  final dataAccess = DataAccessService();
  late final ListService<OperationRecord> listService;
  late final RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    listService =
        ListService<OperationRecord>(cacheKey: OperationRecord.cacheKey);
    refreshController = RefreshController(initialRefresh: true);
  }

  // 从 Hive 加载数据
  Future refresh() async {
    try {
      if (listService.refreshing.value) return;
      await listService.refresh();

      refreshController.refreshCompleted(
          resetFooterState: listService.hasMore.value);
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  Future loadMore() async {
    if (listService.loading.value) return;
    try {
      await listService.loadMore();

      if (listService.hasMore.value) {
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
    } catch (e) {
      refreshController.loadFailed();
    }
  }
}
