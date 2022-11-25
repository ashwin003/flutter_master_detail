import 'package:flutter/material.dart';
import 'types.dart' as types;

class ElementList<T> extends StatelessWidget {
  final List<T> items;
  final Widget? title;
  final T? selectedItem;
  final types.MasterBuilder<T> masterItemBuilder;
  final ValueSetter<T> onTap;
  const ElementList({
    super.key,
    this.title,
    required this.selectedItem,
    required this.items,
    required this.masterItemBuilder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: title,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            _buildElement,
            childCount: items.length,
          ),
        )
      ],
    );
  }

  Widget _buildElement(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => onTap(items[index]),
      child: masterItemBuilder(
        context,
        items[index],
        items[index] == selectedItem,
      ),
    );
  }
}
