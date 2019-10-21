import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testauth/services/CRUD.dart';
import 'admindeleteorupdate.dart';
import 'package:testauth/adminscreen.dart';

class AdminSettings extends StatefulWidget {
  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.redAccent,
        title: Text("Modifier Les Places"),
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: _Addplace, child: Icon(Icons.add)),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AdminDelUp()));
              },
              child: Icon(Icons.apps),
            ),
          ],
        ),
      ),
    );
  }

  _Addplace() async {
    TextEditingController placeNameControler = new TextEditingController();
    TextEditingController placeLongControler = new TextEditingController();
    TextEditingController placeLatControler = new TextEditingController();
    await showDialog<String>(
        context: context,
        child: AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            children: <Widget>[
              Text('add a place '),
              Expanded(
                  child: TextField(
                textInputAction: TextInputAction.next,
                autofocus: true,
                decoration: InputDecoration(labelText: "place name"),
                controller: placeNameControler,
              )),
              Expanded(
                  child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                autofocus: true,
                decoration: InputDecoration(labelText: "place Longitude"),
                controller: placeLongControler,
              )),
              Expanded(
                  child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                autofocus: true,
                decoration: InputDecoration(labelText: "place Latitude"),
                controller: placeLatControler,
              )),
            ],
          ),
          elevation: 8.0,
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  if (placeLatControler != null &&
                      placeLongControler != null &&
                      placeNameControler != null) {
                    Firestore.instance
                        .collection('Places')
                        .add({
                          "placename": placeNameControler.text,
                          "long": num.parse(placeLongControler.text),
                          "lat": num.parse(placeLatControler.text),
                          "favorit": placeFavorie
                        })
                        .then((result) => {
                              Navigator.pop(context),
                              placeLatControler.clear(),
                              placeLongControler.clear(),
                              placeNameControler.clear()
                            })
                        .catchError((e) => print(e));
                  }
                },
                child: Text("Add")),
            FlatButton(
                onPressed: () {
                  placeLatControler.clear();
                  placeLongControler.clear();
                  placeNameControler.clear();
                  Navigator.pop(context);
                },
                child: Text("Cancel"))
          ],
        ));
  }
}
