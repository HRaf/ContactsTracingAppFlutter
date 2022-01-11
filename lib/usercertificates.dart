import 'dart:io';

import 'package:covid/models/covtest_model.dart';
import 'package:covid/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class UserCertificates extends StatelessWidget{
  
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificates'),
        backgroundColor: const Color(0xff00BFA6),
      ),
      body: const Certtficate(),

    );
  }
}

// Item Certficate
class Certtficate extends StatefulWidget {
  const Certtficate({ Key? key }) : super(key: key);

  @override
  _CerttficateState createState() => _CerttficateState();
}

class _CerttficateState extends State<Certtficate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Store? _store;
  List <Covtestmodel> items=[];
  late Covtestmodel ctm;
  List <Covtestmodel> ctmlist=[];


  void reload(ctmlist) {
    setState(() {
      items.addAll(ctmlist);
    });
  }




   @override
   void initState() {
   //late Covtestmodel ctm;
    super.initState();
    _controller = AnimationController(vsync: this);
   getApplicationDocumentsDirectory().then((Directory dir){
      _store=Store(getObjectBoxModel(),directory: dir.path + '/objectbox');
      final box=_store!.box<Covtestmodel>();
      //ctm = box.get(1)!;
      ctmlist=box.getAll();
      reload(ctmlist);
    });
    
  }
  

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _store?.close();
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              
              title: Text(items[index].name!),
              subtitle: Text(items[index].qrcode!),
            );
          },
        ),

      );
  }
}