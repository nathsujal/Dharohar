import 'package:dharohar/constants/colors.dart';
import 'package:dharohar/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const List<String> images = [
    "assets/img/SliderImage_1.jpg",
    "assets/img/SliderImage_2.jpg",
    "assets/img/SliderImage_3.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondaryColor,
        title: const SearchBar(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.center_focus_weak),
            onPressed: () {
              // Handle camera action here
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 3),
            ImageSliderHome(imageUrls: images),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(),
        ),
        suffixIcon: const Icon(Icons.mic),
      ),
    );
  }
}
