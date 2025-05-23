import 'package:flutter/material.dart';
import 'focusable_widget.dart';
import 'image_thumbnail.dart';

class ImageCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final bool autofocus;
  final VoidCallback? onSelect;

  const ImageCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.autofocus = false,
    this.onSelect,
  });

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool _focused = false;

  static const double _cardWidth = 368;
  static const double _cardHeight = 207;
  static const double _borderRadius = 6;

  @override
  Widget build(BuildContext context) {
    return FocusableWidget(
      autofocus: widget.autofocus,
      onSelect: widget.onSelect,
      onFocusChange: (focused) => setState(() => _focused = focused),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: _cardWidth,
        height: _cardHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: _focused ? Colors.blue : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: ImageThumbnail(
            imageUrl: widget.imageUrl,
            width: _cardWidth,
            height: _cardHeight,
            borderRadius: _borderRadius,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}