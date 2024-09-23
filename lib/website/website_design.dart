import 'package:flutter/material.dart';
import 'package:sikshya/models/post.dart';
import 'package:sikshya/website/lesson_website.dart';
import 'package:sikshya/website/overview_website.dart';
import 'package:sikshya/website/review_website.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class WebsiteScreen extends StatefulWidget {
  final Courses post;
  const WebsiteScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<WebsiteScreen> createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late VideoPlayerController _videoController;
  bool _showControls = false;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _videoController = VideoPlayerController.network(widget.post.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _videoController.dispose();
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
        _showControls = true;
      } else {
        _videoController.play();
        _showControls = true;
        _startHideControlsTimer();
      }
    });
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  void _onVideoTap() {
    if (_videoController.value.isPlaying) {
      setState(() {
        _showControls = true;
        _startHideControlsTimer();
      });
    } else {
      setState(() {
        _showControls = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Website Design"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: _onVideoTap,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: _videoController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                if (_showControls)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      _videoController.value.position.inMinutes
                              .toString()
                              .padLeft(2, '0') +
                          ":" +
                          (_videoController.value.position.inSeconds % 60)
                              .toString()
                              .padLeft(2, '0'),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                if (_showControls)
                  IconButton(
                    iconSize: 64,
                    color: Colors.white,
                    icon: Icon(
                      _videoController.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    onPressed: _togglePlayPause,
                  ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
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
              children: [OverviewWebsite(), LessonWebsite(), ReviewWebsite()],
            ),
          ),
        ],
      ),
    );
  }
}
