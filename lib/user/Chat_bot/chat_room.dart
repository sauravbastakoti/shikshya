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
  String _getBotResponse(String userMessage) {
    // Convert the user message to lowercase for easier matching
    String message = userMessage.toLowerCase();

    // Check the content of the user message and provide responses accordingly
    if (message.contains('hello') || message.contains('hi')) {
      return "Hello! I'm here to assist you with anything programming-related, whether it's frontend, backend, DevOps, databases, or even machine learning. Ask me anything!";
    } else if (message.contains('course') ||
        message.contains('learning') ||
        message.contains('tutorial')) {
      return "Looking to learn something new? I can guide you in learning web development, mobile development, cloud computing, DevOps, and more. Just tell me what interests you!";
    } else if (message.contains('frontend')) {
      return "I can help you with frontend development using technologies like React, Angular, Vue.js, Svelte, or even WebAssembly. Let’s build something amazing!";
    } else if (message.contains('backend')) {
      return "Backend development? Sure! I can guide you with Node.js, Flask, Laravel, Spring Boot, or even building microservices with Docker and Kubernetes.";
    } else if (message.contains('fullstack') ||
        message.contains('full stack')) {
      return "Full-stack development is all about combining frontend and backend. Whether you're using MERN, MEVN, or LAMP stack, I can assist with building your project end to end.";
    } else if (message.contains('laravel')) {
      return "Laravel is great for building modern PHP applications. Let's dive into controllers, routing, database migrations, Eloquent ORM, or even API development with Laravel!";
    } else if (message.contains('django')) {
      return "With Django, you can build robust web apps quickly. I can help you with views, models, Django ORM, Django REST Framework, or integrating third-party libraries.";
    } else if (message.contains('spring boot')) {
      return "Spring Boot makes it easy to create Java-based backends. Need help with Spring Data JPA, REST APIs, security with Spring Security, or deploying Spring apps? I've got you covered!";
    } else if (message.contains('flask')) {
      return "Flask is perfect for lightweight Python applications. Let me assist with routing, template rendering, or even building RESTful APIs with Flask and Flask-RESTful.";
    } else if (message.contains('react')) {
      return "React is perfect for dynamic UIs. I can help with state management (Redux, Context API), React hooks, performance optimization, or server-side rendering with Next.js.";
    } else if (message.contains('vue') || message.contains('vue.js')) {
      return "Vue.js offers a flexible frontend solution. Need help with Vue Router, Vuex, or composition API? I can also guide you in building SPAs and SSR applications using Nuxt.js.";
    } else if (message.contains('angular')) {
      return "Angular is great for large-scale apps. I can help you with Angular modules, services, RxJS for reactive programming, or even optimizing your Angular app's performance.";
    } else if (message.contains('svelte')) {
      return "Svelte is a new and innovative frontend framework. Let me help you with reactive statements, stores, or building component-based web applications in Svelte.";
    } else if (message.contains('node')) {
      return "Node.js allows you to build scalable backend systems. Need help with Express.js, creating microservices, real-time apps with WebSockets, or asynchronous programming?";
    } else if (message.contains('express')) {
      return "Express.js is a minimalist Node.js framework. Let me assist with middleware setup, REST API development, or integrating databases like MongoDB or PostgreSQL.";
    } else if (message.contains('fastapi')) {
      return "FastAPI is a modern Python framework for building APIs quickly. I can help with route setup, async programming, Pydantic models, or Swagger documentation integration.";
    } else if (message.contains('graphql')) {
      return "GraphQL is great for efficient data querying. I can guide you through building a GraphQL API, using Apollo or Relay, and optimizing your queries and mutations.";
    } else if (message.contains('go') || message.contains('golang')) {
      return "Golang is a great choice for performance-critical applications. Let’s work on Go routines, concurrency, REST APIs with Gin or Fiber, or integrating databases with GORM.";
    } else if (message.contains('flutter')) {
      return "Flutter allows you to create cross-platform mobile apps. Let me assist you with UI design, animations, integrating Firebase, or handling state management (Provider, Bloc).";
    } else if (message.contains('swift') || message.contains('ios')) {
      return "I can help you with iOS development using Swift, whether it's building UIs with SwiftUI, networking with Alamofire, or managing data with CoreData or Realm.";
    } else if (message.contains('android') || message.contains('kotlin')) {
      return "For Android development, I can guide you with Kotlin, Android Jetpack components, UI design with XML, or integrating Firebase for real-time functionality.";
    } else if (message.contains('database') ||
        message.contains('sql') ||
        message.contains('nosql')) {
      return "Need help with databases? Whether it's SQL databases (MySQL, PostgreSQL) or NoSQL (MongoDB, Firebase, Cassandra), I can assist with schema design, indexing, and queries.";
    } else if (message.contains('api') || message.contains('rest')) {
      return "I can guide you through designing REST APIs, handling HTTP requests, and working with tools like Postman for testing. Or maybe you're interested in GraphQL or gRPC?";
    } else if (message.contains('docker')) {
      return "Docker is perfect for containerization. Let me assist with Dockerfile creation, managing multi-container setups with Docker Compose, or orchestrating services with Docker Swarm.";
    } else if (message.contains('kubernetes') || message.contains('k8s')) {
      return "Kubernetes helps with automating deployment and scaling. I can guide you with setting up clusters, services, deployments, or using Helm charts to manage complex configurations.";
    } else if (message.contains('cloud') ||
        message.contains('aws') ||
        message.contains('gcp') ||
        message.contains('azure')) {
      return "Need cloud solutions? Whether it's AWS (EC2, Lambda, S3), Google Cloud (Cloud Functions, Kubernetes Engine), or Azure, I can help you deploy, scale, and manage your app.";
    } else if (message.contains('ci/cd') ||
        message.contains('devops') ||
        message.contains('pipelines')) {
      return "DevOps practices are essential for automating workflows. I can help you with CI/CD pipelines using Jenkins, GitLab CI, GitHub Actions, or CircleCI, as well as automating tests and deployments.";
    } else if (message.contains('security') ||
        message.contains('authentication') ||
        message.contains('jwt') ||
        message.contains('oauth')) {
      return "Security is crucial! I can help you implement authentication (OAuth, JWT), secure your APIs, or follow best practices for web application security (XSS, CSRF, etc.).";
    } else if (message.contains('testing') ||
        message.contains('unit test') ||
        message.contains('integration test') ||
        message.contains('e2e')) {
      return "Testing is key to stable software. I can help with unit testing (Jest, Mocha, JUnit), integration tests, or even E2E testing with tools like Cypress or Selenium.";
    } else if (message.contains('performance') ||
        message.contains('optimization')) {
      return "Need help with performance tuning? I can help you optimize web applications (lazy loading, code splitting), backend performance, or database indexing and queries.";
    } else if (message.contains('blockchain') || message.contains('crypto')) {
      return "Blockchain development is exciting! I can guide you with smart contracts (Solidity), building DApps, or integrating with Ethereum or Bitcoin networks.";
    } else if (message.contains('ai') ||
        message.contains('machine learning') ||
        message.contains('ml')) {
      return "I can assist with AI/ML projects, whether it’s building models with TensorFlow or PyTorch, working on data pipelines, or deploying models in production with AWS SageMaker.";
    } else if (message.contains('data science') ||
        message.contains('data analysis')) {
      return "For data science, I can help with Python libraries like Pandas, Numpy, or Matplotlib, and tools like Jupyter Notebooks or Google Colab for analyzing datasets.";
    } else if (message.contains('dev') || message.contains('developer')) {
      return "Looking to become a developer or advance your skills? I can guide you through full-stack development, best coding practices, version control with Git, or contributing to open source!";
    } else if (message.contains('agile') || message.contains('scrum')) {
      return "Agile methodologies like Scrum and Kanban help teams move quickly. I can guide you with planning sprints, using Jira, or setting up an Agile workflow for your team.";
    } else {
      return "I'm sorry, I didn't quite understand. Could you rephrase your question? I'm here to help with anything from programming to cloud computing, AI, and more!";
    }
  }

  // // Simulated bot responses based on input (could be expanded with more logic)
  // String _getBotResponse(String userMessage) {
  //   // Convert the user message to lowercase for easier matching
  //   String message = userMessage.toLowerCase();

  //   // Check the content of the user message and provide responses accordingly
  //   if (message.contains('hello') || message.contains('hi')) {
  //     return "Hi there! How can I assist you today? You can ask me about frontend, backend, or any programming-related questions.";
  //   } else if (message.contains('course')) {
  //     return "We offer various courses in Flutter, Dart, React, Node.js, Laravel, and more. Let me know which topic you're interested in!";
  //   } else if (message.contains('frontend')) {
  //     return "Frontend technologies we support include React, Flutter, and HTML/CSS. We can help with responsive UIs, state management, and more.";
  //   } else if (message.contains('backend')) {
  //     return "For backend development, we cover Laravel, Django, Node.js, and Go. I can assist with API development, databases, and server architecture.";
  //   } else if (message.contains('laravel')) {
  //     return "Laravel is a PHP framework for web apps. Need help with routing, controllers, middleware, or Eloquent ORM? I’ve got you covered!";
  //   } else if (message.contains('django')) {
  //     return "Django is a high-level Python framework. Let me assist you with views, models, templates, Django REST Framework, or admin panel setup.";
  //   } else if (message.contains('crypto') || message.contains('blockchain')) {
  //     return "Interested in blockchain? I can guide you in smart contract development, integrating with Bitcoin/Ethereum, and using Web3 libraries.";
  //   } else if (message.contains('c programming') ||
  //       message.contains('c language')) {
  //     return "C programming is great for performance-critical systems. I can help with pointers, memory management, data structures, and algorithms.";
  //   } else if (message.contains('react')) {
  //     return "React is a popular library for building user interfaces. Need help with React hooks, components, Redux, or performance optimization?";
  //   } else if (message.contains('node')) {
  //     return "Node.js is ideal for building scalable backends. I can help you with Express.js, MongoDB integration, real-time apps, and async programming.";
  //   } else if (message.contains('go') || message.contains('golang')) {
  //     return "Go is a fast and efficient language. Let me guide you with Go routines, channels, web servers, or integrating Go with databases.";
  //   } else if (message.contains('flutter')) {
  //     return "Flutter allows you to build cross-platform mobile apps. I can help with widgets, state management (Provider, Riverpod), and performance optimization.";
  //   } else if (message.contains('database') ||
  //       message.contains('sql') ||
  //       message.contains('nosql')) {
  //     return "Need help with databases? I can assist with SQL databases like MySQL/PostgreSQL, or NoSQL databases like MongoDB and Firebase.";
  //   } else if (message.contains('api')) {
  //     return "I can help you design, build, or integrate APIs. Whether it's REST, GraphQL, or gRPC, let me know what you need assistance with!";
  //   } else if (message.contains('docker')) {
  //     return "I can help you containerize your apps using Docker, set up Dockerfiles, and manage containers for deployment.";
  //   } else if (message.contains('cloud') ||
  //       message.contains('aws') ||
  //       message.contains('gcp') ||
  //       message.contains('azure')) {
  //     return "Need help with cloud deployment? I can guide you with AWS (EC2, S3), Google Cloud Platform, or Microsoft Azure services.";
  //   } else if (message.contains('devops')) {
  //     return "Interested in DevOps? I can assist with CI/CD pipelines, version control (Git), Docker, and orchestration tools like Kubernetes.";
  //   } else if (message.contains('security') ||
  //       message.contains('authentication') ||
  //       message.contains('jwt') ||
  //       message.contains('oauth')) {
  //     return "I can help with application security, including authentication, JWT, OAuth, and best practices for securing your backend and frontend.";
  //   } else if (message.contains('testing') ||
  //       message.contains('unit test') ||
  //       message.contains('integration test')) {
  //     return "Testing is critical! I can assist with unit tests, integration tests, or test automation for your applications in various frameworks.";
  //   } else {
  //     return "Sorry, I didn't understand that. Can you please rephrase your query? Let me know if you need help with frontend, backend, or any programming-related topics.";
  //   }
  // }

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
