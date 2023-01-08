
class User{
  final String UserName;
  final String ImagePath;
  final  bool IsDarkModeOn;
   User({
    required this.UserName,
     this.ImagePath='https://th.bing.com/th/id/OIP.mzIOKRfWXfNzyzjURPQckAHaHa?w=161&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    this.IsDarkModeOn=false,

   });
   static User Fromjson(Map<String,dynamic> json){
     return User(
       UserName: json['Username'],
     ImagePath: json['ImagePath'],
       IsDarkModeOn: json['IsDarkModeOn']
     );
   }
  Map<String,dynamic> Tojson() {
    return {

       'Username':UserName,
       'ImagePath':ImagePath,
       'IsDarkModeOn':IsDarkModeOn

     };
  }


}