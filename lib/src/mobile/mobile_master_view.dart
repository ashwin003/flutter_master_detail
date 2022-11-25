import 'package:flutter/material.dart';
import 'package:flutter_master_detail/src/element_list.dart';

import '../elements_view_model.dart';
import '../types.dart' as types;

class MobileMasterView<T> extends StatelessWidget {
  final ElementsViewModel<T> viewModel;
  final Widget? title;
  final List<T> items;
  final types.MasterBuilder<T> masterItemBuilder;
  final types.Group<T>? groupedBy;
  const MobileMasterView({
    super.key,
    this.title,
    required this.viewModel,
    required this.items,
    required this.masterItemBuilder,
    this.groupedBy,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey<T?>(viewModel.selectedItem),
      body: ElementList(
        items: items,
        selectedItem: viewModel.selectedItem,
        title: title,
        masterItemBuilder: masterItemBuilder,
        onTap: (value) => viewModel.selectedItem = value,
      ),
    );
  }
}
