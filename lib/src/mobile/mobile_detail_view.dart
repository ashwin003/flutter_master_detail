import 'package:flutter/material.dart';
import 'package:flutter_master_detail/src/detail_page.dart';

import '../elements_view_model.dart';
import '../types.dart' as types;

class MobileDetailView<T> extends StatelessWidget {
  final ElementsViewModel<T> viewModel;
  final types.DetailsBuilder<T> detailsItemBuilder;
  final types.DetailsTitleBuilder<T> detailsTitleBuilder;
  const MobileDetailView({
    super.key,
    required this.viewModel,
    required this.detailsTitleBuilder,
    required this.detailsItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      viewModel: viewModel,
      detailsTitleBuilder: detailsTitleBuilder,
      detailsItemBuilder: detailsItemBuilder,
      leading: IconButton(
        onPressed: () {
          viewModel.selectedItem = null;
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
