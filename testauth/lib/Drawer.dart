import 'package:flutter/material.dart';
import 'favoris.dart';
import 'main.dart';

class Drawerperso extends StatelessWidget {
  final UserDetails detailsUser;

  Drawerperso({Key key, @required this.detailsUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DrawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
        detailsUser.userName,
        style: TextStyle(fontSize: 22.0),
      ),
      accountEmail: Text(detailsUser.userEmail),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(detailsUser.photoUrl),
        backgroundColor: Colors.white,
      ),
    );
    final Draweritems = ListView(
      children: <Widget>[
        DrawerHeader,
        ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new favoris(detailsUser.userId)));
          },
          title: Text(
            "Favorits",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        ListTile(
          title: Text(
            "Evenement",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        ListTile(
          title: Text(
            "Panier",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        ListTile(
          title: Text(
            "Mes Sorties",
            style: TextStyle(fontSize: 16.0),
          ),
        )
      ],
    );
    return Drawer(
      child: Draweritems,
    );
  }
}
