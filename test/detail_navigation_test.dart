import 'package:flutter/material.dart';
import 'package:flutter_master_detail/flutter_master_detail.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app() {
  return MaterialApp(
    home: MasterDetailsList<String>(
      items: ['General', 'Display'],
      title: const FlexibleSpaceBar(title: Text('Settings')),
      masterItemBuilder: (context, item, selected) =>
          ListTile(title: Text('master:$item'), selected: selected),
      detailsTitleBuilder: (context, item) =>
          FlexibleSpaceBar(title: Text('title:$item')),
      detailsItemBuilder: (context, item) => Builder(
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => Scaffold(
                appBar: AppBar(title: Text('sub:$item')),
              ),
            ),
          ),
          child: Text('open:$item'),
        ),
      ),
    ),
  );
}

Future<void> _setSize(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('desktop: sub-pages open inside the details pane',
      (tester) async {
    await _setSize(tester, const Size(1200, 800));
    await tester.pumpWidget(_app());

    await tester.tap(find.text('master:General'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('open:General'));
    await tester.pumpAndSettle();

    // Sub-page is shown, and the master list is still visible beside it.
    expect(find.text('sub:General'), findsOneWidget);
    expect(find.text('master:Display'), findsOneWidget);
    final subPageLeft = tester.getTopLeft(find.text('sub:General')).dx;
    expect(subPageLeft, greaterThan(300));

    // The sub-page's back button returns to the category's root page.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('sub:General'), findsNothing);
    expect(find.text('open:General'), findsOneWidget);
  });

  testWidgets('desktop: re-selecting the item resets to its root page',
      (tester) async {
    await _setSize(tester, const Size(1200, 800));
    await tester.pumpWidget(_app());

    await tester.tap(find.text('master:General'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('open:General'));
    await tester.pumpAndSettle();
    expect(find.text('sub:General'), findsOneWidget);

    await tester.tap(find.text('master:General'));
    await tester.pumpAndSettle();
    expect(find.text('sub:General'), findsNothing);
    expect(find.text('open:General'), findsOneWidget);
  });

  testWidgets('desktop: selecting another item starts a fresh stack',
      (tester) async {
    await _setSize(tester, const Size(1200, 800));
    await tester.pumpWidget(_app());

    await tester.tap(find.text('master:General'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('open:General'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('master:Display'));
    await tester.pumpAndSettle();
    expect(find.text('sub:General'), findsNothing);
    expect(find.text('open:Display'), findsOneWidget);
  });

  testWidgets('mobile: back pops sub-page, then returns to the list',
      (tester) async {
    await _setSize(tester, const Size(400, 800));
    await tester.pumpWidget(_app());

    await tester.tap(find.text('master:General'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('open:General'));
    await tester.pumpAndSettle();
    expect(find.text('sub:General'), findsOneWidget);

    // System back pops the sub-page first...
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('sub:General'), findsNothing);
    expect(find.text('open:General'), findsOneWidget);

    // ...then goes back to the master list.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('master:Display'), findsOneWidget);
    expect(find.text('open:General'), findsNothing);
  });

  testWidgets('mobile: app bar back button on root page returns to the list',
      (tester) async {
    await _setSize(tester, const Size(400, 800));
    await tester.pumpWidget(_app());

    await tester.tap(find.text('master:General'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('master:Display'), findsOneWidget);
  });
}
