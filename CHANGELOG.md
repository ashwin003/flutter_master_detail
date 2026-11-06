# 1.0.0
* Initial Release

# 1.1.0
* Adds logic for grouping listview

# 1.1.1
* Updates title builder for details view to handle expanded view

# 1.1.2
* Minor Updates

# 1.1.3
* Minor Updates

# 1.1.4
* Performance improvements

# 1.1.5
* Minor changes

# 1.1.6
* Upgrades to a newer platform

# 1.2.0
* Adds iOS / macOS Settings-style drill-down navigation: the details pane now has its own navigator, so pages pushed from a detail view (e.g. `Navigator.of(context).push(...)`) open inside the details pane while the master list stays visible on larger screens
* Back button and system / predictive back gestures pop sub-pages first, then return to the master list on mobile
* Selecting a different item starts a fresh details stack; tapping the selected item again returns to its root details page
* Details pane now animates when switching between items on tablet and desktop
* Adds a Settings example to the example app
