class UserModel {
  int? id;
  String? name;

  UserModel({
    this.id,
    this.name,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
