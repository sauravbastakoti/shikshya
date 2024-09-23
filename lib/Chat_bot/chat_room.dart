import 'package:flutter/material.dart';
import 'package:sikshya/Chat_bot/message.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 800,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Messages",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250,
              ),
              Center(
                  child: Column(
                children: [
                  Icon(
                    Icons.chat_outlined,
                    size: 100,
                  ),
                  Text(
                    "Start a Conversation",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  )
                ],
              )),
              Padding(padding: const EdgeInsets.fromLTRB(50, 200, 50, 50)),
              Center(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Message()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          "Start a New Chat",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.send),
                      ])),
                ),
              ),
            ])));
  }
}
