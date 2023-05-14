import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

///이미지 클릭하면 나오는 페이지

class DetailScreen extends StatefulWidget {
  DetailScreen({
    required this.item,
    Key? key,
    required this.index,
  })  : pageController = PageController(initialPage: index),
        super(key: key);
  final List<String> item;
  final int index;
  final PageController pageController;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.arrow_left)),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: PhotoViewGallery.builder(
                  pageController: widget.pageController,
                  enableRotation: false,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.white),
                  itemCount: widget.item.length,
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      initialScale: PhotoViewComputedScale.contained,
                      imageProvider: CachedNetworkImageProvider(
                        widget.item[index],
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
