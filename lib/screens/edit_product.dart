import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static String routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var product =
      Product(id: '', title: '', price: 0, description: '', imageUrl: '');

  void _updateImageURL() {
    if (_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (_form.currentState != null) {
      // Returns true if all validator functions on
      // the inputs pass
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        return;
      }
      // Execute all onSaved functions in form
      _form.currentState!.save();
      Provider.of<ProductsProvider>(context, listen: false).addProduct(product);
      Navigator.of(context).pop();
    }
  }

  String? _validateText(String? value, String type) {
    if (value == null || value.isEmpty) {
      // If a text is returned the validator failed
      return 'Please enter a $type';
    }
    // If null is returned the validtor passes
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    // If try parse equal null number is not valid
    if (double.tryParse(value) == null) {
      return 'Please enter a valid price';
    }
    if (double.parse(value) <= 0) {
      return 'Please enter a price above 0';
    }
    return null;
  }

  String? _validImageUrl(String? value) {
    if (value == null ||
        value.isEmpty ||
        !Uri.parse(value).isAbsolute ||
        (!value.endsWith('.png') &&
            !value.endsWith('.jpg') &&
            !value.endsWith('.jpeg'))) {
      return 'Please enter an image URL';
    }
    return null;
  }

  @override
  void initState() {
    _imageUrlController.addListener(_updateImageURL);
    super.initState();
  }

  // Need to dispose focusNodes and controllers
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.removeListener(_updateImageURL);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: ListView(children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                validator: (value) => _validateText(value, 'title'),
                onFieldSubmitted: (_) {
                  // Function is called when text input action is pressed
                  // i.e. when next or done is pressed
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  product = Product(
                      id: product.id,
                      title: value as String,
                      description: product.description,
                      price: product.price,
                      imageUrl: product.imageUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                validator: (value) => _validatePrice(value),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  product = Product(
                      id: product.id,
                      title: product.title,
                      description: product.description,
                      price: double.parse(value as String),
                      imageUrl: product.imageUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                validator: (value) => _validateText(value, 'description'),
                onSaved: (value) {
                  product = Product(
                      id: product.id,
                      title: product.title,
                      description: value as String,
                      price: product.price,
                      imageUrl: product.imageUrl);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5, right: 10),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                    child: (_imageUrlController.text.isEmpty ||
                            !Uri.parse(_imageUrlController.text).isAbsolute)
                        ? const Text('Enter Image URL')
                        : FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(
                              _imageUrlController.text,
                              //Handles errors
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      focusNode: _imageUrlFocusNode,
                      controller: _imageUrlController,
                      validator: (value) => _validImageUrl(value),
                      onSaved: (value) {
                        product = Product(
                            id: product.id,
                            title: product.title,
                            description: product.description,
                            price: product.price,
                            imageUrl: value as String);
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  ),
                ],
              )
            ]),
          )),
    );
  }
}
