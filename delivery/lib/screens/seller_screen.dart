import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/seller_card.dart';
import '../provider/auth.dart';
import '../provider/order.dart';

class SellerDashBoard extends StatefulWidget {
  static String routeName = '/seller_dashboard';
  @override
  _SellerDashBoardState createState() => _SellerDashBoardState();
}

class _SellerDashBoardState extends State<SellerDashBoard>
    with WidgetsBindingObserver {
  List<OrderItem> _loadedOrders = [];

  var _expanded = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      Provider.of<Auth>(context, listen: false).logout();
      exit(0);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false)
        .fetchforSeller()
        .then((value) {
      _loadedOrders = value;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Dinesh'),
        actions: [
          IconButton(
            onPressed: () {
              _refresh(context);
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.amber,
            ),
          ),
          ElevatedButton.icon(
            label: Text('Logout'),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed('/');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false)
              .fetchforSeller()
              .then((value) {
            _loadedOrders = value;
          }),
          builder: (cntx, snap) =>
              snap.connectionState == ConnectionState.waiting
                  ? CircularProgressIndicator()
                  : RefreshIndicator(
                      child: _loadedOrders.length <= 0
                          ? Center(
                              child: Text('No Order Received Yet'),
                            )
                          : ListView.builder(
                              itemCount: _loadedOrders.length,
                              itemBuilder: (context, index) => SellerCard(
                                order: _loadedOrders[index],
                                changeState: (() => _refresh(context)),
                              ),
                            ),
                      onRefresh: (() => _refresh(context)))),
    );
  }
}
