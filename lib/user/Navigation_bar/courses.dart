import 'package:flutter/material.dart';

import 'package:sikshya/user/Chat_bot/chat_room.dart'; // Import the ChatRoom
import 'package:sikshya/user/website/website_design.dart'; // Import website screen for course detail

// Course Model
class Course {
  final int id;
  final String title;
  final String description;
  final String? thumbnail;

  Course({
    required this.id,
    required this.title,
    required this.description,
    this.thumbnail,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
    );
  }

  static List<Course> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Course.fromJson(json)).toList();
  }
}

// Remote Service for fetching courses
class RemoteServices {
  Future<List<Course>> getCourses() async {
    // Simulated API response (you should replace this with actual API call)
    await Future.delayed(const Duration(seconds: 2));
    return [
      Course(
          id: 1,
          title: "Flutter Basics",
          description: "Learn Flutter from scratch",
          thumbnail: "https://via.placeholder.com/150"),
      Course(
          id: 2,
          title: "Advanced Dart",
          description: "Master Dart programming",
          thumbnail: "https://via.placeholder.com/150"),
      Course(
          id: 3,
          title: "UI/UX Design",
          description: "Design beautiful UIs",
          thumbnail: "https://via.placeholder.com/150"),
      Course(
          id: 4,
          title: "State Management",
          description: "Learn various state management techniques",
          thumbnail: "https://via.placeholder.com/150"),
    ];
  }
}

// Dashboard Screen
class DashboardScreen extends StatefulWidget {
  final PageController pageController;
  static const String routeName = 'dashboard';

  const DashboardScreen({super.key, required this.pageController});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Course>? courses;
  List<Course>? filteredCourses;
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCourses();
    searchController.addListener(filterCourses);
  }

  // Fetch courses from API
  Future<void> fetchCourses() async {
    setState(() {
      isLoading = true;
    });
    try {
      courses = await RemoteServices().getCourses();
      setState(() {
        filteredCourses = courses;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Filter courses based on search query
  void filterCourses() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredCourses = courses?.where((course) {
        return course.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Bar with Profile and Notification Icon
          Container(
            height: 100,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            "https://dl.memuplay.com/new_market/img/com.vicman.newprofilepic.icon.2022-06-07-21-33-07.png"),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hi, User",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Welcome",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to notifications
                    },
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: "Search..",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          // Grid of Courses
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                        crossAxisCount: 2,
                      ),
                      itemCount: filteredCourses?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the course detail screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WebsiteScreen(
                                      //    post: filteredCourses![index])),
                                      ),
                                ));
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Display thumbnail or placeholder
                                Image.network(
                                  filteredCourses![index].thumbnail ??
                                      'https://via.placeholder.com/150',
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    filteredCourses![index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.wechat_sharp),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const ChatRoom(), // Integrate ChatRoom here
          );
        },
      ),
    );
  }
}
