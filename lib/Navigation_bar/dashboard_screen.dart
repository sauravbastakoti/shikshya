import 'package:flutter/material.dart';

import 'package:sikshya/Chat_bot/chat_room.dart';
import 'package:sikshya/Navigation_bar/Profile/notification.dart';
import 'package:sikshya/models/post.dart';
import 'package:sikshya/service/dashboard_services.dart';
import 'package:sikshya/website/website_design.dart';

class DashboardScreen extends StatefulWidget {
  final PageController pageController;
  const DashboardScreen({super.key, required this.pageController});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Courses>? posts;
  List<Courses>? filteredPosts;
  var isloaded = false;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
    searchController.addListener(_filterPosts);
  }

  getData() async {
    posts = await RemoteServices().getPost();
    if (posts != null) {
      setState(() {
        isloaded = true;
        filteredPosts = posts;
      });
    }
  }

  void _filterPosts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredPosts = posts?.where((post) {
        return post.title.toLowerCase().contains(query);
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NNotification()),
                      );
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

          // Expanded(
          // child: GridView.builder(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 10,
          //     mainAxisSpacing: 10,
          //     childAspectRatio: 0.7,
          //   ),
          //   itemCount: Courses.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return GestureDetector(
          //       onTap: () {
          //         switch (Courses[index].title) {
          //           case 'Graphics Design ':
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => GraphicsDesignScreen(),
          //               ),
          //             );
          //             break;
          //           case "WireFraming":
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => WireframingScreen(),
          //               ),
          //             );
          //             break;
          //           case "Website Design":
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => WebsiteScreen(),
          //               ),
          //             );
          //             break;
          //           case "Video Editing":
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => Videoediting(),
          //               ),
          //             );
          //         }
          //       },
          //       child: Card(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Expanded(
          //               child: Image.network(
          //                 Courses[index].imageUrl,
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "${Courses[index].title}",
          //                     style: TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                   Text(Courses[index].subtitle),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                  crossAxisCount: 2,
                ),
                itemCount: posts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  // if (posts == null || posts!.isEmpty) {
                  //   return Center(child: Text('No posts available'));
                  // }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WebsiteScreen(post: posts![index]),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            posts![index].imageUrl,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            posts![index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
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
                builder: (context) => const ChatRoom());
          }),
    );
  }
}
