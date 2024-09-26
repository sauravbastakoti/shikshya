import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sikshya/core/shared_prefences/locator.dart';
import 'package:sikshya/core/shared_prefences/shared_prefences_service.dart';
import 'package:sikshya/models/post.dart';
import 'package:sikshya/user/website/website_design.dart';
import 'package:sikshya/user/wireframing/my_course_details.dart';
import 'package:sikshya/utils/api_string.dart';

class MyCourse extends StatefulWidget {
  static String routeName = '/mycourses';
  final PageController pageController;
  const MyCourse({super.key, required this.pageController});

  @override
  State<MyCourse> createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  List<Courses>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchCourses(); // Fetch courses on init
  }

  // Function to fetch courses from API
  Future<void> fetchCourses() async {
    final token = locator.get<SharedPreferencesService>().token;
    try {
      var url = Uri.parse('${ApiString.baseUrl}paidcourses/');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;

        setState(() {
          posts = jsonData.map((json) => Courses.fromJson(json)).toList();
          isLoaded = true;
        });
      } else {
        print('Failed to load courses');
      }
    } catch (e) {
      // Handle any exceptions
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Text(
          "My Course",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: fetchCourses, // Refresh button
              child: const Icon(Icons.refresh_sharp),
            ),
          ),
        ],
      ),
      body: isLoaded
          ? ListView.builder(
              itemCount: posts?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MyCourseDetails(id: posts![index].id),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.network(posts![index].thumbnailUrl),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                posts![index].title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                posts![index].description,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class Courses {
  final int id;
  final String title;
  final String description;
  final String thumbnailUrl;

  Courses({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnail_url'],
    );
  }
}
