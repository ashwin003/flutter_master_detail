import 'package:flutter/material.dart';
import 'desktop_view.dart';
import 'elements_view_model.dart';
import 'mobile_view.dart';
import 'tablet_view.dart';
import 'types/details_title_config.dart';
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
  final types.Data<T>? sortBy;
  final types.Data<T>? groupedBy;
  final types.GroupHeader? groupHeaderBuilder;
  final double masterViewFraction;
  final Duration transitionAnimationDuration;
  final DetailsTitleConfig detailsTitleConfig;
  final ElementsViewModel<T> viewModel = ElementsViewModel<T>();
  MasterDetailsList({
    super.key,
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
    this.detailsTitleConfig = const DetailsTitleConfig(),
  }) {
    _sort([
      groupedBy,
      sortBy,
    ]);
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
      detailsTitleConfig: detailsTitleConfig,
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
      detailsTitleConfig: detailsTitleConfig,
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
      detailsTitleConfig: detailsTitleConfig,
    );
  }

  void _sort(List<types.Data<T>?> sorters) {
    for (var i = 0; i < sorters.length; i++) {
      final sorter = sorters.elementAt(i);
      final prevSorter =
          i == 0 ? sorters.elementAt(i) : sorters.elementAt(i - 1);
      if (sorter != null) {
        items.sort((a, b) {
          if (prevSorter != null) {
            final aVal = prevSorter(a);
            final bVal = prevSorter(b);
            final res = aVal.compareTo(bVal);
            if (res != 0) {
              return res;
            }
          }

          return sorter(a).compareTo(sorter(b));
        });
      }
    }
  }
}
