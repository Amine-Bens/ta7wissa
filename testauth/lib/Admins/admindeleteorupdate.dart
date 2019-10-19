import 'package:flutter/material.dart';
import 'package:testauth/services/CRUD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testauth/adminscreen.dart';
import 'adminssettings.dart';



class AdminDelUp extends StatefulWidget {


  @override
  _AdminDelUpState createState() => _AdminDelUpState();
}

class _AdminDelUpState extends State<AdminDelUp> {
  crudMethods crudObj = new crudMethods();

  QuerySnapshot places;

  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        places = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Delete"),centerTitle: true,),
      body: _placeList()
    );
  }

  Widget _placeList() {
    if (places != null) {
      return ListView.builder(
        itemCount: places.documents.length,
        padding: EdgeInsets.all(5.0),
        itemBuilder: (context, i) {
          return Card(
            elevation: 22.0,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 120.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.network(
                            "${places.documents[i].data['placeimage']}"),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 16.0,
                        right: 16.0,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.bottomLeft,
                        ),
                      )
                    ],
                  ),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("${places.documents[i].data['placename']}",
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(color: Colors.black)),
                      new Padding(padding: EdgeInsets.fromLTRB(0, 0, 55, 0)),
                      FlatButton(
                          onPressed: () {
                           String delet= places.documents[i].documentID;
                            deletData(delet);
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.delete)),

                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      return Text("baliz wait loading");
    }
  }



  void deletData(String delet) {
    crudObj.deleteData(delet);
  }
}

