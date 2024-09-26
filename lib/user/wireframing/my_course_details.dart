import 'dart:developer';
import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sikshya/core/shared_prefences/locator.dart';
import 'package:sikshya/core/shared_prefences/shared_prefences_service.dart';
import 'package:sikshya/cubit/buy_courses/buy_courses_cubit.dart';
import 'package:sikshya/payment/esewa_payment.dart';
import 'package:sikshya/utils/api_string.dart';

import 'dart:convert';
import 'package:video_player/video_player.dart'; // Import video_player package

class MyCourseDetails extends StatefulWidget {
  final int id;
  const MyCourseDetails({super.key, required this.id});

  @override
  State<MyCourseDetails> createState() => _MyCourseDetailsState();
}

class _MyCourseDetailsState extends State<MyCourseDetails>
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
              children: [
                OverviewWebsite(
                  id: widget.id,
                ),
                LessonWebsite(
                  id: widget.id,
                ),
                ReviewWebsite(
                  id: widget.id,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OverviewWebsite extends StatefulWidget {
  final int id;
  const OverviewWebsite({super.key, required this.id});

  @override
  State<OverviewWebsite> createState() => _OverviewWebsiteState();
}

class _OverviewWebsiteState extends State<OverviewWebsite> {
  bool _isLoading = true;
  String _teacher = '';
  String _title = '';
  String _description = '';
  String _thumbnailUrl = '';
  double _price = 0.0;
  List<dynamic> _recommendedCourses = [];

  @override
  void initState() {
    super.initState();
    fetchOverviewData();
    fetchRecommendedVideos();
  }

  Future<void> fetchOverviewData() async {
    // API endpoint for the overview data
    String apiUrl = '${ApiString.baseUrl}paidcoursesdetail/${widget.id}/';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      // Log the status code and response body
      log('Status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log(response.body);

        setState(() {
          _teacher = "Teacher ID: ${data['teacher']}";
          _title = data['title'];
          _description = data['description'];
          _thumbnailUrl = data['thumbnail_url'] ?? '';
          _price = data['price'];
          _recommendedCourses = data['recommended_courses'] ?? [];
          _isLoading = false;
        });
      } else {
        // Handle errors based on status codes
        throw Exception('Failed to load course overview: ${response.body}');
      }
    } catch (error) {
      print('Error fetching overview: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchRecommendedVideos() async {
    const String apiUrl = '${ApiString.baseUrl}recommendations/';
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

  // void openEsewaPayment() async {
  //   String baseUrl = "https://uat.esewa.com.np/epay/main";
  //   String totalAmount = "100"; // Total transaction amount
  //   String productId = "123456789"; // Unique product ID or order ID
  //   String merchantCode = "EPAYTEST"; // Your eSewa merchant code
  //   String successUrl =
  //       "https://yourwebsite.com/success"; // Redirect URL after successful payment
  //   String failureUrl =
  //       "https://yourwebsite.com/failure"; // Redirect URL if the payment fails

  //   String paymentUrl =
  //       "$baseUrl?tAmt=$totalAmount&amt=$totalAmount&txAmt=0&psc=0&pdc=0&scd=$merchantCode&pid=$productId&su=$successUrl&fu=$failureUrl";

  //   if (await canLaunch(paymentUrl)) {
  //     await launch(paymentUrl);
  //   } else {
  //     throw 'Could not launch $paymentUrl';
  //   }
  // }

  void processPayment() async {
    final eSewaConfig = ESewaConfig.dev(
      amt: _price,
      pid: DateTime.now().millisecondsSinceEpoch.toString(),
      su: 'https://www.marvel.com/hello', // Success URL
      fu: 'https://www.marvel.com/hello', // Failure URL
      // Optional parameters
      txAmt: 0.0, // Tax amount
      psc: 0.0, // Service charge
      pdc: 0.0, // Delivery charge
    );
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EsewaPaymentScreen(
          paymentConfig: eSewaConfig,
        ),
      ),
    );
    if (result != null && result is PaymentResult) {
      if (result.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Payment successful! Ref Id: ${result.refId}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: ${result.errorMessage}')),
        );
      }
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
                  // Ensure the thumbnail URL is valid and not empty
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
                  Text(_teacher),
                  const SizedBox(height: 10),
                  Text(_description),
                  const SizedBox(height: 10),
                  Text(
                    "\$$_price",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Builder(builder: (context) {
                  //   return BlocListener<BuyCoursesCubit, BuyCoursesState>(
                  //     listener: (context, state) {
                  //       if (state.status == BuyCoursesStatus.initial) {
                  //       } else if (state.status == BuyCoursesStatus.success) {
                  //         processPayment();
                  //       }
                  //     },
                  //     child: SizedBox(
                  //       height: 50,
                  //       width: 400,
                  //       child: MaterialButton(
                  //         color: Colors.lightBlue,
                  //         onPressed: () {
                  //           context
                  //               .read<BuyCoursesCubit>()
                  //               .checkUser(widget.id);
                  //         },
                  //         child: const Text(
                  //           "Get Enrolled",
                  //           style: TextStyle(fontSize: 20),
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // }),
                  const SizedBox(height: 10),
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    leading: Image.network(
                                      course['thumbnail_url'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
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
  final int id;
  const LessonWebsite({super.key, required this.id});

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
    final token = locator.get<SharedPreferencesService>().token;
    // API endpoint for the course data
    String apiUrl = '${ApiString.baseUrl}paidcoursesdetail/${widget.id}/';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log(response.body);

        setState(() {
          // Extract chapters with an 'isExpanded' key for the expansion panel
          _chapters = (data['chapters'] as List).map((chapter) {
            return {
              ...chapter,
              'isExpanded': chapter['isExpanded'] ?? false,
            };
          }).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load chapters');
      }
    } catch (error) {
      print('Error fetching chapters: $error');
      setState(() {
        _isLoading = false;
      });
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
                  const Text(
                    "Course Lessons",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _chapters[index]['isExpanded'] =
                            !_chapters[index]['isExpanded'];
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
                        isExpanded: chapter['isExpanded'] ?? false,
                      );
                    }).toList(),
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

      if (widget.videoUrl.isNotEmpty) {
        _controller = VideoPlayerController.networkUrl(Uri.parse(
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
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

class ReviewWebsite extends StatefulWidget {
  final int id;
  const ReviewWebsite({super.key, required this.id});

  @override
  _ReviewWebsiteState createState() => _ReviewWebsiteState();
}

class _ReviewWebsiteState extends State<ReviewWebsite> {
  List<dynamic> _reviews = [];
  double _averageRating = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReviewsAndRatings();
  }

  double _currentRating = 0;
  final TextEditingController _commentController = TextEditingController();

  void _submitReview() {
    if (_currentRating > 0 && _commentController.text.isNotEmpty) {
      setState(() {
        _reviews.add({
          'name': 'Anonymous', // Static user name for demo purposes
          'rating': _currentRating,
          'comment': _commentController.text,
        });
        _currentRating = 0;
        _commentController.clear();
      });
    }
  }

  Future<void> _fetchReviewsAndRatings() async {
    final token = locator.get<SharedPreferencesService>().token;
    try {
      // Fetch reviews (Expecting a List response)
      final reviewsResponse = await http.get(
        Uri.parse('${ApiString.baseUrl}reviews/${widget.id}/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Decode response as a List
      final List<dynamic> reviewsData = jsonDecode(reviewsResponse.body);

      // Fetch average rating (Expecting a Map response)
      final ratingResponse = await http.get(
        Uri.parse('${ApiString.baseUrl}ratings/${widget.id}/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> ratingData = jsonDecode(ratingResponse.body);
      double averageRating = ratingData['average_rating'] ?? 0.0;

      setState(() {
        _reviews = reviewsData; // List of reviews
        _averageRating = averageRating; // Average rating value
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rate our service:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildAverageRatingStars(),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    _buildRatingStars(),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your comment',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _submitReview,
                      child: const Text('Submit Review'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'User Reviews:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildReviewList(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildAverageRatingStars() {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < _averageRating ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }

  Widget _buildRatingStars() {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _currentRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              _currentRating = index + 1.0;
            });
          },
        );
      }),
    );
  }

  Widget _buildReviewList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        final review = _reviews[index];
        return ListTile(
          title: Text(review['student_name']),
          subtitle: Text(review['comment']),
        );
      },
    );
  }
}

enum Environment {
  test,
  live,
}

class PaymentResult {
  final bool isSuccess;
  final String refId;
  final String errorMessage;

  PaymentResult({
    required this.isSuccess,
    required this.refId,
    required this.errorMessage,
  });
}
