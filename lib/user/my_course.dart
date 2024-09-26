import 'package:flutter/material.dart';
import 'package:sikshya/models/post.dart';

import 'package:sikshya/user/website/website_design.dart';

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
  }

  // getData() async {
  //   setState(() {
  //     isLoaded = false;
  //   });

  //   posts = await RemoteServices().getPost();
  //   if (posts != null) {
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

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
              onTap: () {},
              child: const Icon(Icons.refresh_sharp),
            ),
          ),
        ],
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LessonWebsite(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.network(posts![index].imageUrl),
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
                        ],
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
