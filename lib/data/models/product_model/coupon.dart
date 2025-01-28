class Coupon {
  int id;
  String title;
  int amount;

  Coupon({
    required this.id,
    required this.title,
    required this.amount,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
      };
}
