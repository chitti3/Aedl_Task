import 'dart:convert';

import 'package:aedl/components/bottom_navbar.dart';
import 'package:aedl/model/digital_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../enums.dart';



class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  String url = "http://15.206.132.105/ulektzConnectNew/campusAPI/api.php";
  bool isloading =  true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
   DigitalLibrary? _digitalLibrary;
   String search = "";

  @override
  void initState() {
    // TODO: implement initState
    fetchapi(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
       appBar: AppBar(title: Text("Digital Library"),),
       body:  isloading?Center(child: CircularProgressIndicator(),):
      Column(
       children: [
              Searchbar(),
                Expanded(child: ListView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    booklist(),
                  ],
                ))
       ],
      ),
      bottomNavigationBar: BottomNavbar(MenuState.home),

    );
  }

  void fetchapi(String url) async {
    final data = {
      'functionName': 'elibraryBookStore',
      'page': '1',
      'size':'',
      'instId':'132',
      'userId':'192277',
      'searchTxt':search,

    };

    print(data);

    Request req = Request('GET', Uri.parse(url))
      ..body = json.encode(data)
      ..headers.addAll({
        "Content-type": "application/json",
      });

    var response = await req.send();

    if(response.statusCode==200){
      final respStr = await response.stream.bytesToString();


      setState(() {
        isloading = false;
        _digitalLibrary = DigitalLibrary.fromJson(jsonDecode(respStr.toString()));
      });
    }


  //  print(_digitalLibrary!.output!.result!.status);
  }

  booklist() {
     return  _digitalLibrary!.output!.result!.status.toString()=="success"?ListView.builder (
       shrinkWrap: true,
       primary: false,
       itemBuilder: (context, position) {
         return bookdata(_digitalLibrary!.output!.result!.bookDet![position]);
       },
       itemCount:_digitalLibrary!.output!.result!.bookDet!.length,
       // ),
       // ],
     ):Center(child: Text("No Data"),);
  }

  bookdata(BookDet bookDet) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                image: DecorationImage(image: NetworkImage(bookDet.imagePath.toString()))),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 8, top: 4),
                    child: Text(
                      bookDet.name.toString(),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 1),
                    child: Row(
                      // direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 5,
                            child:  RatingBar.builder(
                                initialRating: double.parse(bookDet.contentType),
                                minRating: 1,
                                itemSize: 15,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) =>
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 10,
                                    ), onRatingUpdate:(rating) {
                              print(rating);
                            })),

                        Expanded(
                          flex: 9,
                          child:   Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.all(10),
                            child: Container(
                              height: 50,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    border: Border.all(
                                        color:  Colors.blue
                                    ),


                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                margin: EdgeInsets.all(5),

                                child: new Center(
                                  child:  Text(bookDet.status.toString(),
                                    style: TextStyle(color: Colors.white, fontSize: 10),
                                    textAlign: TextAlign.center,),
                                )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Searchbar() {
    return Padding(
      padding:EdgeInsets.all(10),
      child:  Container(
        width: double.infinity,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: Color(0xFF979797)
          ),
        ),
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              search = value;
            });
            fetchapi(url);
          },
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Search Book",
              prefixIcon: Icon(Icons.search)),
        ),
      ),
    );
  }
}
