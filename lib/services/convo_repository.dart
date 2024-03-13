import 'package:gemini_gem_shit/message.dart';
import 'package:gemini_gem_shit/providers/convo_provider.dart';

class ConvoRepository {
  ConvoRepository({required this.convoProvider});
  ConvoProvider convoProvider;

  List<Message> readMessages() {
    return convoProvider.readMessages();
  }

  void writeMessages(List<Message> messages) {
    convoProvider.writeMessages(messages);
  }
}
