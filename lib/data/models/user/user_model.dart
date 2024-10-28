class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? profile;
  final String? token;
  final String? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profile,
    this.token,
    this.role,
  });

  factory UserModel.fromJson(
          {required Map<String, dynamic> json, required String id}) =>
      UserModel(
        id: id,
        name: json['name'] ?? "",
        email: json['email'] ?? "",
        profile: json['profile'] ?? "",
        token: json['token'] ?? "",
        role: json['role'] ?? "",
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (profile != null) data['profile'] = profile;
    if (token != null) data['token'] = token;
    if (role != null) data['role'] = role;
    return data;
  }
}
