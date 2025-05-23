import 'package:flutter/material.dart';
import 'focusable_widget.dart';

class FocusableGameCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSelect;
  final bool autofocus;
  final ValueChanged<bool>? onFocusChange;

  const FocusableGameCard({
    required this.child,
    required this.onSelect,
    this.autofocus = false,
    this.onFocusChange,
    super.key,
  });

  @override
  State<FocusableGameCard> createState() => _FocusableGameCardState();
}

class _FocusableGameCardState extends State<FocusableGameCard> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return FocusableWidget(
      autofocus: widget.autofocus,
      onSelect: widget.onSelect,
      onFocusChange: (focused) {
        setState(() => _focused = focused);
        widget.onFocusChange?.call(focused);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: Border.all(color: _focused ? Colors.blue : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: widget.child,
      ),
    );
  }
}
