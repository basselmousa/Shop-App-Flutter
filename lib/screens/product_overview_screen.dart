import 'package:flutter/material.dart';
import 'package:shop_app/libraries/product_important_imports.dart';
import 'package:shop_app/libraries/shop_app_providers.dart';
import 'package:shop_app/screens/cart_screen.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _isLoading = false;
  var _showOnlyFavorites = false;

  // var _isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((value) => setStateIfMounted(() {
              _isLoading = false;
            }))
        .catchError((onError) => setStateIfMounted((){
        _isLoading = false;
        }));
  }
  // To Let You Use SetState in initState
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favorite"),
                value: FilterOption.Favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOption.All,
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch, value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.cartRouteName),
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(),)
          : ProductsGrid(_showOnlyFavorites),
      drawer: AppDrawer(),
    );
  }
}

enum FilterOption { Favorites, All }
