class UserModel {
  dynamic  userId, email, name, image, phone,loginBy;


  UserModel(
      {this.userId,
        this.email,
        this.name,
        this.image,
        this.phone,
        this.loginBy
      });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    {

      return UserModel(

        userId: json['id']??"",
        email: json["email"],
        name: json["name"],
        image: json["image"],
        phone: json["phone"],
          loginBy:json["loginBy"]

      );
    }
  }
}