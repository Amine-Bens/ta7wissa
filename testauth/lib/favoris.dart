import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testauth/services/CRUD.dart';


class favoris extends StatefulWidget {
  final String userId;

  favoris(this.userId);


  @override
  _favorisState createState() => _favorisState();
}

class _favorisState extends State<favoris> {
  crudMethods crudobj = new crudMethods();
  QuerySnapshot favplaces;
  crudMethods crudObj2 = new crudMethods();
  QuerySnapshot places;

  void initState() {
    crudobj.getFav(widget.userId).then((results) {
      setState(() {
        debugPrint('$favplaces');
        favplaces = results;
      });
    });
    crudObj2.getData().then((results) {
      setState(() {
        places = results;
      });
    });

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoris"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: _favPlaces(),
    );
  }

  _favPlaces() {
    if (favplaces != null) {
      return ListView.builder(
        itemCount: favplaces.documents.length,
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
                            "${favplaces.documents[i].data['placeimage']}"),
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
                      Text("${favplaces.documents[i].data['placename']}",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline
                              .copyWith(color: Colors.black)),
                      new Padding(padding: EdgeInsets.fromLTRB(0, 0, 55, 0)),
                      FlatButton(onPressed: () {}, child: Icon(Icons.map)),
                      FlatButton(
                          onPressed: () {

                            for (int j = 0; j == places.documents.length; j++) {
                              if ((places.documents[j].data['long'] ==
                                  favplaces.documents[i].data['long']) &&
                                  (places.documents[j].data['lat'] ==
                                      favplaces.documents[i].data['lat']))
                                {
                                  setState(() {
                                    places.documents[j].data['favorit']=false;

                                  });
                                                                  }
                            }
                            String todelet = favplaces.documents[i].documentID;
                            crudobj.deletFav(todelet, widget.userId);

                          },
                          child: Icon(Icons.favorite)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      return Text("wait loading again ");
    }
  }
}
