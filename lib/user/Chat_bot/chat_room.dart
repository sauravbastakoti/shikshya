import 'package:flutter/material.dart';
import 'dart:async';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Simulated bot responses based on input (could be expanded with more logic)
  String _getBotResponse(String userMessage) {
    // Convert the user message to lowercase for easier matching
    String message = userMessage.toLowerCase();

    // Check the content of the user message and provide responses accordingly
    if (message.contains('hello') || message.contains('hi')) {
      return "Hi there! How can I assist you today? You can ask me about frontend, backend, or any programming-related questions.";
    } else if (message.contains('course')) {
      return "We offer various courses in Flutter, Dart, React, Node.js, Laravel, and more. Let me know which topic you're interested in!";
    } else if (message.contains('frontend')) {
      return "Frontend technologies we support include React, Flutter, and HTML/CSS. We can help with responsive UIs, state management, and more.";
    } else if (message.contains('backend')) {
      return "For backend development, we cover Laravel, Django, Node.js, and Go. I can assist with API development, databases, and server architecture.";
    } else if (message.contains('laravel')) {
      return "Laravel is a PHP framework for web apps. Need help with routing, controllers, middleware, or Eloquent ORM? I’ve got you covered!";
    } else if (message.contains('django')) {
      return "Django is a high-level Python framework. Let me assist you with views, models, templates, Django REST Framework, or admin panel setup.";
    } else if (message.contains('crypto') || message.contains('blockchain')) {
      return "Interested in blockchain? I can guide you in smart contract development, integrating with Bitcoin/Ethereum, and using Web3 libraries.";
    } else if (message.contains('c programming') ||
        message.contains('c language')) {
      return "C programming is great for performance-critical systems. I can help with pointers, memory management, data structures, and algorithms.";
    } else if (message.contains('react')) {
      return "React is a popular library for building user interfaces. Need help with React hooks, components, Redux, or performance optimization?";
    } else if (message.contains('node')) {
      return "Node.js is ideal for building scalable backends. I can help you with Express.js, MongoDB integration, real-time apps, and async programming.";
    } else if (message.contains('go') || message.contains('golang')) {
      return "Go is a fast and efficient language. Let me guide you with Go routines, channels, web servers, or integrating Go with databases.";
    } else if (message.contains('flutter')) {
      return "Flutter allows you to build cross-platform mobile apps. I can help with widgets, state management (Provider, Riverpod), and performance optimization.";
    } else if (message.contains('database') ||
        message.contains('sql') ||
        message.contains('nosql')) {
      return "Need help with databases? I can assist with SQL databases like MySQL/PostgreSQL, or NoSQL databases like MongoDB and Firebase.";
    } else if (message.contains('api')) {
      return "I can help you design, build, or integrate APIs. Whether it's REST, GraphQL, or gRPC, let me know what you need assistance with!";
    } else if (message.contains('docker')) {
      return "I can help you containerize your apps using Docker, set up Dockerfiles, and manage containers for deployment.";
    } else if (message.contains('cloud') ||
        message.contains('aws') ||
        message.contains('gcp') ||
        message.contains('azure')) {
      return "Need help with cloud deployment? I can guide you with AWS (EC2, S3), Google Cloud Platform, or Microsoft Azure services.";
    } else if (message.contains('devops')) {
      return "Interested in DevOps? I can assist with CI/CD pipelines, version control (Git), Docker, and orchestration tools like Kubernetes.";
    } else if (message.contains('security') ||
        message.contains('authentication') ||
        message.contains('jwt') ||
        message.contains('oauth')) {
      return "I can help with application security, including authentication, JWT, OAuth, and best practices for securing your backend and frontend.";
    } else if (message.contains('testing') ||
        message.contains('unit test') ||
        message.contains('integration test')) {
      return "Testing is critical! I can assist with unit tests, integration tests, or test automation for your applications in various frameworks.";
    } else {
      return "Sorry, I didn't understand that. Can you please rephrase your query? Let me know if you need help with frontend, backend, or any programming-related topics.";
    }
  }

  // Sends a user message and triggers a bot response
  void _sendMessage(String message) {
    if (message.isEmpty) return;

    setState(() {
      _messages.add({
        'message': message,
        'isUser': true,
      });
    });

    // Scroll to bottom
    _scrollToBottom();

    // Simulate bot response after 1 second delay
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'message': _getBotResponse(message),
          'isUser': false,
        });
      });

      _scrollToBottom();
    });

    _messageController.clear();
  }

  // Scroll to the bottom of the message list
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SafeArea(child: Text("Chat Bot")),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_outlined,
                          size: 100,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Start a Conversation",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(10),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Align(
                        alignment: message['isUser']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.7),
                          decoration: BoxDecoration(
                            color: message['isUser']
                                ? Colors.blue[100]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message['message'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _sendMessage(_messageController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
