// import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiper_test/providers/card_provider.dart';
import 'package:swiper_test/screens/swiper/widgets/card.dart';

class SwiperScreen extends StatefulWidget {
  const SwiperScreen({Key? key}) : super(key: key);

  @override
  State<SwiperScreen> createState() {
    return _SwiperScreeState();
  }
}

class _SwiperScreeState extends State<SwiperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wimbly"),
      ),
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: buildCards(),
      )),
    );
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.imagesUrl;

    return Stack(
      children: urlImages
          .map((urlImage) => WimblyCard(
              urlImage: urlImage, isFront: urlImages.last == urlImage))
          .toList(),
    );
  }
}
