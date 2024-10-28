import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final List<PopupMenuEntry<int>> menuItems;
  final Function(int) onItemSelected;

  const CustomPopupMenuButton({
    super.key,
    required this.menuItems,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert),
      onSelected: onItemSelected,
      itemBuilder: (context) => menuItems,
    );
  }
}
