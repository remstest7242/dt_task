import 'package:news_app_demo/core/data/constants.dart';

class PaginationFilter {
  int page = 1;
  int limit = AppLimit.PAGE_LIMIT;

  @override
  String toString() => 'PaginationFilter(page: $page, limit: $limit)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationFilter && o.page == page && o.limit == limit;
  }

  @override
  int get hashCode => page.hashCode ^ limit.hashCode;
}
