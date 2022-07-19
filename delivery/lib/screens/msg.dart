import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/message.dart';
import '../provider/message.dart';

class Msg extends StatefulWidget {
  static String routeName = '/Msg';

  @override
  State<Msg> createState() => _MsgState();
}

class _MsgState extends State<Msg> {
  //const Msg({Key key}) : super(key: key);

  message _newMsg = message();

  final _imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Function setMsg;
  bool init = true;

  Save(BuildContext context) {
    final validated = _formKey.currentState.validate();
    if (!validated) {
      return;
    }
    _formKey.currentState.save();
    setMsg(_newMsg);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    setMsg = ModalRoute.of(context).settings.arguments as Function;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Save(context);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<MyAdd>(context, listen: false).getAdd().then((value) {
          _newMsg = value;
          _imageController.text = _newMsg.ImageURL;
        }),
        builder: (cntx, snap) => snap.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _newMsg.active,
                      decoration: InputDecoration(
                        label: Text('Active Status (Active/Not Active)'),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Active Status';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newMsg = message(
                            active: value,
                            minPrice: _newMsg.minPrice,
                            msg: _newMsg.msg,
                            ImageURL: _newMsg.ImageURL);
                      },
                    ),
                    TextFormField(
                      initialValue: _newMsg.minPrice,
                      decoration: InputDecoration(
                        label: Text('Enter Minimum Price'),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Minimum Value';
                        }
                        if (double.tryParse(value) == null ||
                            double.tryParse(value) == '-NaN') {
                          return 'Please Enter Valid Number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Value must be greater than Zero';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newMsg = message(
                            active: _newMsg.active,
                            minPrice: value,
                            msg: _newMsg.msg,
                            ImageURL: _newMsg.ImageURL);
                      },
                    ),
                    TextFormField(
                      initialValue: _newMsg.msg,
                      decoration: InputDecoration(
                        label: Text('Enter New Message'),
                      ),
                      //maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Msg Details';
                        }
                        if (value.length < 15) {
                          return 'Minimum 15 character required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newMsg = message(
                            active: _newMsg.active,
                            minPrice: _newMsg.minPrice,
                            msg: value,
                            ImageURL: _newMsg.ImageURL);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 2)),
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
                            //initialValue: _newMsg.ImageURL,
                            decoration: InputDecoration(
                              label: Text('Enter Url'),
                            ),
                            keyboardType: TextInputType.url,
                            controller: _imageController,
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
                              _newMsg = message(
                                  active: _newMsg.active,
                                  minPrice: _newMsg.minPrice,
                                  msg: _newMsg.msg,
                                  ImageURL: value);
                            },
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              setState(() {});
                              Save(context);
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
