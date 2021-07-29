import 'package:flutter/material.dart';

import 'package:shop_app/libraries/shop_app_screens.dart';
import 'package:shop_app/libraries/shop_app_providers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (ctx, authValue, previousOrders) => previousOrders
            ..getDate(authValue.token, authValue.userId,
                previousOrders == null ? null : previousOrders.orders),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(),
            update: (ctx, authValue, previousProducts) => previousProducts
              ..getDate(authValue.token, authValue.userId,
                  previousProducts == null ? null : previousProducts.items)),
      ],
      child: Consumer<Auth>(builder: (consumerContext, auth, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (futureContext, snapShot) =>
                      snapShot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
          routes: {
            ProductDetailScreen.productDetailRouteName: (context) =>
                ProductDetailScreen(),
            CartScreen.cartRouteName: (context) => CartScreen(),
            OrdersScreen.ordersRouteName: (context) => OrdersScreen(),
            UserProductScreen.userProductRouteName: (context) =>
                UserProductScreen(),
            EditProductScreen.editProductRouteName: (context) =>
                EditProductScreen(),
          },
        );
      }),
    );
  }
}
