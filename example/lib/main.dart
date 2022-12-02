import 'package:example/types/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_master_detail/index.dart';

import 'data/contacts_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: MasterDetailsList<Contact>(
        items: contactsList,
        groupedBy: (data) => data.name[0].toString(),
        masterItemBuilder: _buildListTile,
        detailsTitleBuilder: (context, data) => FlexibleSpaceBar(
          title: Text(data.name),
          centerTitle: false,
        ),
        detailsItemBuilder: (context, data) => Center(
          child: Text(data.name),
        ),
        sortBy: (data) => data.name,
        title: const FlexibleSpaceBar(
          title: Text("Contacts"),
        ),
        masterViewFraction: 0.5,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildListTile(
    BuildContext context,
    Contact data,
    bool isSelected,
  ) {
    return ListTile(
      title: Text(data.name),
      subtitle: Text(data.email),
      selected: isSelected,
    );
  }
}
