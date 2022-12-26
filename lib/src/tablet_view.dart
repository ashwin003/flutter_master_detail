import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_master_detail/src/detail_view.dart';

import 'element_list.dart';
import 'elements_view_model.dart';
import 'types.dart' as types;
import 'types/details_title_config.dart';

class TabletView<T> extends StatelessWidget {
  final ElementsViewModel<T> viewModel;
  final FlexibleSpaceBar? title;
  final Widget? nothingSelectedWidget;
  final List<T> items;
  final types.MasterBuilder<T> masterItemBuilder;
  final types.DetailsTitleBuilder<T> detailsTitleBuilder;
  final types.DetailsBuilder<T> detailsItemBuilder;
  final types.Data<T>? groupedBy;
  final types.GroupHeader? groupHeaderBuilder;
  final double masterViewFraction;
  final double masterViewMaxWidth;
  final Duration transitionAnimationDuration;
  final DetailsTitleConfig detailsTitleConfig;
  const TabletView({
    super.key,
    this.title,
    this.nothingSelectedWidget,
    required this.viewModel,
    required this.items,
    required this.masterItemBuilder,
    required this.detailsTitleBuilder,
    required this.detailsItemBuilder,
    required this.masterViewFraction,
    required this.masterViewMaxWidth,
    required this.transitionAnimationDuration,
    required this.detailsTitleConfig,
    this.groupedBy,
    this.groupHeaderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildMasterPanel(constraints),
            _buildDetailsPanel(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsPanel(BuildContext context) {
    return Expanded(
      child: AnimatedSwitcher(
        duration: transitionAnimationDuration,
        child: DetailView(
          detailsItemBuilder: detailsItemBuilder,
          detailsTitleBuilder: detailsTitleBuilder,
          viewModel: viewModel,
          nothingSelectedWidget: nothingSelectedWidget,
          detailsTitleConfig: detailsTitleConfig,
        ),
        transitionBuilder: (child, animation) =>
            const FadeUpwardsPageTransitionsBuilder()
                .buildTransitions(null, context, animation, null, child),
      ),
    );
  }

  Widget _buildMasterPanel(BoxConstraints constraints) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: min(
          constraints.maxWidth * masterViewFraction,
          300,
        ),
      ),
      child: ElementList(
        items: items,
        title: title,
        groupedBy: groupedBy,
        groupHeaderBuilder: groupHeaderBuilder,
        selectedItem: viewModel.selectedItem,
        masterItemBuilder: masterItemBuilder,
        onTap: (item) => viewModel.selectedItem = item,
      ),
    );
  }
}
