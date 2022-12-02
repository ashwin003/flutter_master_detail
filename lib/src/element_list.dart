import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'types.dart' as types;

class ElementList<T> extends StatelessWidget {
  final List<T> items;
  final Widget? title;
  final T? selectedItem;
  final types.Group<T>? groupedBy;
  final types.GroupHeader? groupHeaderBuilder;
  final types.MasterBuilder<T> masterItemBuilder;
  final ValueSetter<T> onTap;
  const ElementList({
    super.key,
    this.title,
    required this.selectedItem,
    required this.items,
    required this.masterItemBuilder,
    required this.onTap,
    required this.groupedBy,
    required this.groupHeaderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (groupedBy != null) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: title,
          ),
          ..._buildGroupedListView(context)
        ],
      );
    }
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: title,
        ),
        _buildNonGroupedListView(items)
      ],
    );
  }

  List<SliverStickyHeader> _buildGroupedListView(BuildContext context) {
    var grouped = groupBy(items, groupedBy!);
    return grouped.entries
        .map((e) => _buildGroupedElement(context, e.key, e.value))
        .toList();
  }

  SliverStickyHeader _buildGroupedElement(
      BuildContext context, dynamic key, List<T> value) {
    final headerBuilder = groupHeaderBuilder ?? _buildHeaderWidget;
    return SliverStickyHeader(
      header: headerBuilder(context, key, value.length),
      sliver: _buildNonGroupedListView(value),
    );
  }

  Widget _buildHeaderWidget(BuildContext context, dynamic key, int itemsCount) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      child: ListTile(
        title: Text(key.toString()),
        trailing: Text(itemsCount.toString()),
      ),
    );
  }

  SliverList _buildNonGroupedListView(List<T> items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) => _buildElement(ctx, items[index]),
        childCount: items.length,
      ),
    );
  }

  Widget _buildElement(BuildContext context, T item) {
    return GestureDetector(
      onTap: () => onTap(item),
      child: masterItemBuilder(
        context,
        item,
        item == selectedItem,
      ),
    );
  }
}
