import '../product_model/product.dart';

class SellerDetails {
  String message;
  int status;
  bool error;
  SellerDetailsData data;

  SellerDetails({
    required this.message,
    required this.status,
    required this.error,
    required this.data,
  });

  factory SellerDetails.fromJson(Map<String, dynamic> json) => SellerDetails(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        data: SellerDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": data.toJson(),
      };
}

class SellerDetailsData {
  Seller seller;
  List<Product> products;

  SellerDetailsData({
    required this.seller,
    required this.products,
  });

  factory SellerDetailsData.fromJson(Map<String, dynamic> json) =>
      SellerDetailsData(
        seller: Seller.fromJson(json["seller"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "seller": seller.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Image {
  int id;
  int productId;
  String imagePath;

  Image({
    required this.id,
    required this.productId,
    required this.imagePath,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["product_id"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image_path": imagePath,
      };
}

class Video {
  int id;
  int productId;
  String videoPath;

  Video({
    required this.id,
    required this.productId,
    required this.videoPath,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        productId: json["product_id"],
        videoPath: json["video_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "video_path": videoPath,
      };
}

class Seller {
  int id;
  String name;
  String email;
  String profileImg;

  // dynamic backgroundImg;
  // dynamic username;
  // dynamic emailVerifiedAt;
  String phoneNumber;
  String brandName;
  String companyName;

  // dynamic category;
  // dynamic productCategory;
  // dynamic instaUsername;
  // dynamic instagramFollowers;
  // dynamic instagramLink;
  // dynamic xAccountLink;
  // dynamic facebookLink;
  // dynamic snapchatLink;
  // DateTime dateOfBirth;
  String gender;
  int country;
  int state;
  int city;
  String permanentAddress;
  String userType;
  String zipCode;
  int isProfileComplete;
  int isLogin;
  int isDelete;
  int isApprove;
  int isVerified;

  // dynamic bio;
  String source;
  String isNotification;
  String sellerDescription;
  String buisnessGoals;
  String connectionStatus;

  // dynamic fcmToken;

  Seller({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImg,
    required this.phoneNumber,
    required this.brandName,
    required this.companyName,
    required this.gender,
    required this.country,
    required this.state,
    required this.city,
    required this.permanentAddress,
    required this.userType,
    required this.zipCode,
    required this.isProfileComplete,
    required this.isLogin,
    required this.isDelete,
    required this.isApprove,
    required this.isVerified,
    required this.source,
    required this.isNotification,
    required this.sellerDescription,
    required this.buisnessGoals,
    required this.connectionStatus,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        name: json["name"] ?? '',
        email: json["email"] ?? "",
        profileImg: json["profile_img"] ?? "",

        phoneNumber: json["phone_number"] ?? "",
        brandName: json["brand_name"] ?? "",
        companyName: json["company_name"] ?? "",

        gender: json["gender"] ?? '',
        country: json["country"] ?? 0,
        state: json["state"] ?? 0,
        city: json["city"] ?? 0,
        permanentAddress: json["permanent_address"] ?? '',
        userType: json["user_type"] ?? "",
        zipCode: json["zip_code"] ?? '',
        isProfileComplete: json["is_profile_complete"],
        isLogin: json["is_login"] ?? 0,
        isDelete: json["is_delete"] ?? 0,
        isApprove: json["is_approve"] ?? 0,
        isVerified: json["is_verified"] ?? 0,
        // bio: json["bio"],
        source: json["source"] ?? '',
        isNotification: json["is_notification"] ?? '',
        connectionStatus: json["connection_status"] ?? '',
        sellerDescription: json["seller_description"] ?? '',
        buisnessGoals: json["buisness_goals"] ?? '',
        // fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profile_img": profileImg,
        // "background_img": backgroundImg,
        // "username": username,
        // "email_verified_at": emailVerifiedAt,
        "phone_number": phoneNumber,
        "brand_name": brandName,
        "company_name": companyName,
        //     "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "country": country,
        "state": state,
        "city": city,
        "permanent_address": permanentAddress,
        "user_type": userType,
        "zip_code": zipCode,
        "is_profile_complete": isProfileComplete,
        "is_login": isLogin,
        "is_delete": isDelete,
        "is_approve": isApprove,
        "is_verified": isVerified,
        // "bio": bio,
        "source": source,
        "is_notification": isNotification,
        "seller_description": sellerDescription,
        "buisness_goals": buisnessGoals,
        "connection_status": connectionStatus,
        // "fcm_token": fcmToken,
      };
}
