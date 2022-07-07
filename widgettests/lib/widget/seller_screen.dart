import 'package:flutter/material.dart';

class SellerDashBoard extends StatefulWidget {
  @override
  _SellerDashBoardState createState() => _SellerDashBoardState();
}

class _SellerDashBoardState extends State<SellerDashBoard> {
  var _openDetail = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      height: _openDetail ? 400 : 125,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal,
          width: 5,
        ),
      ),
      child: Card(
        elevation: 5,
        color: Colors.lightGreenAccent,
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 30.0,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              title: const Text(
                'Mobile No',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              subtitle: const Text(
                'Address',
                style: TextStyle(fontSize: 10),
              ),
              trailing: Column(
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _openDetail = !_openDetail;
                      });
                    },
                    icon: _openDetail
                        ? const Icon(
                            Icons.arrow_drop_up,
                            color: Colors.amberAccent,
                          )
                        : const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.amberAccent,
                          ),
                    label: const Text(
                      'Details',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            // if (_openDetail)
            SingleChildScrollView(
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  height: _openDetail ? 200 : 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //This Tile will be in builder
                        ListTile(
                          leading: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: Image.network(
                              'http://practice.host/Delivery/bun.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: const Text('Quantity Ordered',
                              style: TextStyle(fontSize: 10)),
                          subtitle: const Text('Price per Item',
                              style: TextStyle(fontSize: 10)),
                          trailing: const Text('Amount',
                              style: TextStyle(fontSize: 10)),
                        ),
                        //Below Widget only Once
                        ListTile(
                          leading: const Text('Total Amount',
                              style: TextStyle(fontSize: 10)),
                          title: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Fake Identity',
                                style: TextStyle(fontSize: 10),
                              )),
                          subtitle: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Delivered',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          trailing: const Text(
                            '------------------',
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
