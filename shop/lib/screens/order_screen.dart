import 'package:flutter/material.dart';
import '../provider/order.dart';
import 'package:provider/provider.dart';
import '../widgets/Order_Item.dart';
import '../widgets/app_drawer.dart';

class OrderedItems extends StatelessWidget {
  static String RouteName = 'orderded_items';
  const OrderedItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myOrder = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: myOrder.orders.length,
        itemBuilder: (context, index) => OrderItems(
          order: myOrder.orders[index],
        ),
      ),
    );
  }
}
