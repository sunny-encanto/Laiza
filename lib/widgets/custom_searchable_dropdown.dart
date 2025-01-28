import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/selectionPopupModel/selection_popup_model.dart';
import 'package:laiza/widgets/custom_drop_down.dart';

class SearchableDropdown extends StatefulWidget {
  final List<SelectionPopupModel> items;
  final String hint;
  final FormFieldValidator<String>? validator;
  final ValueChanged<SelectionPopupModel>? onChanged;
  final TextEditingController controller;

  const SearchableDropdown({
    super.key,
    required this.items,
    this.hint = 'Select an item',
    this.onChanged,
    this.validator,
    required this.controller,
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  // final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<SelectionPopupModel> _filteredItems = [];
  SelectionPopupModel? _selectedItem;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: _filteredItems.isEmpty ? 0 : 200.v),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredItems[index].title),
                    onTap: () {
                      setState(() {
                        _selectedItem = _filteredItems[index];
                        widget.controller.text = _selectedItem!.title;
                      });
                      _removeOverlay();
                      if (widget.onChanged != null) {
                        widget.onChanged!(_selectedItem!);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: widget.controller,
        decoration: const CustomDropDown().decoration,
        onChanged: (value) {
          setState(() {
            _filteredItems = widget.items
                .where((item) =>
                    item.title.toLowerCase().contains(value.toLowerCase()))
                .toList();
          });
          if (_overlayEntry != null) {
            _removeOverlay();
            _showOverlay();
          }
        },
        onTap: () {
          if (_overlayEntry == null) {
            _showOverlay();
          } else {
            _removeOverlay();
          }
        },
        validator: widget.validator,
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }
}
