import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/product_list.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  // ignore: use_key_in_widget_constructors
  const ProductItem({required this.product});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                Provider.of<ProductList>(context, listen: false)
                    .removeProduct(product.id);
              },
              icon: const Icon(Icons.delete),
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }
}
