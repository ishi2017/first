import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/seller_card.dart';
import '../provider/auth.dart';
import '../provider/order.dart';

class SellerDashBoard extends StatefulWidget {
  static String routeName = '/seller_dashboard';
  @override
  _SellerDashBoardState createState() => _SellerDashBoardState();
}

class _SellerDashBoardState extends State<SellerDashBoard> {
  List<OrderItem> _loadedOrders = [];

  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Gauli'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.of(context).pushReplacementNamed('/');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context).fetchforSeller().then((value) {
          _loadedOrders = value;
        }),
        builder: (cntx, snap) => snap.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: _loadedOrders.length,
                itemBuilder: (context, index) => SellerCard(
                  order: _loadedOrders[index],
                ),
              ),
      ),
    );
  }
}
