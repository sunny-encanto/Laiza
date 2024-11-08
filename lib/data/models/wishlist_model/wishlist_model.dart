class WishlistModel {
  final List<Wishlist> wishlist;

  WishlistModel({
    required this.wishlist,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        wishlist: List<Wishlist>.from(
            json["wishlist"].map((x) => Wishlist.fromJson(x))),
      );
}

class Wishlist {
  final int id;
  final String title;
  final double price;
  final String thumbnail;

  Wishlist({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "thumbnail": thumbnail,
      };
}
