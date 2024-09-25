import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebsiteScreen extends StatefulWidget {
  const WebsiteScreen({super.key});

  @override
  State<WebsiteScreen> createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Details"),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Overview"),
              Tab(text: "Lesson"),
              Tab(text: "Reviews"),
            ],
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                OverviewWebsite(),
                LessonWebsite(),
                ReviewWebsite(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OverviewWebsite extends StatelessWidget {
  const OverviewWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Website Design",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("by Syed Hasnain"),
                Text(
                  r"72 $",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
                "Web designing is the process of planning, conceptualizing, and implementing..."),
            const SizedBox(height: 15),
            Container(
              height: 80,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.grey),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.book),
                          SizedBox(width: 5),
                          Text("80+ Lectures"),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.read_more),
                          SizedBox(width: 5),
                          Text("Certificate"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(width: 5),
                          Text("10 Hours"),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.language),
                          SizedBox(width: 5),
                          Text("English"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            SizedBox(
              height: 50,
              width: 400,
              child: MaterialButton(
                color: Colors.lightBlue,
                onPressed: () {
                  // Handle Get Enrolled
                },
                child: const Text(
                  "Get Enrolled",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LessonWebsite extends StatefulWidget {
  const LessonWebsite({super.key});

  @override
  State<LessonWebsite> createState() => _LessonWebsiteState();
}

class _LessonWebsiteState extends State<LessonWebsite> {
  List<dynamic> _chapters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChapters();
  }

  Future<void> fetchChapters() async {
    final response = await http.get(
        Uri.parse('http://192.168.1.101:8000/api/courses/1/')); // Adjust URL
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _chapters = data['chapters'];
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load chapters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _chapters[index]['isExpanded'] =
                            !_chapters[index]['isExpanded'];
                        for (int i = 0; i < _chapters.length; i++) {
                          if (i != index) {
                            _chapters[i]['isExpanded'] = false;
                          }
                        }
                      });
                    },
                    children: _chapters.map<ExpansionPanel>((chapter) {
                      return ExpansionPanel(
                        canTapOnHeader: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(chapter['title']),
                          );
                        },
                        body: ListTile(
                          title: Text(chapter['description']),
                        ),
                        isExpanded: chapter['isExpanded'] ?? false,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 200),
                  SizedBox(
                    height: 50,
                    width: 400,
                    child: MaterialButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        // Handle Get Enrolled
                      },
                      child: const Text(
                        "Get Enrolled",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

class ReviewWebsite extends StatelessWidget {
  const ReviewWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Reviews"));
  }
}
