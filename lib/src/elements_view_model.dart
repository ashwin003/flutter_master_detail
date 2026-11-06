import 'base_view_model.dart';

class ElementsViewModel<T> extends BaseViewModel {
  T? _selectedItem;
  int _detailsGeneration = 0;

  T? get selectedItem => _selectedItem;
  set selectedItem(T? item) {
    _selectedItem = item;
    notifyListeners();
  }

  /// Changes whenever the details pane should start over from its root page.
  /// Used, together with [selectedItem], as the key for the pane's navigator.
  int get detailsGeneration => _detailsGeneration;

  /// Selects [item] from the master list. Re-selecting the current item
  /// returns the details pane to its root page.
  void select(T item) {
    if (item == _selectedItem) {
      _detailsGeneration++;
    }
    selectedItem = item;
  }
}
