import 'package:flutter/material.dart';
import '../provider/order.dart';
import 'package:provider/provider.dart';
import '../widgets/Order_Item.dart';
import '../widgets/app_drawer.dart';

class OrderedItems extends StatefulWidget {
  static String RouteName = 'orderded_items';
  const OrderedItems({Key key}) : super(key: key);

  @override
  State<OrderedItems> createState() => _OrderedItemsState();
}

class _OrderedItemsState extends State<OrderedItems> {
  Future<void> _orderFuture;

  Future<void> _obtainOrderFuture() async {
    await Provider.of<Orders>(context, listen: false).fetchAndSet();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _orderFuture,
        builder: (cntx, snapShotData) {
          if (snapShotData.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShotData.error != null) {
            return Center(
              child: Text('An error Occured'),
            );
          }
          return Consumer<Orders>(
            builder: (cntx, myOrder, child) => ListView.builder(
              itemCount: myOrder.orders.length,
              itemBuilder: (context, index) => OrderItems(
                order: myOrder.orders[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
