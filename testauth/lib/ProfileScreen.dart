import 'package:flutter/material.dart';
import 'main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Drawer.dart';
import 'services/CRUD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/Maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'favoris.dart';

class ProfileScreen extends StatefulWidget {
  final UserDetails detailsUser;

  ProfileScreen({Key key, @required this.detailsUser}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    final GoogleSignIn _gSignIn = GoogleSignIn();

    return Scaffold(
      drawer: Drawerperso(
        detailsUser: widget.detailsUser,
      ),
      appBar: AppBar(
        leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer())),
        title: Text(widget.detailsUser.userName),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              size: 20.0,
              color: Colors.white,
            ),
            onPressed: () {
              _gSignIn.signOut();
              print('Signed out');
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: _placeList(),
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
                          onPressed: () => _getlonglat(i),
                          child: Icon(Icons.map)),
                      FlatButton(
                          onPressed: () => addFavoris(i),
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
      return Text("baliz wait loading");
    }
  }

  _getlonglat(int i) {
    longlat longlatt = new longlat(
        places.documents[i].data['long'], places.documents[i].data['lat']);

    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new MyMap(longlatt)));
  }

  addFavoris(int i) {
    {
      {
        String placename = places.documents[i].data['placename'];
        String placeimage = places.documents[i].data['placeimage'];
        num long = places.documents[i].data['long'];
        num lat = places.documents[i].data['lat'];
        debugPrint(places.documents[i].data["placename"]);
        if (places.documents[i].data['favorit'] == false) {
          setState(() {
            places.documents[i].data['favorit'] = true;
          });
          Firestore.instance
              .collection('Favoris' + '${widget.detailsUser.userId}')
              .add({
            "placename": placename,
            "placeimage": placeimage,
            "long": long,
            "lat": lat,
            "favorit": true
          });
        } else {
          setState(() {
            places.documents[i].data['favorit'] = false;
          });

        }
      }
    }
  }
}

class longlat {
  final num long;

  final num lat;

  longlat(this.long, this.lat);
}
