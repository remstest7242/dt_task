import 'package:get/get.dart';
import 'package:news_app_demo/core/bindings/events_binding.dart';
import 'package:news_app_demo/view/screen/events/events_screen.dart';

// setting up routes
final List<GetPage> routes = [
  GetPage(
      name: '/',
      page: () => EventsScreen(Get.find()),
      binding: EventsBindings()),
];
