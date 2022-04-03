import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_demo/core/data/constants.dart';
import 'package:news_app_demo/core/model/event_row_model.dart';

/// Showing details of events in this screen
class EventDetailScreen extends StatelessWidget {
  final EventRowModel _details;

  const EventDetailScreen(this._details, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(_details.title),
        ),
        child: _getViewDetail(),
      ),
    );
  }

  /* ----------------------------- view setup ------------------------------- */

  // building detail page view
  _getViewDetail() => Container(
        margin: EdgeInsets.all(4),
        child: Column(
          children: [
            SizedBox(
              height: 4,
            ),
            Divider(
              color: Colors.grey,
              height: 2,
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              margin: EdgeInsets.all(4),
              child: Material(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: _details.id,
                        child: Container(
                          width: Get.width,
                          height: Get.height / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: _details.url,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(4),
                              child: Text(
                                _details.dateTime,
                                style: TextStyle(
                                    fontSize: AppStyle.sizeTextTitle,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              child: Text(
                                _details.venue,
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
          ],
        ),
      );
}
