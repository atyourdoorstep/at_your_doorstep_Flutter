import 'dart:convert';

import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ServicesPage extends StatefulWidget {
 final servName;
 final parentServName;
 final categoryId;

 ServicesPage({this.servName, this.parentServName,this.categoryId});

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  var servName;
  var parentServName;
  var categoryID;
  bool executed = false;
  var categoryItem;

  @override
  void initState() {
    executed = false;
    servName = ucFirst(widget.servName);
    parentServName = widget.parentServName;
    categoryID = widget.categoryId;
    getCategoryItems(categoryID);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
        title: Text(servName,
            style: TextStyle(
                fontSize: 23,
                color: Colors.red,
                fontFamily: "PTSans",
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0),
        ),
      ),
      body: executed ? Column(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                  "Services > $parentServName > Categories > $servName",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black26,
                                      fontFamily: "PTSans",
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2.0)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: categoryItem.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0,1.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              //border: Border.all(color: Colors.red),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          child: Image.network(categoryItem[index]['image'])),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text("Rs. "+categoryItem[index]['price'].toString(), style: TextStyle(
                                            backgroundColor: Colors.red,
                                            color: Colors.white,
                                          ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Expanded(
                                              child: Text(ucFirst(categoryItem[index]['name']),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Expanded(
                                              child: Text(ucFirst(categoryItem[index]['description'], ),
                                                overflow: TextOverflow.clip,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: Colors.black26, fontSize: 15.0),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                )
              ],
            ),
          ),
        ],
      ): SpecialSpinner(),
    );
  }

  getCategoryItems(var dataId) async {
    categoryItem={};
    var res= await CallApi().postData({"id": dataId},'/categoryItems' );
    print('did: '+dataId.toString());
    var body =json.decode(res.body);
    print(  body.toString());
    if(res.statusCode == 200){
      setState(() {
        categoryItem = body;
        print("loooo "+categoryItem.toString());
      });
      executed = true;
    }
  }
}




