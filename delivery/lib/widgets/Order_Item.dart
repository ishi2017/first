import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/order.dart' as ord;

class OrderItems extends StatefulWidget {
  final ord.OrderItem order;

  const OrderItems({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeIn,
      height: _expanded ? 300 : 80,
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Text(widget.order.amount.toString()),
              title: Text(DateFormat.yMMMEd().format(widget.order.orderDate)),
              subtitle: Text('Status:' + widget.order.deliveryStatus + ' Yet'),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            // if (_expanded)
            AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeIn,
              height: _expanded ? 200 : 0,
              child: ListView.builder(
                itemCount: widget.order.cartProducts.length,
                itemBuilder: ((context, index) => ListTile(
                      leading: Text(widget.order.cartProducts[index].title),
                      trailing: Text('Piece ' +
                          widget.order.cartProducts[index].Quantity.toString() +
                          ' @ Rs.' +
                          widget.order.cartProducts[index].price.toString() +
                          ' Each'),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
