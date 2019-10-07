import 'package:flutter/material.dart';
import 'main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Drawer.dart';
import 'services/CRUD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/Maps.dart';
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
            color: Colors.green,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 180.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.network(
                            "${places.documents[i].data['placeimage']}"),
                      ),
                      Positioned(
                        bottom: 16.0,
                        left: 16.0,
                        right: 16.0,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "${places.documents[i].data['placename']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>goMap()) );}, child: Icon(Icons.map)),
                      FlatButton(onPressed: null, child: Icon(Icons.info))
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
}
