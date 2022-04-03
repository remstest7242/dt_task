import 'package:get/get.dart';
import 'package:news_app_demo/core/controller/events_controller.dart';
import 'package:news_app_demo/core/repository/events_repository.dart';

/// defining dependencies of events screen
class EventsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventsRepository(Get.find()));
    Get.lazyPut(() => EventsController(Get.find()));
  }
}
