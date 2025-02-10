// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  List<FAQ> faqs;
  String message;
  int status;
  bool error;

  FaqModel({
    required this.faqs,
    required this.message,
    required this.status,
    required this.error,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        faqs: List<FAQ>.from(json["data"].map((x) => FAQ.fromJson(x))),
        message: json["message"],
        status: json["status"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(faqs.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "error": error,
      };
}

class FAQ {
  int id;
  String question;
  String answer;

  FAQ({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) => FAQ(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
      };
}
