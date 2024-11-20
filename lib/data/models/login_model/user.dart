class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic phoneNumber;
  dynamic username;
  dynamic brandName;
  dynamic companyName;
  dynamic state;
  dynamic city;
  dynamic productCategory;
  dynamic instagramFollowers;
  dynamic instagramLink;
  String? userType;
  int? isLogin;
  int? isDelete;
  int? isApprove;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phoneNumber,
    this.username,
    this.brandName,
    this.companyName,
    this.state,
    this.city,
    this.productCategory,
    this.instagramFollowers,
    this.instagramLink,
    this.userType,
    this.isLogin,
    this.isDelete,
    this.isApprove,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        emailVerifiedAt: json['email_verified_at'] as dynamic,
        phoneNumber: json['phone_number'] as dynamic,
        username: json['username'] as dynamic,
        brandName: json['brand_name'] as dynamic,
        companyName: json['company_name'] as dynamic,
        state: json['state'] as dynamic,
        city: json['city'] as dynamic,
        productCategory: json['product_category'] as dynamic,
        instagramFollowers: json['instagram_followers'] as dynamic,
        instagramLink: json['instagram_link'] as dynamic,
        userType: json['user_type'] as String?,
        isLogin: json['is_login'] as int?,
        isDelete: json['is_delete'] as int?,
        isApprove: json['is_approve'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'email_verified_at': emailVerifiedAt,
        'phone_number': phoneNumber,
        'username': username,
        'brand_name': brandName,
        'company_name': companyName,
        'state': state,
        'city': city,
        'product_category': productCategory,
        'instagram_followers': instagramFollowers,
        'instagram_link': instagramLink,
        'user_type': userType,
        'is_login': isLogin,
        'is_delete': isDelete,
        'is_approve': isApprove,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
