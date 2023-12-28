class UserModel {
  int? id;
  String? name;
  String? deviceId;
  String? picturePath;

  UserModel({
    this.id,
    this.name,
    this.deviceId,
    this.picturePath,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deviceId = json['device_id'];
    picturePath = json['profile_picture_path'];
  }
}
