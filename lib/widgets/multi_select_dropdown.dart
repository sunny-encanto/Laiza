import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/selectionPopupModel/selection_popup_model.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class MultiSelectDropdownWithSearch extends StatelessWidget {
  MultiSelectDropdownWithSearch({
    super.key,
    required this.searchController,
    required this.items,
    required this.hint,
    this.validator,
    this.onChanged,
    required this.initialItems,
  }) {
    // Initialize the selected items
    // searchController.selectedItems.addAll(initialItems);
    searchController.selectedItems.addAll(initialItems);
    print("Initial selected items: ${searchController.selectedItems}");
    print("Initial selected items: ${initialItems.length}");
  }

  final MultiSelectController<SelectionPopupModel> searchController;
  final List<SelectionPopupModel> items;
  final String hint;
  final FormFieldValidator<String>? validator;
  final ValueChanged<List<SelectionPopupModel>>? onChanged;
  final List<DropdownItem<SelectionPopupModel>> initialItems;

  @override
  Widget build(BuildContext context) {
    return MultiDropdown<SelectionPopupModel>(
      items: items
          .map((e) =>
              DropdownItem<SelectionPopupModel>(label: e.title, value: e))
          .toList(),
      controller: searchController,
      enabled: true,
      searchEnabled: true,
      chipDecoration: ChipDecoration(
        deleteIcon: Icon(
          Icons.close,
          color: Colors.white,
          size: 15.h,
        ),
        labelStyle: const TextStyle(color: Colors.white),
        backgroundColor: AppColor.primary,
        wrap: true,
        runSpacing: 2,
        spacing: 10,
      ),
      fieldDecoration: FieldDecoration(
        hintText: hint,
        showClearIcon: false,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      dropdownDecoration: const DropdownDecoration(
        marginTop: 2,
        maxHeight: 500,
      ),
      dropdownItemDecoration: DropdownItemDecoration(
        selectedIcon: const Icon(Icons.check_box, color: Colors.green),
        disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
      ),
      onSelectionChange: (List<SelectionPopupModel> selectedItems) {
        if (onChanged != null) {
          onChanged!(selectedItems);
        }
      },
    );
  }
}
