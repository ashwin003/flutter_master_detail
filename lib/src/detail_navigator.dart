import 'package:flutter/material.dart';

/// Hosts the details pane in its own [Navigator], so that pages pushed from
/// inside the details view (e.g. `Navigator.of(context).push(...)`) stay
/// within the pane instead of covering the whole screen, the way the
/// iOS / macOS Settings apps drill into sub-pages.
///
/// System and predictive back gestures pop the nested pages first. When the
/// pane is at its root page, back is forwarded to [onPopRoot] if one is given
/// (mobile uses this to return to the master list), otherwise it is left to
/// the enclosing navigator.
class DetailNavigator extends StatefulWidget {
  /// Builds the first (root) page of the details pane.
  final WidgetBuilder rootBuilder;

  /// Called when back is triggered while the pane is showing its root page.
  final VoidCallback? onPopRoot;

  const DetailNavigator({super.key, required this.rootBuilder, this.onPopRoot});

  @override
  State<DetailNavigator> createState() => _DetailNavigatorState();
}

class _DetailNavigatorState extends State<DetailNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  bool _nestedCanPop = false;
  ModalRoute<void>? _rootRoute;

  @override
  void didUpdateWidget(DetailNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The root route lives in the nested navigator's overlay, so it doesn't
    // rebuild with us automatically. Ask it to pick up the new builder.
    _rootRoute?.changedExternalState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: !_nestedCanPop && widget.onPopRoot == null,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final navigator = _navigatorKey.currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop(result);
        } else {
          widget.onPopRoot?.call();
        }
      },
      child: NotificationListener<NavigationNotification>(
        onNotification: (notification) {
          if (notification.canHandlePop != _nestedCanPop) {
            setState(() => _nestedCanPop = notification.canHandlePop);
          }
          // Let ancestors know too, so predictive back keeps working.
          return false;
        },
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (settings) => _rootRoute = MaterialPageRoute<void>(
            settings: settings,
            builder: (context) => widget.rootBuilder(context),
          ),
        ),
      ),
    );
  }
}
