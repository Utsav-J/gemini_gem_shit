import 'dart:convert';

import 'package:gemini_gem_shit/message.dart';
import 'package:gemini_gem_shit/services/storage_services.dart';
import 'package:get/get.dart';

class ConvoProvider {
  final StorageService _box = Get.find<StorageService>();
  List<Message> readMessages() {
    var messages = <Message>[];
    jsonDecode(_box.read('convo').toString())
        .forEach((e) => messages.add(Message.fromJson(e)));
    return messages;
  }

  void writeMessages(List<Message> messages) {
    var writeValue = jsonEncode(messages);
    _box.write('convo', writeValue);
  }
}
