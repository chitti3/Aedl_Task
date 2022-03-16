import 'package:aedl/components/bottom_navbar.dart';
import 'package:aedl/components/gradient_appbar.dart';
import 'package:aedl/data.dart';
import 'package:aedl/model/home_model.dart';
import 'package:aedl/screens/library_screen.dart';
import 'package:flutter/material.dart';

import '../enums.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: Column(
          children: [
            GradientAppdar(),
            Expanded(child: Builder(
              builder: (context){
                return Container(
                  margin: EdgeInsets.only(bottom: 8, left: 4, right: 4, top: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),

                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Color(0xfff8f8f8),  spreadRadius: 5),
                    ],
                  ),
                  child: GridView.builder(
                       shrinkWrap:true,
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
                      itemBuilder: (context,position){
                         return gridItem(context,AppData.homelist[position]);
                      },
                    itemCount:AppData.homelist.length,

                  ),
                );
              },
            ))
          ],
      ),
      bottomNavigationBar: BottomNavbar(MenuState.home),

    );
  }

  gridItem(BuildContext context, HomeModel homeModel) {
     return GestureDetector(
       onTap: (){
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => LibraryScreen()),
         );
         },
       child: Container(
         margin: EdgeInsets.fromLTRB(8,0,8,8),
         decoration: BoxDecoration(
           color: Color(0XFFFFFFFF),
           borderRadius: BorderRadius.all(Radius.circular(10)),

           boxShadow: <BoxShadow>[
             BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 5),
           ],
         ),
        child: Container(
          margin: EdgeInsets.fromLTRB(5,0,5,5),
          padding:EdgeInsets.fromLTRB(5,0,5,5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Image.network("https://picsum.photos/seed/picsum/200/300",height: 100,width: 100,),
              Image(image: AssetImage(homeModel.image.toString()),height: 100,width: 100,),
              Center(
                child: Text(
                homeModel.title.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                 homeModel.subtitle.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize:12),
                ),
              ),


            ],
          ),

        ),
       ),
     );
  }
}
