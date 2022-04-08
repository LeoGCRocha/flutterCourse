import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null) {
        final product = args as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imgUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  void _submitForm() {
    bool isValid = _formKey.currentState!.validate();
    bool hasId = _formData['id'] != null;

    if (isValid) {
      _formKey.currentState!.save();
      String _imgUrl = _formData['imgUrl'] as String;
      if (_imgUrl == "") {
        _imgUrl =
            'https://lh3.googleusercontent.com/EbXw8rOdYxOGdXEFjgNP8lh-YAuUxwhOAe2jhrz3sgqvPeMac6a6tHvT35V6YMbyNvkZL4R_a2hcYBrtfUhLvhf-N2X3OB9cvH4uMw=w1064-v0';
      }
      Product p = Product(
          id: hasId
              ? _formData['id'] as String
              : Random().nextDouble().toString(),
          name: _formData['name'] as String,
          description: _formData['description'] as String,
          price: _formData['price'] as double,
          imageUrl: _imgUrl);
      if (hasId) {
        // update
        updateProduct(p);
      } else {
        Provider.of<ProductList>(context, listen: false).addProduct(p);
      }
      Navigator.of(context).pop();
    }
  }

  void updateProduct(Product p) {
    List<Product> _items =
        Provider.of<ProductList>(context, listen: false).items;
    int index = _items.indexWhere((productRef) => (p.id == productRef.id));
    if (index >= 0) {
      Provider.of<ProductList>(context, listen: false).saveProduct(p, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(onPressed: _submitForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name'] as String,
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                validator: (_name) {
                  final String name = _name ?? ' ';
                  if (name.trim().isEmpty) {
                    return 'Campo nome não deve estar vazio';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (name) => _formData['name'] = name ?? '',
              ),
              TextFormField(
                initialValue: _formData['price'].toString(),
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (_price) {
                  double price = double.parse((_price! == '') ? '0.0' : _price);
                  if (price <= 0 || price > 9999) {
                    return 'Campo preço deve ter o valor entre 0 e 9999';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (price) => _formData['price'] =
                    double.parse((price! == '') ? '0.0' : price),
              ),
              TextFormField(
                initialValue: _formData['description'] as String,
                decoration: const InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    _formData['description'] = (description ?? ''),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Url da Imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocus,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm,
                      onSaved: (imgUrl) => _formData['imgUrl'] = imgUrl ??
                          'https://lh3.googleusercontent.com/EbXw8rOdYxOGdXEFjgNP8lh-YAuUxwhOAe2jhrz3sgqvPeMac6a6tHvT35V6YMbyNvkZL4R_a2hcYBrtfUhLvhf-N2X3OB9cvH4uMw=w1064-v0',
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Informe a Url')
                        /* Error caso a imagem não exista. */
                        : SizedBox(
                            child: Image.network(
                            _imageUrlController.text,
                            errorBuilder: (ctx, exception, stackTrace) {
                              /* Image not found input a new value. */
                              return Image.network(
                                  'https://lh3.googleusercontent.com/EbXw8rOdYxOGdXEFjgNP8lh-YAuUxwhOAe2jhrz3sgqvPeMac6a6tHvT35V6YMbyNvkZL4R_a2hcYBrtfUhLvhf-N2X3OB9cvH4uMw=w1064-v0');
                            },
                          )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
