import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app_demo/core/data/constants.dart';
import 'package:news_app_demo/core/model/event_row_model.dart';
import 'package:news_app_demo/core/model/pagination_filter.dart';
import 'package:news_app_demo/core/repository/events_repository.dart';

/// controller for events list
class EventsController extends GetxController {
  /* ------------------------ variable declaration -------------------------- */

  TextEditingController textEditingController;
  FocusNode focusNode;

  final EventsRepository _eventsRepository;
  final _events = <EventRowModel>[].obs;
  final _paginationFilter = PaginationFilter().obs;
  final _isLastPage = false.obs;
  final _isLoading = true.obs;
  final _isOnline = false.obs;
  final _isNoData = false.obs;

  EventsController(
    this._eventsRepository,
  );

  /* ------------------------ getters declaration -------------------------- */

  List<EventRowModel> get events => _events.toList();

  int get limit => _paginationFilter.value.limit;

  int get page => _paginationFilter.value.page;

  bool get isLastPage => _isLastPage.value;

  bool get isLoading => _isLoading.value;

  bool get isOnline => _isOnline.value;

  bool get isNoData => _isNoData.value;

  @override
  onInit() {
    textEditingController = TextEditingController();
    focusNode = FocusNode();

    ever(_paginationFilter, (_) => _getEvents());

    _goToPage(
      1,
      AppLimit.PAGE_LIMIT,
    );

    super.onInit();
  }

  /* -------------------------- logic declaration --------------------------- */

  // fetching events list
  Future<void> _getEvents() async {

    if (!_isLastPage.value) {
      _showLoader();

      // fetching internet status
      _isOnline.value = await InternetConnectionChecker().hasConnection;

      // checking internet connection
      if (!_isOnline.value) {
        _hideLoader();

        _showInternetError();
      } else {
        // fetching events list from network
        final eventsData = await _eventsRepository.getEvents(
            _paginationFilter.value,
            textEditingController.text.toString().toLowerCase());

        _hideLoader();

        if (eventsData.isNotEmpty) {
          // adding fetched data to list
          _events.addAll(eventsData);
        } else {
          _showNoDataError();
        }
      }
    }

  }

  // showing loader based on page
  void _showLoader() {
    if (_paginationFilter.value.page > 1) {
      if (_events.last.viewType != AppConstants.viewTypeLoader) {
        _events.add(EventRowModel(AppConstants.viewTypeLoader, ""));
      }
    } else {
      _isLoading.value = true;
    }
  }

  // hiding loader based on page
  void _hideLoader() {
    if (_paginationFilter.value.page > 1) {
      if (_events.last.viewType == AppConstants.viewTypeLoader) {
        _events.removeLast();
      }
    } else {
      _isLoading.value = false;
    }
  }

  // showing internet error based on page
  void _showInternetError() {
    if (_paginationFilter.value.page > 1) {
      if (_events.last.viewType != AppConstants.viewTypeError) {
        _events.add(EventRowModel(
            AppConstants.viewTypeError, AppString.titleOfflineMsg));
      } else {
        _events.removeLast();

        _events.add(EventRowModel(
            AppConstants.viewTypeError, AppString.titleOfflineMsg));
      }
    } else {
      _isOnline.value = false;
    }
  }

  // showing no data based on page
  void _showNoDataError() {
    if (_paginationFilter.value.page > 1) {
      _isLastPage.value = true;

      if (_events.last.viewType != AppConstants.viewTypeNoData) {
        _events.add(EventRowModel(
            AppConstants.viewTypeNoData, AppString.titleNoMoreData));
      } else {
        _events.removeLast();

        _events.add(EventRowModel(
            AppConstants.viewTypeNoData, AppString.titleNoMoreData));
      }
    } else {
      _isNoData.value = true;
    }
  }

  // hiding errors
  void _hideError() {
    _isOnline.value = true;
    _isNoData.value = false;

    if (_paginationFilter.value.page > 1) {
      if (_events.last.viewType == AppConstants.viewTypeError ||
          _events.last.viewType == AppConstants.viewTypeNoData) {
        _events.removeLast();
      }
    }
  }

  /// page - looking to fetch data of page
  /// limit - limit of data to fetch e.g 10 or 20
  /// for go to page e.g get data of page
  void _goToPage(int page, int limit) {
    _paginationFilter.update((val) {
      val.page = page;
      val.limit = limit;
    });
  }

  void onSearch(String value) {
    _events.clear();
    _isLastPage.value = false;
    _hideError();
    _goToPage(
      1,
      AppLimit.PAGE_LIMIT,
    );
  }

  void onSearchClear() {
    focusNode.unfocus();
    textEditingController.clear();
    onSearch("");
  }

  // fetch next page data
  void loadNextPage() => _goToPage(page + 1, limit);

  // retry to fetch current page data
  void retryCurrentPage() {
    _goToPage(page, limit);
  }
}
