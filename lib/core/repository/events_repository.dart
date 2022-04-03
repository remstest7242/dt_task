import 'package:dio/dio.dart';
import 'package:news_app_demo/core/data/constants.dart';
import 'package:news_app_demo/core/model/event_row_model.dart';
import 'package:news_app_demo/core/model/pagination_filter.dart';

/// network repository of events
class EventsRepository {
  Dio _dio;

  EventsRepository(
    this._dio,
  );

  // fetching events list over network
  Future<List<EventRowModel>> getEvents(
      PaginationFilter filter, String search) {
    return _dio
        .get(
          URLs.endPointEvents +
              '?client_id=' +
              AppString.apiKey +
              '&per_page=' +
              '${filter.limit}' +
              '&page=' +
              '${filter.page}' +
              '&q=' +
              search,
        )
        .then((value) => value?.data['events'] != null
            ? value?.data['events']
                ?.map<EventRowModel>(
                  (itemVal) => EventRowModel.fromJson(itemVal),
                )
                ?.toList()
            : []);
  }

}
