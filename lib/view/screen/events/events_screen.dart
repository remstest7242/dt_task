import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:news_app_demo/core/controller/events_controller.dart';
import 'package:news_app_demo/core/data/constants.dart';
import 'package:news_app_demo/view/screen/events/event_detail_screen.dart';

/// Showing all events in this screen with paging
class EventsScreen extends StatelessWidget {
  final EventsController _controller;

  const EventsScreen(this._controller, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Color(0xFF00122e),
          middle: CupertinoSearchTextField(
            controller: _controller.textEditingController,
            focusNode: _controller.focusNode,
            autofocus: false,
            onSuffixTap: () {
              _controller.onSearchClear();
            },
            itemColor: Colors.white,
            padding: EdgeInsets.all(4),
            style: TextStyle(
              color: Colors.white,
            ),
            onChanged: (value) {
              _controller.onSearch(value);
            },
            // controller: controller,
          ),
        ),
        child: Obx(() => _getViewBasedOnState()),
      ),
    );
  }

  /* ----------------------------- view setup ------------------------------- */

  // building main view based on states e.g loading, data, error
  _getViewBasedOnState() {
    if (_controller.page == 1) {
      if (!_controller.isOnline)
        return _getViewOfflineMain();
      else if (_controller.isLoading)
        return _getViewLoaderMain();
      else if (_controller.isNoData)
        return _getViewNoDataMain();
      else
        return _getViewList();
    } else {
      return _getViewList();
    }
  }

  // building main offline view
  _getViewOfflineMain() => Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.titleOfflineMsg,
                style: TextStyle(
                    fontSize: AppStyle.sizeTextTitle,
                    color: Colors.red,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 32.0,
              ),
              MaterialButton(
                  elevation: 4,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    AppString.titleRetry,
                    style: TextStyle(
                        color: Colors.white, fontSize: AppStyle.sizeTextTitle),
                  ),
                  onPressed: _onRetry)
            ],
          ),
        ),
      );

  // building main loader view
  _getViewLoaderMain() => Center(
        child: CircularProgressIndicator(),
      );

  // building main no data view
  _getViewNoDataMain() => Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.titleNoData,
                style: TextStyle(
                    fontSize: AppStyle.sizeTextTitle,
                    color: Colors.red,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );

  // building list view
  _getViewList() => Container(
        child: LazyLoadScrollView(
          onEndOfPage: _controller.loadNextPage,
          isLoading: _controller.isLoading || _controller.isLastPage,
          // isLoading: _controller.isLastPage,
          child: ListView.builder(
            itemCount: _controller.events.length,
            itemBuilder: (context, index) {
              return _getViewListItemBasedOnState(index);
            },
          ),
        ),
      );

  // building list item view based on states e.g loading, data, error
  _getViewListItemBasedOnState(int index) {
    if (_controller.events[index].viewType == AppConstants.viewTypeLoader) {
      return _getViewListBottomLoader();
    } else if (_controller.events[index].viewType ==
        AppConstants.viewTypeError) {
      return _getViewListBottomError(_controller.events[index].title);
    } else if (_controller.events[index].viewType ==
        AppConstants.viewTypeNoData) {
      return _getViewListBottomNoData(_controller.events[index].title);
    } else {
      return _getViewListItem(index);
    }
  }

  // building list bottom loader view
  _getViewListBottomLoader() => Material(
        child: Container(
          margin: EdgeInsets.all(8),
          height: 42,
          width: 42,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );

  // building list bottom offline view
  _getViewListBottomError(String title) => Material(
        child: Container(
          margin: EdgeInsets.all(4),
          height: Get.height / 8,
          width: Get.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppStyle.sizeTextTitle,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                MaterialButton(
                    elevation: 2.0,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      AppString.titleRetry,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _onRetry),
              ],
            ),
          ),
        ),
      );

  // building list bottom no data view
  _getViewListBottomNoData(String title) => Material(
        child: Container(
          margin: EdgeInsets.all(4),
          height: Get.height / 12,
          width: Get.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppStyle.sizeTextTitle,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  // building list item view
  _getViewListItem(int index) => Container(
        child: Column(
          children: [
            Material(
              child: InkWell(
                onTap: () {
                  _openDetailPage(index);
                },
                child: Container(
                  margin: EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Hero(
                        tag: _controller.events[index].id,
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          width: Get.width / 4,
                          height: Get.width / 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: _controller.events[index].url,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(4),
                              child: Text(
                                _controller.events[index].title,
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: AppStyle.sizeTextTitle,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              child: Text(
                                _controller.events[index].venue,
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: AppStyle.sizeTextDetail,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              child: Text(
                                _controller.events[index].dateTime,
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: AppStyle.sizeTextDetail,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 2,
            )
          ],
        ),
      );

  /* ----------------------------- actions setup ------------------------------- */

  // on error retry
  void _onRetry() {
    _controller.retryCurrentPage();
  }

  /* ----------------------------- routes setup ------------------------------- */

  /// index - taped item index to passing data to detail page
  /// opening detail page
  _openDetailPage(int index) {
    Get.to(() => EventDetailScreen(_controller.events[index]));
  }
}
