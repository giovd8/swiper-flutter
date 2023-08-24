import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiper_test/providers/card_provider.dart';

class WimblyCard extends StatefulWidget {
  const WimblyCard({Key? key, required this.urlImage, required this.isFront})
      : super(key: key);
  final String urlImage;
  final bool isFront;
  @override
  State<WimblyCard> createState() {
    return _WimblyCardState();
  }
}

class _WimblyCardState extends State<WimblyCard> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      // i set to provider the screen size
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.isFront ? builFrontCard() : buildCard(),
    );
  }

  Widget builFrontCard() => GestureDetector(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final provider = Provider.of<CardProvider>(context);
            final position = provider.position;
            // if is not dragging, animate the card to the center
            final milliseconds = provider.isDragging ? 0 : 400;

            final center = constraints.smallest.center(Offset.zero);
            final angle = provider.angle * pi / 180;
            final rotatedMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);

            return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: milliseconds),
              transform: rotatedMatrix
                ..translate(
                  position.dx,
                  position.dy,
                ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      // image: AssetImage(
                      //   widget.urlImage,
                      // ),
                      image: NetworkImage(widget.urlImage),
                      fit: BoxFit.cover,
                      alignment: Alignment.center),
                ),
              ),
            );
          },
        ),
        onPanStart: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          print('as');
          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.endPosition(details);
        },
      );

  Widget buildCard() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              // image: AssetImage(
              //   widget.urlImage,
              // ),
              image: NetworkImage(widget.urlImage),
              fit: BoxFit.cover,
              alignment: Alignment.center),
        ),
      );
}
