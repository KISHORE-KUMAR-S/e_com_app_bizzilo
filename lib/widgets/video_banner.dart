import '../models/sample_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'
    show VideoPlayer, VideoPlayerController;

class VideoBannerWidget extends StatefulWidget {
  const VideoBannerWidget({super.key, required this.data});

  final List<Data> data;

  @override
  State<VideoBannerWidget> createState() => _VideoBannerWidgetState();
}

class _VideoBannerWidgetState extends State<VideoBannerWidget>
    with AutomaticKeepAliveClientMixin {
  late List<VideoPlayerController> _controllers;
  int _currentIndex = 0;
  bool _isPlaying = false;

  @override
  bool get wantKeepAlive => true; // Keep the widget alive

  @override
  void initState() {
    super.initState();
    debugPrint('VideoBannerWidget: initState');
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers =
        widget.data
            .where((item) => item.videoUrl != null && item.videoUrl!.isNotEmpty)
            .map((item) {
              debugPrint('Creating controller for: ${item.videoUrl}');
              return VideoPlayerController.networkUrl(
                Uri.parse(item.videoUrl!),
              );
            })
            .toList();

    if (_controllers.isNotEmpty) {
      _initializeCurrentVideo();
    } else {
      setState(() => _isPlaying = false);
      debugPrint('No valid video URLs found');
    }
  }

  void _initializeCurrentVideo() {
    debugPrint('Initializing video: ${widget.data[_currentIndex].videoUrl}');
    _controllers[_currentIndex]
        .initialize()
        .then((_) {
          debugPrint('Video initialized successfully');
          if (mounted) {
            setState(() {
              _isPlaying = true;
              _controllers[_currentIndex].setVolume(1.0); // Unmute
              _controllers[_currentIndex].setLooping(true);
              _controllers[_currentIndex].play();
            });
            _controllers[_currentIndex].addListener(_videoListener);
          }
        })
        .catchError((error) {
          debugPrint('Initialization failed: $error');
          if (mounted) {
            setState(() => _isPlaying = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load video: $error')),
            );
          }
        });
  }

  void _videoListener() {
    if (_controllers[_currentIndex].value.position >=
        _controllers[_currentIndex].value.duration) {
      _playNextVideo();
    }
  }

  void _playNextVideo() {
    if (_controllers.isEmpty) return;

    debugPrint('Playing next video');
    setState(() {
      _isPlaying = false;
      _controllers[_currentIndex].removeListener(_videoListener);
      _controllers[_currentIndex].pause();
      _controllers[_currentIndex].seekTo(Duration.zero);
      _currentIndex = (_currentIndex + 1) % _controllers.length;
      _initializeCurrentVideo();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child:
          _controllers.isEmpty
              ? const Text('No videos available')
              : _controllers[_currentIndex].value.isInitialized
              ? AspectRatio(
                aspectRatio: _controllers[_currentIndex].value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controllers[_currentIndex]),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_isPlaying) {
                              _controllers[_currentIndex].pause();
                              debugPrint('Video paused');
                            } else {
                              _controllers[_currentIndex].play();
                              debugPrint('Video playing');
                            }
                            _isPlaying = !_isPlaying;
                          });
                        },
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : const CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    debugPrint('VideoBannerWidget: dispose');
    for (var controller in _controllers) {
      controller.removeListener(_videoListener);
      controller.dispose();
    }
    super.dispose();
  }
}
