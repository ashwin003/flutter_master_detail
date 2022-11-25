import 'package:flutter/material.dart';

import 'elements_view_model.dart';
import 'types.dart' as types;

class DetailView<T> extends StatelessWidget {
  final ElementsViewModel<T> viewModel;
  final Widget? nothingSelectedWidget;
  final types.DetailsTitleBuilder<T> detailsTitleBuilder;
  final types.DetailsBuilder<T> detailsItemBuilder;
  final Widget? leading;
  const DetailView({
    super.key,
    this.leading,
    this.nothingSelectedWidget,
    required this.viewModel,
    required this.detailsTitleBuilder,
    required this.detailsItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return viewModel.selectedItem == null
        ? _buildNothingSelectedView()
        : _buildScrollView(context);
  }

  CustomScrollView _buildScrollView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: leading,
          flexibleSpace: detailsTitleBuilder(
            context,
            viewModel.selectedItem as T,
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          _buildDetailElement,
          childCount: 1,
        ))
      ],
    );
  }

  Widget _buildDetailElement(BuildContext context, int index) {
    return detailsItemBuilder(
      context,
      viewModel.selectedItem as T,
    );
  }

  Widget _buildNothingSelectedView() {
    return nothingSelectedWidget ??
        const Text("Select something from the list");
  }
}
