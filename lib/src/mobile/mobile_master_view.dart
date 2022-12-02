import 'package:flutter/material.dart';
import 'package:flutter_master_detail/src/element_list.dart';

import '../elements_view_model.dart';
import '../types.dart' as types;

class MobileMasterView<T> extends StatelessWidget {
  final ElementsViewModel<T> viewModel;
  final Widget? title;
  final List<T> items;
  final types.MasterBuilder<T> masterItemBuilder;
  final types.Data<T>? groupedBy;
  final types.GroupHeader? groupHeaderBuilder;
  const MobileMasterView({
    super.key,
    this.title,
    required this.viewModel,
    required this.items,
    required this.masterItemBuilder,
    this.groupedBy,
    this.groupHeaderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey<T?>(viewModel.selectedItem),
      body: ElementList(
        items: items,
        groupedBy: groupedBy,
        groupHeaderBuilder: groupHeaderBuilder,
        selectedItem: viewModel.selectedItem,
        title: title,
        masterItemBuilder: masterItemBuilder,
        onTap: (value) => viewModel.selectedItem = value,
      ),
    );
  }
}
