import 'package:flutter/material.dart';
import 'package:flutter_master_detail/src/desktop_view.dart';
import 'package:flutter_master_detail/src/elements_view_model.dart';
import 'package:flutter_master_detail/src/mobile_view.dart';
import 'package:flutter_master_detail/src/tablet_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'types.dart' as types;

class MasterDetailsList<T> extends StatelessWidget {
  final FlexibleSpaceBar? title;
  final List<T> items;
  final types.MasterBuilder<T> masterItemBuilder;
  final Widget? nothingSelectedWidget;
  final types.DetailsTitleBuilder<T> detailsTitleBuilder;
  final types.DetailsBuilder<T> detailsItemBuilder;
  final types.Sort<T>? sortBy;
  final types.Group<T>? groupedBy;
  final types.GroupHeader? groupHeaderBuilder;
  final double masterViewFraction;
  final Duration transitionAnimationDuration;
  final bool debug;
  final ElementsViewModel<T> viewModel = ElementsViewModel<T>();
  MasterDetailsList(
      {super.key,
      this.title,
      this.nothingSelectedWidget,
      required this.items,
      required this.masterItemBuilder,
      required this.detailsTitleBuilder,
      required this.detailsItemBuilder,
      this.sortBy,
      this.groupedBy,
      this.groupHeaderBuilder,
      this.masterViewFraction = 0.333333,
      this.transitionAnimationDuration = const Duration(milliseconds: 500),
      this.debug = false}) {
    if (sortBy != null) {
      items.sort((a, b) {
        final aVal = sortBy!(a);
        final bVal = sortBy!(b);
        return aVal.compareTo(bVal);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ElementsViewModel<T>>.reactive(
      viewModelBuilder: () => viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _buildMobileView(viewModel),
          desktop: _buildDesktopView(viewModel),
          tablet: _buildTabletView(viewModel),
        );
      },
    );
  }

  DesktopView<T> _buildDesktopView(ElementsViewModel<T> viewModel) {
    return DesktopView<T>(
      items: items,
      nothingSelectedWidget: nothingSelectedWidget,
      viewModel: viewModel,
      masterItemBuilder: masterItemBuilder,
      detailsTitleBuilder: detailsTitleBuilder,
      detailsItemBuilder: detailsItemBuilder,
      groupedBy: groupedBy,
      groupHeaderBuilder: groupHeaderBuilder,
      title: title,
      masterViewFraction: masterViewFraction,
      masterViewMaxWidth: 300,
      transitionAnimationDuration: transitionAnimationDuration,
      debug: debug,
    );
  }

  TabletView<T> _buildTabletView(ElementsViewModel<T> viewModel) {
    return TabletView<T>(
      items: items,
      nothingSelectedWidget: nothingSelectedWidget,
      viewModel: viewModel,
      masterItemBuilder: masterItemBuilder,
      detailsTitleBuilder: detailsTitleBuilder,
      detailsItemBuilder: detailsItemBuilder,
      groupedBy: groupedBy,
      groupHeaderBuilder: groupHeaderBuilder,
      title: title,
      masterViewFraction: masterViewFraction,
      masterViewMaxWidth: 300,
      transitionAnimationDuration: transitionAnimationDuration,
      debug: debug,
    );
  }

  MobileView<T> _buildMobileView(ElementsViewModel<T> viewModel) {
    return MobileView<T>(
      items: items,
      nothingSelectedWidget: nothingSelectedWidget,
      viewModel: viewModel,
      masterItemBuilder: masterItemBuilder,
      detailsTitleBuilder: detailsTitleBuilder,
      detailsItemBuilder: detailsItemBuilder,
      groupedBy: groupedBy,
      groupHeaderBuilder: groupHeaderBuilder,
      transitionAnimationDuration: transitionAnimationDuration,
      title: title,
      debug: debug,
    );
  }
}
