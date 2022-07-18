import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        title: Text('Add New Message'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Save(context);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text('Enter New Message'),
              ),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
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
                _newMsg = message(msg: value, ImageURL: _newMsg.ImageURL);
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
                      _newMsg = message(msg: _newMsg.msg, ImageURL: value);
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
    );
  }
}
