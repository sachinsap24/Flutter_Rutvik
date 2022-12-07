import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomescreenStory extends StatefulWidget {
  final List<String> story;

  HomescreenStory({required this.story});

  @override
  State<HomescreenStory> createState() => _HomescreenStoryState();
}

class _HomescreenStoryState extends State<HomescreenStory> {
  CarouselController carouselController = CarouselController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          var position = details.globalPosition;

          if (position.dx < MediaQuery.of(context).size.width / 2) {
            if (currentPage != 0) {
              carouselController.previousPage();
            } else {
              setState(() {
                currentPage = 0;
              });

              Navigator.pop(context);
            }
          } else {
            if (currentPage < widget.story.length - 1) {
              carouselController.nextPage();
            } else {
              setState(() {
                currentPage = 0;
              });

              Navigator.pop(context);
            }
          }
        },
        child: Stack(
          children: [
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  /* width: MediaQuery.of(context).size.width,*/
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  height: MediaQuery.of(context).size.height,
                  autoPlay: false,
                  enableInfiniteScroll: false),
              items: widget.story.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CachedNetworkImage(
                        imageUrl: i,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Center(child: CircularProgressIndicator()),
                      ),
                      /*   Image.network(i, fit: BoxFit.fill),*/
                    );
                  },
                );
              }).toList(),
            ),
           
          ],
        ),
      ),
    );
  }
}
