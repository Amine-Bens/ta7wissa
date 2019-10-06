import 'package:flutter/material.dart';
import 'main.dart';


class Drawerperso extends StatelessWidget {
  final UserDetails detailsUser;

  Drawerperso({Key key, @required this.detailsUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DrawerHeader = UserAccountsDrawerHeader(
      accountName: Text(detailsUser.userName,style: TextStyle(fontSize: 22.0),),
      accountEmail: Text(detailsUser.userEmail),
      currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(detailsUser.photoUrl),

        backgroundColor: Colors.white,
      ),
    );
    final Draweritems = ListView(
      children: <Widget>[
        DrawerHeader,
        ListTile(onTap: (){},
          title: Text("wishlist",style: TextStyle(fontSize: 16.0),),
        ),
        ListTile(
          title: Text("wishlist",style: TextStyle(fontSize: 16.0),),
        ),
        ListTile(
          title: Text("wishlist",style: TextStyle(fontSize: 16.0),),
        )
      ],
    );
    return Drawer(child: Draweritems,);
  }

}
