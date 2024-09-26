// // import 'package:flutter/material.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:sikshya/utils/api_string.dart';

// // // Course Model
// // class Course {
// //   final int id;
// //   final int teacher;
// //   final String title;
// //   final String description;
// //   final String? thumbnail;
// //   final String validationDate;
// //   final double price;
// //   final List<dynamic> chapters;

// //   Course({
// //     required this.id,
// //     required this.teacher,
// //     required this.title,
// //     required this.description,
// //     this.thumbnail,
// //     required this.validationDate,
// //     required this.price,
// //     required this.chapters,
// //   });

// //   // Factory method to create a Course from JSON
// //   factory Course.fromJson(Map<String, dynamic> json) {
// //     return Course(
// //       id: json['id'],
// //       teacher: json['teacher'],
// //       title: json['title'],
// //       description: json['description'],
// //       thumbnail: json['thumbnail'],
// //       validationDate: json['validation_date'],
// //       price: json['price'],
// //       chapters: json['chapters'],
// //     );
// //   }

// //   static List<Course> fromJsonList(List<dynamic> jsonList) {
// //     return jsonList.map((json) => Course.fromJson(json)).toList();
// //   }
// // }

// // // Remote Services to fetch data
// // class RemoteServices {
// //   Future<List<Course>> getCourses() async {
// //     final response = await http.get(Uri.parse('${ApiString.baseUrl}courses/'));

// //     if (response.statusCode == 200) {
// //       List<dynamic> jsonData = jsonDecode(response.body);
// //       return Course.fromJsonList(jsonData);
// //     } else {
// //       throw Exception('Failed to load courses');
// //     }
// //   }
// // }

// // class DashboardScreen extends StatefulWidget {
// //   final PageController pageController;
// //   static const String routeName = 'dashboard';

// //   const DashboardScreen({super.key, required this.pageController});

// //   @override
// //   State<DashboardScreen> createState() => _DashboardScreenState();
// // }

// // class _DashboardScreenState extends State<DashboardScreen> {
// //   List<Course>? courses;
// //   List<Course>? filteredCourses;
// //   bool isLoading = false;
// //   TextEditingController searchController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchCourses();
// //     searchController.addListener(filterCourses);
// //   }

// //   // Fetch courses from API
// //   Future<void> fetchCourses() async {
// //     setState(() {
// //       isLoading = true;
// //     });
// //     try {
// //       courses = await RemoteServices().getCourses();
// //       setState(() {
// //         filteredCourses = courses;
// //         isLoading = false;
// //       });
// //     } catch (e) {
// //       setState(() {
// //         isLoading = false;
// //       });
// //     }
// //   }

// //   // Filter courses based on search query
// //   void filterCourses() {
// //     String query = searchController.text.toLowerCase();
// //     setState(() {
// //       filteredCourses = courses?.where((course) {
// //         return course.title.toLowerCase().contains(query);
// //       }).toList();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     searchController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           // Top Bar with Profile and Notification Icon
// //           Container(
// //             height: 100,
// //             color: Colors.lightBlueAccent,
// //             child: Padding(
// //               padding: const EdgeInsets.fromLTRB(20, 40, 15, 0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   const Row(
// //                     children: [
// //                       CircleAvatar(
// //                         radius: 20,
// //                         backgroundImage: NetworkImage(
// //                             "https://dl.memuplay.com/new_market/img/com.vicman.newprofilepic.icon.2022-06-07-21-33-07.png"),
// //                       ),
// //                       SizedBox(width: 10),
// //                       Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Text(
// //                             "Hi, Yujan",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           Text(
// //                             "Good Morning",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 14,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                   GestureDetector(
// //                     onTap: () {
// //                       // Navigate to notifications (use your existing NNotification screen)
// //                     },
// //                     child: const Icon(
// //                       Icons.notifications,
// //                       color: Colors.white,
// //                       size: 30,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),

// //           // Search Bar
// //           Padding(
// //             padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
// //             child: Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 20),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(30),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.withOpacity(0.5),
// //                     spreadRadius: 2,
// //                     blurRadius: 5,
// //                   ),
// //                 ],
// //               ),
// //               child: TextField(
// //                 controller: searchController,
// //                 decoration: const InputDecoration(
// //                   hintText: "Search..",
// //                   border: InputBorder.none,
// //                   icon: Icon(Icons.search),
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // Grid of Courses
// //           Expanded(
// //             child: Padding(
// //               padding: const EdgeInsets.only(left: 15, right: 15),
// //               child: isLoading
// //                   ? const Center(child: CircularProgressIndicator())
// //                   : GridView.builder(
// //                       gridDelegate:
// //                           const SliverGridDelegateWithFixedCrossAxisCount(
// //                         crossAxisSpacing: 10,
// //                         mainAxisSpacing: 10,
// //                         childAspectRatio: 0.75,
// //                         crossAxisCount: 2,
// //                       ),
// //                       itemCount: filteredCourses?.length ?? 0,
// //                       itemBuilder: (BuildContext context, int index) {
// //                         return GestureDetector(
// //                           onTap: () {
// //                             // Navigate to website screen for course details
// //                             // Use the course details passed in
// //                           },
// //                           child: Card(
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 // Display thumbnail or placeholder
// //                                 Image.network(
// //                                   filteredCourses![index].thumbnail ??
// //                                       'https://via.placeholder.com/150',
// //                                   height: 150,
// //                                   width: double.infinity,
// //                                   fit: BoxFit.cover,
// //                                 ),
// //                                 const SizedBox(height: 8),
// //                                 Padding(
// //                                   padding: const EdgeInsets.symmetric(
// //                                       horizontal: 8.0),
// //                                   child: Text(
// //                                     filteredCourses![index].title,
// //                                     maxLines: 2,
// //                                     overflow: TextOverflow.ellipsis,
// //                                     style: const TextStyle(
// //                                       fontSize: 15,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         backgroundColor: Colors.lightBlue,
// //         child: const Icon(Icons.wechat_sharp),
// //         onPressed: () {
// //           showModalBottomSheet(
// //             isScrollControlled: true,
// //             context: context,
// //             builder: (context) => const ChatRoom(), // Your chatroom widget
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // // Dummy ChatRoom Widget for the FloatingActionButton
// // class ChatRoom extends StatelessWidget {
// //   const ChatRoom({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 400,
// //       color: Colors.white,
// //       child: const Center(
// //         child: Text('Chat Room'),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/route_manager.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:sikshya/user/Chat_bot/chat_room.dart';
// import 'package:sikshya/user/website/website_design.dart';
// import 'package:sikshya/utils/api_string.dart';

// // Course Model
// class Course {
//   final int id;
//   final int teacher;
//   final String title;
//   final String description;
//   final String? thumbnail;
//   final String validationDate;
//   final double price;

//   Course({
//     required this.id,
//     required this.teacher,
//     required this.title,
//     required this.description,
//     this.thumbnail,
//     required this.validationDate,
//     required this.price,
//   });

//   // Factory method to create a Course from JSON
//   factory Course.fromJson(Map<String, dynamic> json) {
//     return Course(
//       id: json['id'],
//       teacher: json['teacher'],
//       title: json['title'],
//       description: json['description'],
//       thumbnail: json['thumbnail_url'],
//       validationDate: json['validation_date'],
//       price: json['price'],
//     );
//   }

//   static List<Course> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((json) => Course.fromJson(json)).toList();
//   }
// }

// // Remote Services to fetch data
// class RemoteServices {
//   Future<List<Course>> getCourses() async {
//     final response = await http.get(Uri.parse('${ApiString.baseUrl}courses/'));

//     if (response.statusCode == 200) {
//       // Log the response body to check its content
//       print('API Response: ${response.body}');

//       List<dynamic> jsonData = jsonDecode(response.body);

//       // Return the list of courses
//       return Course.fromJsonList(jsonData);
//     } else {
//       throw Exception('Failed to load courses');
//     }
//   }
// }

// // Dashboard Screen
// class DashboardScreen extends StatefulWidget {
//   final PageController pageController;
//   static const String routeName = 'dashboard';

//   const DashboardScreen({super.key, required this.pageController});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   List<Course>? courses;
//   List<Course>? filteredCourses;
//   bool isLoading = false;
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchCourses();
//     searchController.addListener(filterCourses);
//   }

//   // Fetch courses from API
//   Future<void> fetchCourses() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       courses = await RemoteServices().getCourses();
//       if (courses == null || courses!.isEmpty) {
//         print('No courses received');
//       } else {
//         print('Courses received: ${courses!.length}');
//       }
//       setState(() {
//         filteredCourses = courses;
//         isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching courses: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Filter courses based on search query
//   void filterCourses() {
//     String query = searchController.text.toLowerCase();
//     setState(() {
//       filteredCourses = courses?.where((course) {
//         return course.title.toLowerCase().contains(query);
//       }).toList();
//     });
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Top Bar with Profile and Notification Icon
//           Container(
//             height: 100,
//             color: Colors.lightBlueAccent,
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 40, 15, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 20,
//                         backgroundImage: NetworkImage(
//                             "https://dl.memuplay.com/new_market/img/com.vicman.newprofilepic.icon.2022-06-07-21-33-07.png"),
//                       ),
//                       SizedBox(width: 10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Hi, Yujan",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             "Good Morning",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       // Navigate to notifications (use your existing Notification screen)
//                     },
//                     child: const Icon(
//                       Icons.notifications,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Search Bar
//           Padding(
//             padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: searchController,
//                 decoration: const InputDecoration(
//                   hintText: "Search..",
//                   border: InputBorder.none,
//                   icon: Icon(Icons.search),
//                 ),
//               ),
//             ),
//           ),

//           // Grid of Courses
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15),
//               child: isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : filteredCourses == null || filteredCourses!.isEmpty
//                       ? const Center(child: Text("No courses available"))
//                       : GridView.builder(
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 10,
//                             childAspectRatio: 0.75,
//                             crossAxisCount: 2,
//                           ),
//                           itemCount: filteredCourses?.length ?? 0,
//                           itemBuilder: (BuildContext context, int index) {
//                             return GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const WebsiteScreen(),
//                                   ),
//                                 );
//                               },
//                               child: Card(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Display thumbnail or placeholder
//                                     Image.network(
//                                       filteredCourses![index].thumbnail ??
//                                           'https://via.placeholder.com/150',
//                                       height: 150,
//                                       width: double.infinity,
//                                       fit: BoxFit.cover,
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                         return const Icon(Icons.error,
//                                             size:
//                                                 150); // Show error if image fails to load
//                                       },
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8.0),
//                                       child: Text(
//                                         filteredCourses![index].title,
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.lightBlue,
//         child: const Icon(Icons.wechat_sharp),
//         onPressed: () {
//           showModalBottomSheet(
//             isScrollControlled: true,
//             context: context,
//             builder: (context) => const ChatRoom(),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sikshya/user/Chat_bot/chat_room.dart';
import 'package:sikshya/user/website/website_design.dart';
import 'package:sikshya/utils/api_string.dart';

// Course Model
class Course {
  final int id;
  final int teacher;
  final String title;
  final String description;
  final String thumbnail;
  final String validationDate;
  final double price;

  Course({
    required this.id,
    required this.teacher,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.validationDate,
    required this.price,
  });

  // Factory method to create a Course from JSON
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      teacher: json['teacher'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail_url'],
      validationDate: json['validation_date'],
      price: json['price'],
    );
  }

  static List<Course> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Course.fromJson(json)).toList();
  }
}

// Remote Services to fetch data
class RemoteServices {
  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse('${ApiString.baseUrl}courses/'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return Course.fromJsonList(jsonData);
    } else {
      throw Exception('Failed to load courses');
    }
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
      print('Error fetching courses: $e');
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
          _buildTopBar(),

          // Search Bar
          _buildSearchBar(),

          // Grid of Courses
          _buildCourseGrid(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.wechat_sharp),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const ChatRoom(),
          );
        },
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
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
                      "Hi, Yujan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Good Morning",
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
    );
  }

  Widget _buildSearchBar() {
    return Padding(
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
    );
  }

  Widget _buildCourseGrid() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : filteredCourses == null || filteredCourses!.isEmpty
                ? const Center(child: Text("No courses available"))
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WebsiteScreen(),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                filteredCourses![index].thumbnail,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons
                                      .error); // Show error if image fails to load
                                },
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
    );
  }
}
