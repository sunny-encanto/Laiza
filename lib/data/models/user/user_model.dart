// ignore_for_file: curly_braces_in_flow_control_structures

class UserModel {
  String? id;
  String? name;
  String? email;
  String? profile;
  String? token;
  String? role;
  String? profileImg;
  String? username;
  dynamic emailVerifiedAt;
  String? phoneNumber;
  dynamic brandName;
  dynamic companyName;
  num? country;
  num? state;
  num? city;
  String? productCategory;
  String? instagramFollowers;

  String? userType;
  num? isLogin;
  num? isDelete;
  num? isApprove;
  num? isVerified;
  num? isProfileComplete;

  String? instagramLink;
  String? instagramUserName;
  String? xComLink;
  String? facebookLink;
  String? snapchatLink;
  String? accountNumber;
  String? iFCCode;
  String? branchName;
  String? accountHolderName;
  String? aadharNumber;
  String? bankVerification;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.profile,
      this.token,
      this.role,
      this.profileImg,
      this.username,
      this.emailVerifiedAt,
      this.phoneNumber,
      this.brandName,
      this.companyName,
      this.country,
      this.state,
      this.city,
      this.productCategory,
      this.instagramFollowers,
      this.instagramLink,
      this.userType,
      this.isLogin,
      this.isDelete,
      this.isApprove,
      this.isVerified,
      this.isProfileComplete,
      this.facebookLink,
      this.snapchatLink,
      this.xComLink,
      this.accountNumber,
      this.iFCCode,
      this.branchName,
      this.accountHolderName,
      this.aadharNumber,
      this.bankVerification,
      this.instagramUserName});

  factory UserModel.fromJson(
          {required Map<String, dynamic> json, required String id}) =>
      UserModel(
        id: id,
        name: json['name'] ?? "",
        email: json['email'] ?? "",
        profile: json['profile'] ?? "",
        token: json['token'] ?? "",
        role: json['role'] ?? "",
        profileImg: json['profile_img'],
        username: json['username'],
        emailVerifiedAt: json['email_verified_at'],
        phoneNumber: json['phone_number'],
        brandName: json['brand_name'],
        companyName: json['company_name'],
        country: json['country'],
        state: json['state'],
        city: json['city'],
        productCategory: json['product_category'],
        instagramFollowers: json['instagram_followers'],
        instagramLink: json['instagram_link'],
        xComLink: json['x_account_link'],
        facebookLink: json['facebook_link'],
        snapchatLink: json['snapchat_link'],
        userType: json['user_type'],
        isLogin: json['is_login'],
        isDelete: json['is_delete'],
        isApprove: json['is_approve'],
        isVerified: json['is_verified'],
        isProfileComplete: json['is_profile_complete'],
        instagramUserName: json['insta_username'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (profile != null) data['profile'] = profile;
    if (token != null) data['token'] = token;
    if (role != null) data['role'] = role;
    if (profileImg != null) data['profile_img'] = profileImg;
    if (username != null) data['username'] = username;
    if (emailVerifiedAt != null) data['email_verified_at'] = emailVerifiedAt;
    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (brandName != null) data['brand_name'] = brandName;
    if (companyName != null) data['company_name'] = companyName;
    if (country != null) data['country'] = country;
    if (state != null) data['state'] = state;
    if (city != null) data['city'] = city;
    if (productCategory != null) data['product_category'] = productCategory;
    if (instagramFollowers != null)
      data['instagram_followers'] = instagramFollowers;
    if (instagramLink != null) data['instagram_link'] = instagramLink;
    if (userType != null) data['user_type'] = userType;
    if (isLogin != null) data['is_login'] = isLogin;
    if (isDelete != null) data['is_delete'] = isDelete;
    if (isApprove != null) data['is_approve'] = isApprove;
    if (isVerified != null) data['is_verified'] = isVerified;
    if (isProfileComplete != null)
      data['is_profile_complete'] = isProfileComplete;

    if (instagramUserName != null) data['insta_username'] = instagramUserName;
    return data;
  }
}
