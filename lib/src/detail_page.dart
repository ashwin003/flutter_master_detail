import 'package:flutter/material.dart';
import 'package:flutter_master_detail/src/detail_view.dart';

import 'elements_view_model.dart';
import 'types.dart' as types;

class DetailPage<T> extends StatelessWidget {
  final ElementsViewModel<T> viewModel;
  final Widget? nothingSelectedWidget;
  final types.DetailsBuilder<T> detailsItemBuilder;
  final types.DetailsTitleBuilder<T> detailsTitleBuilder;
  final Widget? leading;
  const DetailPage({
    super.key,
    this.leading,
    this.nothingSelectedWidget,
    required this.viewModel,
    required this.detailsTitleBuilder,
    required this.detailsItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailView(
        viewModel: viewModel,
        leading: leading,
        nothingSelectedWidget: nothingSelectedWidget,
        detailsTitleBuilder: detailsTitleBuilder,
        detailsItemBuilder: detailsItemBuilder,
      ),
    );
  }
}
