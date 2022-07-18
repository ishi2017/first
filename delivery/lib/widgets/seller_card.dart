import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/order.dart';
import '../provider/order.dart';

class SellerCard extends StatefulWidget {
  final OrderItem order;
  final Function changeState;

  const SellerCard({
    Key key,
    this.order,
    this.changeState,
  }) : super(key: key);

  @override
  State<SellerCard> createState() => _SellerCardState();
}

class _SellerCardState extends State<SellerCard> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Colors.amber,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeIn,
      height: _expanded ? 400 : 150,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              leading: Text(widget.order.userName),
              title: Text(widget.order.mobileNo),
              subtitle: Text(widget.order.Address),
              trailing: ElevatedButton.icon(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                label: Text('Rs.${widget.order.amount}'),
              ),
            ),
            // if (_expanded)
            AnimatedContainer(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2)),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeIn,
              height: _expanded ? 250 : 0,
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
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false)
                          .changeOrderStatus(
                              newStatus: 'FakeID',
                              OrderDate:
                                  widget.order.orderDate.toIso8601String(),
                              forUserId: widget.order.id);
                      widget.changeState();
                      //setState(() {});
                    },
                    child: Text('Fake Profile')),
                ElevatedButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false)
                          .changeOrderStatus(
                              newStatus: 'Item Delivered',
                              OrderDate:
                                  widget.order.orderDate.toIso8601String(),
                              forUserId: widget.order.id);
                      widget.changeState();
                      // setState(() {});
                    },
                    child: Text('Item Delivered')),
                ElevatedButton(
                  onPressed: null,
                  child: Text('Print Receipt'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
