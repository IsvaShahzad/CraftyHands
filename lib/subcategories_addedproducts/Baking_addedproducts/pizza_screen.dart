import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_services_flutter/Detail_Screens/Baking_DetailScreen/Pizza_Detail.dart';
import 'package:home_services_flutter/initialScreens/loginScreen.dart';
import 'package:provider/provider.dart';

import '../../Consumer_Screens/favourites.dart';

class PizzaScreen extends StatefulWidget {
  final Map<String, dynamic> added;

  final String productName;
  final String id;
  final String productPrice;
  final String productDescription;
  final String ImageURL;
  final Product product;

  const PizzaScreen({
    Key? key,
    required this.added,
    required this.productName,
    required this.id,
    required this.productPrice,
    required this.productDescription,
    required this.ImageURL,
    required this.product,
  }) : super(key: key);

  @override
  _PizzaScreenState createState() => _PizzaScreenState();
}

class _PizzaScreenState extends State<PizzaScreen> {
  int _selectedIndex = 0;

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('addproducts');

  late Stream<QuerySnapshot> _streamCategory = _collectionRef.snapshots();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamCategory = _collectionRef.snapshots();
  }

  // String getAppbarTitle() => "Add products ${widget.added['product price']}";
  String getAppbarTitle() => "Pizzas ";

  @override
  Widget build(BuildContext context) {
    print(widget.added);

    final productPrice = widget.added?["product price"];
    final productName = widget.added?["product name"];
    final productDescription = widget.added?["product description"];
    final ImageURL = widget.added?["Image URL"];

    void _showFavoriteOptions(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                // leading: Icon(Icons.favorite),
                title: Text('❤         Favourites '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavoriteProductsPage(
                          ImageURL: widget.ImageURL,
                          productName: widget.productName,
                          productDescription: widget.productDescription,
                          productPrice: widget.productPrice,
                        )),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  // Perform the logout action
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/pastel.png"),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  getAppbarTitle(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              actions: <Widget>[

                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    _showFavoriteOptions(context);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 30),
              child: widget.added != null &&
                      widget.added['pizzalist'] != null &&
                      widget.added['pizzalist'].isNotEmpty
                  ? GridView.builder(
                      itemCount: widget.added['pizzalist'].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 18.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        final addedproductss = widget.added['pizzalist'][index];

                        final ImageURL = addedproductss.ImageURl;
                        final productName = addedproductss.productname;
                        final productPrice = addedproductss.productprice;
                        final productDescription =
                            addedproductss.productdescription;
                        final product = addedproductss.product;

                        return InkWell(
                            child: Card(
                              elevation: 5,
                              color: Colors
                                  .white70, // add some elevation to create a shadow effect
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // round the edges of the card
                                side: BorderSide(
                                    width: 1,
                                    color: Colors
                                        .grey), // add a border around the card
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(ImageURL),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Item: $productName\nRs. $productPrice\n$productDescription",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PizzaDetailScreen(
                                            productName: productName,
                                            productPrice: productPrice,
                                            productDescription:
                                                productDescription,
                                            ImageURL: ImageURL,
                                            product: product,
                                          )));
                            });
                      },
                    )
                  : Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
            )));
  }
}
