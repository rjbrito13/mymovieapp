import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePlayDialog extends StatefulWidget {
  final String videoid;
  final String title;

  const MoviePlayDialog({Key? key, required this.videoid,required this.title}) : super(key: key);

  @override
  State<MoviePlayDialog> createState() => _MoviePlayDialogState();
}

class _MoviePlayDialogState extends State<MoviePlayDialog> {
  late YoutubePlayerController  _controller;


  @override
void initState() {
  super.initState();

  // Lock screen orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  // Replace 'youtube_video_id' with the actual YouTube video ID
  _controller = YoutubePlayerController(
    initialVideoId: widget.videoid.toString(),
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );
}

  @override
  void dispose() {
    _controller.dispose();

     SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //final title = widget.title;
      
  return WillPopScope(
      // Handle back button press
      onWillPop: () async {
        // Reset screen orientation to system default
        SystemChrome.setPreferredOrientations([]);
        return true; // Allow back navigation
      },
    child:
  
  
  Scaffold(

      body: YoutubePlayer(
        aspectRatio: 16/9,
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,

      ),
      
      
  
  )
  );
}
}