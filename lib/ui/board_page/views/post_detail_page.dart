import 'package:cached_network_image/cached_network_image.dart';
import 'package:emmaus_new/controller/board_controller.dart';
import 'package:emmaus_new/data/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../constants.dart';
import '../../../detail_screen.dart';
import 'full_screen_player_page.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({
    Key? key,
    required this.post,
    required this.tableName,
    required this.tableType,
  }) : super(key: key);

  final PostModel post;
  final String tableName;
  final String tableType;
  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late YoutubePlayerController _controller;
  final boardCR = Get.find<BoardController>();

  @override
  void initState() {
    super.initState();
    if (widget.tableName == "예배") {
      setState(() {
        _controller = YoutubePlayerController.fromVideoId(
          params: const YoutubePlayerParams(
            showControls: true,
            mute: false,
            showFullscreenButton: true,
            loop: false,
          ),
          videoId: widget.post.content,
        );
      });
    }
  }

  @override
  void dispose() {
    if (widget.tableName == "예배") {
      _controller.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          widget.tableName,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Noto',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.tableName == "주보"
                            ? DateFormat("yyyy년 MM월 dd일 주보")
                                .format(widget.post.date)
                            : widget.post.title,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd").format(widget.post.date),
                      style: TextStyle(
                          fontSize: 11, color: Colors.black.withOpacity(0.6)),
                    )
                  ],
                ),
                Text(
                  widget.post.writer,
                  style: TextStyle(
                      fontSize: 11, color: Colors.black.withOpacity(0.6)),
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                widget.tableName == "주보"
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: int.parse(widget.post.content),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                final imgList = List<String>.generate(
                                    int.parse(widget.post.content),
                                    (index) =>
                                        "$kBaseUrl/bulletin/${widget.post.title}_$index.png");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return DetailScreen(
                                    item: imgList,
                                    index: index,
                                  );
                                }));
                              },
                              child: CachedNetworkImage(
                                imageUrl:
                                    "$kBaseUrl/bulletin/${widget.post.title}_$index.png",
                                placeholder: (context, url) => Container(
                                  color: Colors.grey,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          );
                        })
                    : widget.tableName == "예배"
                        ? YoutubePlayer(
                            key: ObjectKey(_controller),
                            aspectRatio: 16 / 9,
                            enableFullScreenOnVerticalDrag: false,
                            controller: _controller
                              ..setFullScreenListener((value) async {
                                final videoData = await _controller.videoData;
                                final startSeconds =
                                    await _controller.currentTime;

                                if (!mounted) return;
                                final currentTime =
                                    await Navigator.push<double>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenPlayerPage(
                                      videoId: videoData.videoId,
                                      startSeconds: startSeconds,
                                    ),
                                  ),
                                );

                                if (currentTime != null) {
                                  _controller.seekTo(seconds: currentTime);
                                }
                              }))
                        : Text(widget.post.content),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {
                      final result = await boardCR.postLike(
                          widget.post.id, widget.tableType);
                      if (result) {
                        setState(() {
                          widget.post.likeCount++;
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: kSelectColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.thumb_up,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            widget.post.likeCount > 999
                                ? '+999'
                                : widget.post.likeCount.toString(),
                            style: const TextStyle(
                                fontSize: 11, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Text(
                  "댓글 ",
                  style: TextStyle(
                      fontSize: 11, color: Colors.black.withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
