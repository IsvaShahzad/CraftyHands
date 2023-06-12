import 'package:flutter/material.dart';
import 'package:home_services_flutter/seller/Packaging_Screen.dart';
import 'package:home_services_flutter/seller/seller_checkout/shipping_screen.dart';
import '../../Providers/seller_cart_provider.dart' as cartprovider;
import '../cart.dart';
import '../cart_items.dart';

class CartScreen extends StatefulWidget {
  final cartprovider.CartProvider cartProvider;
  final Cart cart;


  const CartScreen({Key? key, required this.cartProvider, required this.cart, })
      : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    updateTotal();
  }

  void updateTotal() {
    setState(() {
      total = widget.cartProvider.cart.calculateTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/pastel.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: Text('Cart 🛒'),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => PackagingScreen(),
              //   ),
              // );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: widget.cartProvider.cart.items.length,
                  itemBuilder: (context, index) {
                    CartItem item = widget.cartProvider.cart.items[index];

                    return Dismissible(
                      key: Key(item.name),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          widget.cartProvider.removeCartItem(item);
                          updateTotal();
                        });
                        // Remove the dismissed item from the widget tree
                        widget.cartProvider.cart.items.remove(item);
                      },
                      child: Card(
                        elevation: 3.0,
                        child:ListTile(
                          tileColor: Colors.white70,
                          contentPadding: EdgeInsets.all(8.0),

                          // Inside the Card widget of the ListView.builder
                          leading: Container(
                            width: 70,
                            height: 70,
                            child: ClipOval(
                              child: item.imageUrl.startsWith('assets/')
                                  ? Image.asset(
                                item.imageUrl, // Provide the asset image path here
                                fit: BoxFit.cover,
                              )
                                  : Image.network(
                                item.imageUrl, // Provide the image URL here
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),


                          title: Text(
                            item.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                'Price: ${item.price}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 75),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 29,
                                      height: 35,
                                      child: IconButton(
                                        icon: RichText(
                                          text: TextSpan(
                                            text: '-',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (item.quantity > 1) {
                                              widget.cartProvider
                                                  .decreaseQuantity(item);
                                            } else {
                                              widget.cartProvider
                                                  .removeCartItem(item);
                                            }
                                            updateTotal();
                                          });
                                        },
                                      ),
                                    ),
                                    Text(item.quantity.toString()),
                                    Container(
                                      width: 29,
                                      height: 35,
                                      child: IconButton(
                                        icon: RichText(
                                          text: TextSpan(
                                            text: '+',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            widget.cartProvider
                                                .increaseQuantity(item);
                                            updateTotal();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 3,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Subtotal: ${widget.cartProvider.cart.calculateTotal()
                          .toStringAsFixed(2)}/-',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Delivery: 150/-',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 30),
                    Divider(height: 8),
                    SizedBox(height: 15),
                    Text(
                      'Total: ${(widget.cartProvider.cart.calculateTotal() +
                          150).toStringAsFixed(2)}/-',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ShippingScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFAB47BC),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 10.0,
                ),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
