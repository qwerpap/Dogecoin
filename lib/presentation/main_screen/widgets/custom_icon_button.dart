import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final Color containerColor;
  final Color iconColor;

  const CustomIconButton({
    Key? key,
    required this.containerColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.containerColor;
  }

  void _onTap() {
    setState(() {
      _currentColor = _currentColor == widget.containerColor
          ? widget.containerColor.withOpacity(0.7) // Новый цвет при нажатии
          : widget.containerColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200), // Плавный переход
      height: 47,
      width: 47,
      decoration: BoxDecoration(color: _currentColor),
      child: InkWell(
        onTap: _onTap,
        child: Icon(
          Icons.settings,
          color: widget.iconColor,
        ),
      ),
    );
  }
}