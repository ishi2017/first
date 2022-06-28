import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  static String RouteName = '/edit_screen';
  const EditProductScreen({Key key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _pricefocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool editing = false;
  bool initValue = true;
  Product _existingProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );
  final edit = {
    'id': '',
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
    'isFavourite': false,
  };

  void updateState() {
    if (!_imageUrlFocus.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageUrlFocus.addListener(updateState);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (initValue) {
      final editedProductId =
          ModalRoute.of(context).settings.arguments as String;
      if (editedProductId != null) {
        final editedProduct = Provider.of<Products>(context)
            .items
            .firstWhere((element) => element.id == editedProductId);
        edit['id'] = editedProduct.id;
        edit['title'] = editedProduct.title;
        edit['description'] = editedProduct.description;
        edit['price'] = editedProduct.price.toString();
        edit['imageUrl'] = editedProduct.imageUrl;
        edit['isFavourite'] = editedProduct.isFavorite;
        editing = true;
        _imageController.text = editedProduct.imageUrl;
      }
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocus.dispose();
    _pricefocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void saveMyFormState() {
    final validated = _formKey.currentState.validate();
    if (!validated) {
      return;
    }

    _formKey.currentState.save();
    print(_existingProduct.id);
    print(_existingProduct.title);
    print(_existingProduct.description);
    print(_existingProduct.price);
    print(_existingProduct.imageUrl);

    final myProduct = Provider.of<Products>(context, listen: false);

    if (editing) {
      _existingProduct = Product(
        id: edit['id'],
        title: _existingProduct.title,
        description: _existingProduct.description,
        price: _existingProduct.price,
        imageUrl: _existingProduct.imageUrl,
        isFavorite: edit['isFavourite'],
      );
      myProduct.updateProduct(_existingProduct);
    } else {
      myProduct.addProduct(_existingProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final lastProductId = Provider.of<Products>(context).items.last.id;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              saveMyFormState();
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  initialValue: edit['title'],
                  decoration: InputDecoration(
                    label: Text('Title'),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_pricefocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter a Valid Title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _existingProduct = Product(
                      id: '',
                      title: value,
                      description: '',
                      price: 0.0,
                      imageUrl: '',
                    );
                  },
                ),
                TextFormField(
                  initialValue: edit['price'],
                  decoration: InputDecoration(
                    label: Text('Price'),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _pricefocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Ivalid Value for Price ';
                    }
                    if (double.parse(value) <= 0.0) {
                      return 'Price can not be less than or equal to ZERO';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    var lastIDNo = int.parse(lastProductId.substring(1));
                    var newID = 'p' + (lastIDNo + 1).toString();
                    _existingProduct = Product(
                      id: newID,
                      title: _existingProduct.title,
                      description: '',
                      price: double.parse(value),
                      imageUrl: '',
                    );
                  },
                ),
                TextFormField(
                  initialValue: edit['description'],
                  decoration: InputDecoration(
                    label: Text('Description'),
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter description';
                    }
                    if (value.length < 15) {
                      return 'Minimum 15 character required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _existingProduct = Product(
                      id: _existingProduct.id,
                      title: _existingProduct.title,
                      description: value,
                      price: _existingProduct.price,
                      imageUrl: '',
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2)),
                      child: _imageController.text.isEmpty
                          ? Text('Enter URL')
                          : FittedBox(
                              child: Image.network(
                                _imageController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text('Enter Url'),
                        ),
                        keyboardType: TextInputType.url,
                        controller: _imageController,
                        focusNode: _imageUrlFocus,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter a URL';
                          }
                          if (!(value.startsWith('http') ||
                              value.startsWith('https'))) {
                            _imageController.text = '';
                            return 'Not a valid URL';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _existingProduct = Product(
                            id: _existingProduct.id,
                            title: _existingProduct.title,
                            description: _existingProduct.description,
                            price: _existingProduct.price,
                            imageUrl: value,
                          );
                        },
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          saveMyFormState();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
