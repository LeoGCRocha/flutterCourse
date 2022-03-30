import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* Como sabemos que somente o botão de favorito ira atualizar podemos SETAR  o LISTEN p/ FALSE,
    e controlar o acesso usando o CONSUMER. Reduz de maneira pequena o impacto, mas não é totalmente necessário, pode ser feito direto
    Para isto basta tirar o listen e fazer normalmente sem o consumer. */
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          /* Somente nesta parte a renderização ira atualizar. */
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              onPressed: () {
                product.toggleFavorite();
              },
            ),
          ),
          title: FittedBox(
            child: Text(
              product.name,
              style: const TextStyle(fontFamily: 'Lato'),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            onPressed: () {
              cart.addItem(product);
            },
          ),
        ),
      ),
    );
  }
}
