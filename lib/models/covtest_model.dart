import 'package:objectbox/objectbox.dart';

@Entity()
class Covtestmodel {
  
  String? name;
  String? qrcode;
  String? dateTime;
  int id=0;

  Covtestmodel({
    this.id=0,
    required this.name, 
    required this.qrcode, 
    required this.dateTime
    });

  Covtestmodel.onlyqr(String qrcode,){
    this.qrcode=qrcode;

  }  



}
