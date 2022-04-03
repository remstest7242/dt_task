/// constants urls of app
class URLs {
  static const String host = 'https://api.seatgeek.com';

  static const String endPointEvents = '/2/events';
}

/// constants page limit & timeout of app
class AppLimit {
  static const int REQUEST_TIME_OUT = 30000;

  static const int PAGE_LIMIT = 20;
}

/// constants string of app
class AppString {
  static const String apiKey = 'MjYzODI0MDB8MTY0ODkwMjc1OC44NDEwMDQ2';

  static const String titleAppName = 'Events App';

  static const String titleList = 'Events App';
  static const String titleDetail = 'Event Detail';

  static const String titleOfflineMsg = "You're offline. Check your connection";
  static const String titleRetry = 'Retry';

  static const String titleInternalError = 'Internal server error';
  static const String titleNoData = 'No data found';
  static const String titleNoMoreData = 'No more data found';

  static const String defaultImage = 'https://seatgeek.com/images/performers-landscape/jacob-collier-a6cdc4/365157/huge.jpg';

  static const String eventDateFormat = 'EEE, dd MMM yyyy hh:mm aaa';
}

/// constants styles of app
class AppStyle {
  static const double sizeTextTitle = 18;
  static const double sizeTextDetail = 14;
}

/// constants of app
class AppConstants {
  static const int viewTypeItem = 1;
  static const int viewTypeLoader = 2;
  static const int viewTypeError = 3;
  static const int viewTypeNoData = 4;
}
