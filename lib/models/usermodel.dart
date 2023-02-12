class UserModel{
  late String name ;
  late String phone;
  late String email;
  late String uId;
  late bool isVerified ;
  late String image;
  late String coverImage;
  late String bio;
  late String token;

  UserModel(this.name,this.phone,this.email,this.uId,this.isVerified,this.image,
      this.coverImage,this.bio,this.token
      );
  UserModel.fromjson(Map<String,dynamic>?json){
    name = json!['name'] ;
    phone = json['phone']??'' ;
    email = json['email']??'' ;
    uId = json['uId'] ;
    isVerified=json['isVerified'] ??true ;
    image=json['image'] ;
    coverImage=json['coverImage'] ;
    bio=json['bio'] ;
    token=json['token']??'' ;

  }
  Map<String,dynamic> toMap(){
    return {
      'name' : name ,
      'phone' : phone ,
      'email' : email ,
      'uId' : uId ,
      'isVerified':isVerified ,
      'image':image ,
      'coverImage':coverImage ,
      'bio':bio ,
      'token':token ,
    } ;
  }
}