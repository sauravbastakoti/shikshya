import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sikshya/core/shared_prefences/locator.dart';
import 'package:sikshya/core/shared_prefences/shared_prefences_service.dart';
import 'package:sikshya/utils/api_string.dart';
import 'dart:convert';
import 'package:video_player/video_player.dart'; // Import video_player package

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

class OverviewWebsite extends StatefulWidget {
  const OverviewWebsite({super.key});

  @override
  State<OverviewWebsite> createState() => _OverviewWebsiteState();
}

class _OverviewWebsiteState extends State<OverviewWebsite> {
  List<dynamic> _recommendedCourses = [];
  bool _isLoading = true;
  late SharedPreferencesService preferencesService;

  @override
  void initState() {
    super.initState();
    preferencesService = locator
        .get<SharedPreferencesService>(); // Initialize preferencesService
    fetchRecommendedVideos(); // Fetch recommended videos when widget is initialized
  }

  Future<void> fetchRecommendedVideos() async {
    const String apiUrl = 'http://192.168.1.115:8001/api/recommendations/';
    final token = locator.get<SharedPreferencesService>().token;
    log(token.toString());

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log(response.body);
        setState(() {
          _recommendedCourses = data['recommended_courses'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load recommended courses');
      }
    } catch (error) {
      print('Error fetching recommended videos: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

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
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const Text(
              'Recommended Videos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _recommendedCourses.isEmpty
                    ? const Text('No recommended courses found.')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _recommendedCourses.length,
                        itemBuilder: (context, index) {
                          final course = _recommendedCourses[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              leading: Image.network(
                                course['thumbnail_url'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                              ),
                              title: Text(course['title']),
                              subtitle: Text(course['description']),
                              trailing: Text("\$${course['price']}"),
                              onTap: () {
                                // Handle video or course tap
                              },
                            ),
                          );
                        },
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
  String _title = '';
  String _description = '';
  String _thumbnailUrl = '';
  double _price = 0.0;

  @override
  void initState() {
    super.initState();
    fetchChapters();
  }

  Future<void> fetchChapters() async {
    final response = await http
        .get(Uri.parse('${ApiString.baseUrl}courses/1/')); // Adjust URL
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log(response.body);
      setState(() {
        _title = data['title'];
        _description = data['description'];
        _thumbnailUrl =
            (data['thumbnail_url'] ?? '').trim(); // Fix the image URL
        _price = data['price'];

        // Ensure every chapter has an `isExpanded` initialized to false
        _chapters = (data['chapters'] as List).map((chapter) {
          return {
            ...chapter,
            'isExpanded': chapter['isExpanded'] ?? false, // Initialize if null
          };
        }).toList();
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
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ensure the URL is valid and not empty
                  _thumbnailUrl.isNotEmpty
                      ? Image.network(_thumbnailUrl,
                          height: 200, fit: BoxFit.cover)
                      : const SizedBox(
                          height: 200,
                          child: Center(child: Text('No Image Available')),
                        ),
                  const SizedBox(height: 10),
                  Text(
                    _title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(_description),
                  const SizedBox(height: 10),
                  Text(
                    "\$$_price",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
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
                        body: Column(
                          children: [
                            ListTile(
                              title: Text(chapter['description']),
                            ),
                            ...chapter['videos'].map<Widget>((video) {
                              return ListTile(
                                leading: const Icon(Icons.play_circle),
                                title: Text(video['title']),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerScreen(
                                        videoUrl: video['full_video_url'],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ],
                        ),
                        isExpanded:
                            chapter['isExpanded'] ?? false, // Default to false
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
                  ),
                ],
              ),
            ),
          );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    loadVideo();
  }

  Future<void> loadVideo() async {
    try {
      print('Video URL: ${widget.videoUrl}');

      // Ensure the video URL is valid
      if (widget.videoUrl.isNotEmpty) {
        _controller = VideoPlayerController.network(widget.videoUrl)
          ..initialize().then((_) {
            setState(() {
              _hasError =
                  false; // Reset error state if initialized successfully
            });
            _controller.play();
            _isPlaying = true;
          }).catchError((error) {
            setState(() {
              _hasError = true; // Set error state if video initialization fails
            });
            print("Error initializing video: $error");
          });
      } else {
        setState(() {
          _hasError = true;
        });
        print("Invalid video URL");
      }
    } catch (e) {
      setState(() {
        _hasError = true;
      });
      print("Error loading video: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Center(
          child: _hasError
              ? const Text('Failed to load video') // Show error message
              : _controller.value.isInitialized
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        const SizedBox(height: 20),
                        IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                              _isPlaying = !_isPlaying;
                            });
                          },
                        ),
                      ],
                    )
                  : const CircularProgressIndicator()),
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
