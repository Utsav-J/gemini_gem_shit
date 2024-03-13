import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:gemini_gem_shit/message.dart';
import 'package:gemini_gem_shit/message_controller.dart';
import 'package:gemini_gem_shit/secrets/secrets.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static const apiKey = Secrets.apiKey;
  final MessageController msg = Get.put(MessageController());
  final TextEditingController promptController = TextEditingController();
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);

  Future<void> sendMessage(TextEditingController promptController) async {
    // promptController.
    final message = promptController.text;

    msg.addMessage(Message(
      isUser: true,
      message: message,
      date: DateFormat("HH:mm").format(DateTime.now()),
    ));
    promptController.clear();

    final prompt = [Content.text(message)];
    final response = await model.generateContent(prompt);

    msg.addMessage(Message(
      isUser: false,
      message: response.text ?? " ",
      date: DateFormat("HH:mm").format(DateTime.now()),
    ));
  }

  @override
  Widget build(context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => Scaffold(
            appBar: AppBar(
              title: const Text(
                "Gemini or wot",
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: msg.messages.length,
                    itemBuilder: (context, index) {
                      final message = msg.messages[index];
                      return Message(
                          isUser: message.isUser,
                          message: message.message,
                          date: message.date);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          // style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            // focusedBorder: const OutlineInputBorder(),
                            label: const Text("Enter prompt"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                          ),
                          controller: promptController,
                          cursorColor: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          sendMessage(promptController);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.deepPurpleAccent,
                          radius: 25.r,
                          child: const Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
