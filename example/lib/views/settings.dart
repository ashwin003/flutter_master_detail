import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_master_detail/flutter_master_detail.dart';

/// A Settings-style example: picking a category shows its page in the
/// details pane, and rows on that page drill further into sub-pages that
/// stay inside the details pane (like iOS / macOS Settings).
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterDetailsList<_Category>(
      items: _categories,
      title: const FlexibleSpaceBar(title: Text('Settings')),
      masterItemBuilder: (context, category, isSelected) => ListTile(
        leading: Icon(category.icon),
        title: Text(category.name),
        selected: isSelected,
      ),
      detailsTitleBuilder: (context, category) =>
          FlexibleSpaceBar(title: Text(category.name), centerTitle: false),
      detailsItemBuilder: (context, category) => category.builder(context),
      masterViewFraction: 0.4,
    );
  }
}

class _Category {
  final String name;
  final IconData icon;
  final WidgetBuilder builder;
  const _Category(this.name, this.icon, this.builder);
}

final _categories = [
  _Category('General', Icons.settings, (_) => const _GeneralSettings()),
  _Category(
    'Appearance',
    Icons.palette,
    (_) => const _SettingsList(
      children: [
        ListTile(title: Text('Light')),
        ListTile(title: Text('Dark')),
        ListTile(title: Text('Automatic')),
      ],
    ),
  ),
  _Category(
    'Notifications',
    Icons.notifications,
    (_) => const _SettingsList(
      children: [
        ListTile(title: Text('Show previews')),
        ListTile(title: Text('Scheduled summary')),
      ],
    ),
  ),
];

/// Pushes a sub-page. Because the details pane has its own navigator,
/// a plain `Navigator.of(context).push` keeps the page inside the pane.
/// Use `rootNavigator: true` instead to cover the whole screen.
void _open(BuildContext context, String title, Widget body) {
  Navigator.of(context).push(
    CupertinoPageRoute<void>(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: body,
      ),
    ),
  );
}

class _GeneralSettings extends StatelessWidget {
  const _GeneralSettings();

  @override
  Widget build(BuildContext context) {
    return _SettingsList(
      children: [
        _NavTile(
          icon: Icons.info_outline,
          title: 'About',
          onTap: () => _open(
            context,
            'About',
            const _SettingsList(
              children: [
                ListTile(title: Text('Name'), trailing: Text('My Device')),
                ListTile(title: Text('Version'), trailing: Text('1.1.5')),
              ],
            ),
          ),
        ),
        _NavTile(
          icon: Icons.system_update,
          title: 'Software Update',
          onTap: () =>
              _open(context, 'Software Update', const _SoftwareUpdate()),
        ),
        _NavTile(
          icon: Icons.storage,
          title: 'Storage',
          onTap: () => _open(
            context,
            'Storage',
            const Center(child: Text('42 GB of 128 GB used')),
          ),
        ),
      ],
    );
  }
}

class _SoftwareUpdate extends StatelessWidget {
  const _SoftwareUpdate();

  @override
  Widget build(BuildContext context) {
    return _SettingsList(
      children: [
        const ListTile(
          title: Text('Your software is up to date'),
          subtitle: Text('Version 1.1.5'),
        ),
        // A second level of drill-down, still inside the details pane.
        _NavTile(
          icon: Icons.autorenew,
          title: 'Automatic Updates',
          onTap: () => _open(
            context,
            'Automatic Updates',
            _SettingsList(
              children: [
                SwitchListTile(
                  title: const Text('Download updates'),
                  value: true,
                  onChanged: (_) {},
                ),
                SwitchListTile(
                  title: const Text('Install updates'),
                  value: false,
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _NavTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class _SettingsList extends StatelessWidget {
  final List<Widget> children;
  const _SettingsList({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: children);
  }
}
