import 'package:dharohar/constants/colors.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';

class ImageSliderHome extends StatelessWidget {
  final List<String> imageUrls;

  const ImageSliderHome({
    super.key,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ImageSlideshow(
        width: double.infinity,
        height: 200,
        initialPage: 0,
        indicatorColor: Colors.black,
        indicatorBackgroundColor: Colors.grey,

        /// Auto scroll interval.
        /// Do not auto scroll with null or 0.
        autoPlayInterval: 3000,

        /// Loops back to first slide.
        isLoop: true,
        children: [
          ImageBox(image: imageUrls[0], lable: "Namdha"),
          ImageBox(image: imageUrls[1], lable: "Pashmina"),
          ImageBox(image: imageUrls[2], lable: "Kashmiri"),
        ],
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  const ImageBox({
    super.key,
    required this.image,
    this.lable = "",
    this.desc = "",
  });

  final String image;
  final String lable;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Text(
            lable,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 58.606,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.078,
              color: AppColor.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
