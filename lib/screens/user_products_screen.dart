import 'package:flutter/material.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/user_product_item.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const String userProductRouteName = '/user_product';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.editProductRouteName);
              })
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapShot) =>
            snapShot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    child: Consumer<Products>(
                      builder: (ctx, productData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productData.items.length,
                          itemBuilder: (_, index) => Column(
                            children: [
                              UserProductItem(productData.items[index].id,productData.items[index].title,productData.items[index].imageUrl,),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onRefresh: () => _refreshProducts(context)),
      ),
      drawer: AppDrawer(),
    );
  }
}
