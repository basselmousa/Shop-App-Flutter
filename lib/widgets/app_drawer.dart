import 'package:flutter/material.dart';
import 'package:shop_app/libraries/shop_app_providers.dart';
import 'package:shop_app/libraries/shop_app_screens.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hello Friend"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          buildDrawerListTile(
              context: context,
              name: "Shop",
              iconData: Icons.shop,
              routeName: '/'),
          Divider(),
          buildDrawerListTile(
              context: context,
              name: "Orders",
              iconData: Icons.payment,
              routeName: OrdersScreen.ordersRouteName),
          Divider(),
          buildDrawerListTile(
              context: context,
              name: "Manage Product",
              iconData: Icons.edit,
              routeName: UserProductScreen.userProductRouteName),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }

  ListTile buildDrawerListTile(
      {@required BuildContext context,
      @required String name,
      @required IconData iconData,
      @required routeName}) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(name),
      onTap: () => Navigator.of(context).pushReplacementNamed(routeName),
    );
  }
}
