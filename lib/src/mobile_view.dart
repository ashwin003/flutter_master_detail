import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_master_detail/src/types/details_title_config.dart';
import './mobile/mobile_detail_view.dart';
import './mobile/mobile_master_view.dart';

import 'elements_view_model.dart';
import 'types.dart' as types;

class MobileView<T> extends StatelessWidget {
  final ElementsViewModel<T> viewModel;
  final FlexibleSpaceBar? title;
  final Widget? nothingSelectedWidget;
  final List<T> items;
  final types.MasterBuilder<T> masterItemBuilder;
  final types.DetailsBuilder<T> detailsItemBuilder;
  final types.DetailsTitleBuilder<T> detailsTitleBuilder;
  final types.Data<T>? groupedBy;
  final types.GroupHeader? groupHeaderBuilder;
  final Duration transitionAnimationDuration;
  static const pageTransitionBuilder = ZoomPageTransitionsBuilder();
  final DetailsTitleConfig detailsTitleConfig;
  const MobileView({
    super.key,
    this.title,
    this.nothingSelectedWidget,
    required this.viewModel,
    required this.items,
    required this.masterItemBuilder,
    required this.detailsTitleBuilder,
    required this.detailsItemBuilder,
    this.groupedBy,
    this.groupHeaderBuilder,
    required this.transitionAnimationDuration,
    required this.detailsTitleConfig,
  });

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: transitionAnimationDuration,
      reverse: viewModel.selectedItem == null,
      transitionBuilder: _transitionBuilder,
      child: _showDetailView() ? _buildDetailsView() : _buildMasterView(),
    );
  }

  MobileMasterView<T> _buildMasterView() {
    return MobileMasterView<T>(
      viewModel: viewModel,
      items: items,
      masterItemBuilder: masterItemBuilder,
      groupedBy: groupedBy,
      groupHeaderBuilder: groupHeaderBuilder,
      title: title,
    );
  }

  MobileDetailView<T> _buildDetailsView() {
    return MobileDetailView<T>(
      viewModel: viewModel,
      detailsTitleBuilder: detailsTitleBuilder,
      detailsItemBuilder: detailsItemBuilder,
      detailsTitleConfig: detailsTitleConfig,
    );
  }

  bool _showDetailView() => viewModel.selectedItem != null;

  Widget _transitionBuilder(
    Widget child,
    Animation<double> primaryAnimation,
    Animation<double> secondaryAnimation,
  ) {
    return pageTransitionBuilder.buildTransitions(
      null,
      null,
      primaryAnimation,
      secondaryAnimation,
      child,
    );
  }
}
