
import 'package:flutter/material.dart';
import 'package:shop_app/libraries/product_important_imports.dart';
import 'package:shop_app/libraries/widgets_libraries.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;

  ProductsGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productDate =  Provider.of<Products>(context);
    final products = showFav ? productDate.favoriteItems : productDate.items;
    return products.isEmpty ? Center(child: Text("There is no products!"),): GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i)=>ChangeNotifierProvider.value(value: products[i], child: ProductItem(),),
      itemCount: products.length,
    );
  }
}
