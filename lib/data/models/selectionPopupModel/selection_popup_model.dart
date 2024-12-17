///SelectionPopupModel is common model
///used for setting data into dropdowns
class SelectionPopupModel {
  String title;
  dynamic value;

  SelectionPopupModel({
    required this.title,
    this.value,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectionPopupModel &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
