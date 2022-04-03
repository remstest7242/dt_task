import 'package:intl/intl.dart';
import 'package:news_app_demo/core/data/constants.dart';
import 'package:news_app_demo/core/model/event_performer_row_model.dart';
import 'package:news_app_demo/core/model/event_venue_row_model.dart';

/// event details data model
class EventRowModel {
  // using to manage view type of list item
  int viewType = AppConstants.viewTypeItem;

  int id = -1;
  String title = "";
  String dateTimeUtc = "";
  EventVenueRowModel rowModelVenue = EventVenueRowModel();

  List<EventPerformerRowModel> listPerformer = [];

  EventRowModel(this.viewType, this.title);

  // parsing json data to object class
  EventRowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : -1;
    title = json['title'] != null ? json['title'] : "";
    dateTimeUtc = json['datetime_utc'] != null ? json['datetime_utc'] : "";

    rowModelVenue = json['venue'] != null
        ? EventVenueRowModel.fromJson(json['venue'])
        : EventVenueRowModel();

    listPerformer = json['performers'] != null
        ? json['performers']
            ?.map<EventPerformerRowModel>(
              (itemVal) => EventPerformerRowModel.fromJson(itemVal),
            )
            ?.toList()
        : listPerformer = [];
  }

  // parsing object class to json data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['datetime_utc'] = this.dateTimeUtc;
    return data;
  }

  /* ------------------------ getters declaration -------------------------- */

  String get url => listPerformer.length > 0 &&
          listPerformer[0].image != null &&
          listPerformer[0].image.isNotEmpty
      ? listPerformer[0].image
      : AppString.defaultImage;

  String get venue => rowModelVenue.displayLocation != null &&
          rowModelVenue.displayLocation.isNotEmpty
      ? rowModelVenue.displayLocation
      : "";

  String get dateTime => dateTimeUtc != null && dateTimeUtc.isNotEmpty
      ? getFormattedDate(dateTimeUtc)
      : "";

  getFormattedDate(String dateTimeUtc) {
    var strToDateTime = DateTime.parse(dateTimeUtc.toString());
    final convertLocal = strToDateTime.toLocal();
    var newFormat = DateFormat(AppString.eventDateFormat);
    String updatedDt = newFormat.format(convertLocal);
    return updatedDt;
  }
}
