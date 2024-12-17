import 'package:laiza/data/models/states_model/state.dart';

class StatesModel {
  bool success;
  List<State> states;
  String message;

  StatesModel({
    required this.success,
    required this.states,
    required this.message,
  });

  factory StatesModel.fromJson(Map<String, dynamic> json) => StatesModel(
        success: json["success"],
        states: List<State>.from(json["data"].map((x) => State.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(states.map((x) => x.toJson())),
        "message": message,
      };
}
