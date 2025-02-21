import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/selectionPopupModel/selection_popup_model.dart';

class SearchableMultiSelectDialog extends StatefulWidget {
  final List<SelectionPopupModel> items;
  final List<SelectionPopupModel> selectedItems;
  final Function(List<SelectionPopupModel>) onSelectionChanged;

  const SearchableMultiSelectDialog({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<SearchableMultiSelectDialog> createState() =>
      _SearchableMultiSelectDialogState();
}

class _SearchableMultiSelectDialogState
    extends State<SearchableMultiSelectDialog> {
  late List<SelectionPopupModel> _filteredItems;
  late List<SelectionPopupModel> _selectedItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = [...widget.items];
    _selectedItems = [...widget.selectedItems];
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterItems,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return CheckboxListTile(
                    title: Text(item.title),
                    value: _selectedItems.contains(item),
                    onChanged: (bool? value) {
                      setState(() {
                        if (_selectedItems.contains(item)) {
                          _selectedItems.remove(item);
                        } else {
                          _selectedItems.add(item);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onSelectionChanged(_selectedItems);
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
