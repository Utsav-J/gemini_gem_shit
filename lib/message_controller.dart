import 'package:gemini_gem_shit/message.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MessageController extends GetxController {
  final messages = RxList<Message>([]);

  @override
  void onInit() {
    super.onInit();
  }

  void addMessage(Message message) {
    messages.add(message);
  }
}
