// ignore_for_file: curly_braces_in_flow_control_structures

class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileBg;
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
  int? productCategory;
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
  String? bio;
  bool? isFollowed;
  int? followersCount;
  int? followingCount;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profileBg,
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
    this.instagramUserName,
    this.bio,
    this.isFollowed,
    this.followersCount,
    this.followingCount,
  });

// CopyWith function
  UserModel copyWith({
    bool? isFollowed,
  }) {
    return UserModel(
        id: id,
        name: name,
        email: email,
        profileBg: profileBg,
        token: token,
        role: role,
        profileImg: profileImg,
        username: username,
        emailVerifiedAt: emailVerifiedAt,
        phoneNumber: phoneNumber,
        brandName: brandName,
        companyName: companyName,
        country: country,
        state: state,
        city: city,
        productCategory: productCategory,
        instagramFollowers: instagramFollowers,
        instagramLink: instagramLink,
        userType: userType,
        isLogin: isLogin,
        isDelete: isDelete,
        isApprove: isApprove,
        isVerified: isVerified,
        isProfileComplete: isProfileComplete,
        facebookLink: facebookLink,
        snapchatLink: snapchatLink,
        xComLink: xComLink,
        accountNumber: accountNumber,
        iFCCode: iFCCode,
        branchName: branchName,
        accountHolderName: accountHolderName,
        aadharNumber: aadharNumber,
        bankVerification: bankVerification,
        instagramUserName: instagramUserName,
        bio: bio,
        isFollowed: isFollowed ?? this.isFollowed,
        followersCount: followersCount,
        followingCount: followingCount);
  }

  factory UserModel.fromJson(
          {required Map<String, dynamic> json, required String id}) =>
      UserModel(
        id: id,
        name: json['name'] ?? "",
        email: json['email'] ?? "",
        // profile: json['profile'] ?? "",
        profileBg: json['background_img'] ?? "",
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
        productCategory: json['category'],
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
        bio: json['bio'],
        isFollowed: json['is_follow'],
        followersCount: json['followers_count'],
        followingCount: json['following_count'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (profileBg != null) data['background_img'] = profileBg;
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
    if (productCategory != null) data['category'] = productCategory;
    if (instagramFollowers != null)
      data['instagram_followers'] = instagramFollowers;
    if (instagramLink != null) data['instagram_link'] = instagramLink;
    if (userType != null) data['user_type'] = userType;
    if (isLogin != null) data['is_login'] = isLogin;
    if (isDelete != null) data['is_delete'] = isDelete;
    if (isApprove != null) data['is_approve'] = isApprove;
    if (isVerified != null) data['is_verified'] = isVerified;
    if (xComLink != null) data['x_account_link'] = xComLink;
    if (snapchatLink != null) data['snapchat_link'] = snapchatLink;
    if (facebookLink != null) data['facebook_link'] = facebookLink;
    if (bio != null) data['bio'] = bio;
    if (isFollowed != null) data['is_follow'] = isFollowed;
    if (isProfileComplete != null)
      data['is_profile_complete'] = isProfileComplete;
    if (instagramUserName != null) data['insta_username'] = instagramUserName;
    if (followersCount != null) data['followers_count'] = followersCount;
    if (followingCount != null) data['following_count'] = followingCount;
    return data;
  }
}
