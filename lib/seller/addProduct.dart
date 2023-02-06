
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_services_flutter/categories_seller/SellerCategories.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';



class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  ShowAlert() {
    return showDialog(
      context: context,


      builder: (ctx) => AlertDialog(
        title: Text("Product has been added! "),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFAB47BC),
                onPrimary: Colors.white,
                elevation: 3,
                minimumSize: const Size(150, 50),
                maximumSize: const Size(150, 50),
                shape: StadiumBorder(),
              ),
              child: Text('OK',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SellerHomePage()));
              },
            ),
          )
        ],
      ),
    );
  }

  late String _productName;
  late String _productDescription;
  late double _productPrice;
  File? imageFile;

  final TextEditingController ProductnameController = TextEditingController();
  final TextEditingController ProductDescriptionController =
  TextEditingController();
  final TextEditingController ProductpriceController = TextEditingController();

  selectFile() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 100, maxWidth: 180);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }
  FirebaseStorage storage = FirebaseStorage.instance;


  @override
  Widget build(BuildContext context) {

    String filename = "";


    return Container(

      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/pastel.png"
              ),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(

          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 13,

            shape: RoundedRectangleBorder(

                borderRadius:  BorderRadius.only(

                    bottomRight: Radius.circular(12),

                    bottomLeft: Radius.circular(12))

            ),

            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SellerHomePage()));
              },
            ),
            title: Text(
              'Add Product',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 45.h,
                          ),
                          Text('Add a new product to your inventory!',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold)),

                          Padding(padding: EdgeInsets.only(top: 18)),
                          Text('Product name',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(

                            controller: ProductnameController,


                            decoration: InputDecoration(
                              hintText: 'Please enter product name',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10.0),
                              hintStyle:
                              TextStyle(fontSize: 13, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                BorderSide(width: 1, color: Colors.purple),
                              ),

                            ),
                            textInputAction: TextInputAction.next,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a product name';
                              }
                              return null;
                            },
                            onSaved: (value) => _productName = value!,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Product Description',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(
                            controller: ProductDescriptionController,
                            decoration: InputDecoration(
                              hintText: 'Please enter product decription',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10.0),
                              hintStyle:
                              TextStyle(fontSize: 13, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                BorderSide(width: 1, color: Colors.purple),
                              ),
                            ),
                            textInputAction: TextInputAction.next,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a product description';
                              }
                              return null;
                            },
                            onSaved: (value) => _productDescription = value!,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text('Product Price',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextFormField(
                            controller: ProductpriceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Please enter product price',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10.0),
                              hintStyle:
                              TextStyle(fontSize: 13, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                BorderSide(width: 1, color: Colors.orange),
                              ),
                            ),
                            textInputAction: TextInputAction.next,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a product price';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                            _productPrice = double.parse(value!),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                          Text('Product Image Sample',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10.h,
                          ),

                          Container(
                            height: 160,
                            width: 200,
                            child: Column(
                              children: [
                                if (imageFile != null)
                                  Container(
                                    child: Image.file(
                                      File(imageFile!.path),
                                    ),
                                  ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFFAB47BC),
                                        onPrimary: Colors.white,
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: selectFile,
                                      child: const Text(
                                        'Select file',
                                      )),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFAB47BC),
                                onPrimary: Colors.white,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                elevation: 3,
                                minimumSize: const Size(180, 50),
                                maximumSize: const Size(180, 50),
                              ),
                              child: Text('Add Product',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  ShowAlert();

                                  if(imageFile != null){
                                    try {
                                      final ref = FirebaseStorage.instance
                                          .ref()
                                          .child('images/$filename');
                                      await ref.putFile(imageFile!);
                                      final url = await ref.getDownloadURL();
                                      // final randomId = Random().nextInt(100000).toString();
                                      FirebaseFirestore.instance
                                          .collection('addproducts')
                                          .doc()
                                          .set({
                                        'product name': ProductnameController.text,
                                        'product description': ProductDescriptionController.text,
                                        'product price': ProductpriceController.text,
                                        'Image URl': url,
                                      });
                                    } catch (e) {
                                      print(e);
                                    }
                                  }else{
                                    print("image not selected");
                                  }
                                  // print(storage);
                                }

                              },
                            ),
                          ),


                        ]),
                  )))),
    );
  }
}




















// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:home_services_flutter/categories_seller/SellerCategories.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:dropdown_formfield/dropdown_formfield.dart';
//
// class AddProduct extends StatefulWidget {
//   @override
//   _AddProductState createState() => _AddProductState();
// }
//
// class _AddProductState extends State<AddProduct> {
//   final _formKey = GlobalKey<FormState>();
//
//   ShowAlert() {
//     return showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text("Product has been added! "),
//         actions: <Widget>[
//           Align(
//             alignment: Alignment.center,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Color(0xFFAB47BC),
//                 onPrimary: Colors.white,
//                 elevation: 3,
//                 minimumSize: const Size(150, 50),
//                 maximumSize: const Size(150, 50),
//                 shape: StadiumBorder(),
//               ),
//               child: Text('OK',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//               onPressed: () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => SellerHomePage()));
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   late String _productName;
//   late String _productDescription;
//   late double _productPrice;
//   late String selectedSubcategory =
//       '{"_subcategoryName": "", "subcategoryId": ""}';
//   late Map<String, dynamic> _selectedSubcategory =
//       jsonDecode(selectedSubcategory);
//
//   File? imageFile;
//   late var _subcategories = <dynamic>[];
//   late final Map<String, dynamic> categories;
//
//   final TextEditingController ProductnameController = TextEditingController();
//   final TextEditingController ProductDescriptionController =
//       TextEditingController();
//   final TextEditingController ProductpriceController = TextEditingController();
//
//   selectFile() async {
//     XFile? file = await ImagePicker()
//         .pickImage(source: ImageSource.gallery, maxHeight: 100, maxWidth: 180);
//
//     if (file != null) {
//       setState(() {
//         imageFile = File(file.path);
//       });
//     }
//   }
//
//   FirebaseStorage storage = FirebaseStorage.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     String filename = "";
//
//     return Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("assets/images/pastel.png"),
//                 fit: BoxFit.cover)),
//         child: Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: AppBar(
//               elevation: 13,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(12),
//                       bottomLeft: Radius.circular(12))),
//               leading: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => SellerHomePage()));
//                 },
//               ),
//               title: Text(
//                 'Add Product',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             body: Form(
//               key: _formKey,
//               child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                   child: Column(children: <Widget>[
//                     SizedBox(
//                       height: 45.h,
//                     ),
//                     SingleChildScrollView(
//                         child: Column(children: <Widget>[
//                       StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                         stream: FirebaseFirestore.instance
//                             .collection('Category')
//                             .snapshots(),
//                         builder: (_, snapshot) {
//                           if (snapshot.hasError)
//                             return Text('Error = ${snapshot.error}');
//                           if (snapshot.hasData) {
//                             final docs = snapshot.data!.docs;
//
//                             _subcategories.addAll(docs.map((e) => {
//                                   if (e.data().length > 0)
//                                     e.data()['subcategories']
//                                 }));
//
//                             dynamic data;
//                             var subcategory;
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 if (docs[index].data().length > 0) {
//                                   data = docs[index].data();
//                                   subcategory = data['subcategories'][index];
//                                 }
//                                 return ListTile(
//                                   trailing: Icon(
//                                     Icons.arrow_forward,
//                                     size: 20,
//                                     color: Colors.black,
//                                   ),
//                                   title: Text(
//                                     subcategory['name'].toString() ?? "",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   onTap: () {},
//                                 );
//                               },
//                               itemCount: data['subcategories']?.length ?? 0,
//                             );
//                           }
//
//                           return Center(child: CircularProgressIndicator());
//                         },
//                       ),
//                       Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             SizedBox(
//                               height: 45.h,
//                             ),
//                             Text('Add a new product to your inventory!',
//                                 style: TextStyle(
//                                     fontSize: 24,
//                                     color: Colors.purple,
//                                     fontWeight: FontWeight.bold)),
//                             Padding(padding: EdgeInsets.only(top: 18)),
//                             Text('Product name',
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     color: Color(0xFF000000),
//                                     fontWeight: FontWeight.bold)),
//                             SizedBox(
//                               height: 5.h,
//                             ),
//                             TextFormField(
//                               controller: ProductnameController,
//                               decoration: InputDecoration(
//                                 hintText: 'Please enter product name',
//                                 filled: true,
//                                 fillColor: Colors.white.withOpacity(0.1),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     vertical: 15, horizontal: 10.0),
//                                 hintStyle:
//                                     TextStyle(fontSize: 13, color: Colors.grey),
//                                 border: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(4)),
//                                   borderSide: BorderSide(
//                                       width: 1, color: Colors.purple),
//                                 ),
//                               ),
//                               textInputAction: TextInputAction.next,
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Please enter a product name';
//                                 }
//                                 return null;
//                               },
//                               onSaved: (value) => _productName = value!,
//                             ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             Text(
//                               'Product Description',
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: Color(0xFF000000),
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(
//                               height: 5.h,
//                             ),
//                             TextFormField(
//                               controller: ProductDescriptionController,
//                               decoration: InputDecoration(
//                                 hintText: 'Please enter product decription',
//                                 filled: true,
//                                 fillColor: Colors.white.withOpacity(0.1),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     vertical: 15, horizontal: 10.0),
//                                 hintStyle:
//                                     TextStyle(fontSize: 13, color: Colors.grey),
//                                 border: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(4)),
//                                   borderSide: BorderSide(
//                                       width: 1, color: Colors.purple),
//                                 ),
//                               ),
//                               textInputAction: TextInputAction.next,
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Please enter a product description';
//                                 }
//                                 return null;
//                               },
//                               onSaved: (value) => _productDescription = value!,
//                             ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             Text('Product Price',
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     color: Color(0xFF000000),
//                                     fontWeight: FontWeight.bold)),
//                             SizedBox(
//                               height: 5.h,
//                             ),
//                             TextFormField(
//                               controller: ProductpriceController,
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 hintText: 'Please enter product price',
//                                 filled: true,
//                                 fillColor: Colors.white.withOpacity(0.1),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     vertical: 15, horizontal: 10.0),
//                                 hintStyle:
//                                     TextStyle(fontSize: 13, color: Colors.grey),
//                                 border: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(4)),
//                                   borderSide: BorderSide(
//                                       width: 1, color: Colors.orange),
//                                 ),
//                               ),
//                               textInputAction: TextInputAction.next,
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Please enter a product price';
//                                 }
//                                 return null;
//                               },
//                               onSaved: (value) =>
//                                   _productPrice = double.parse(value!),
//                             ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             FormField<String>(
//                               builder: (FormFieldState<String> state) {
//                                 return InputDecorator(
//                                   decoration: InputDecoration(
//                                       errorStyle: TextStyle(
//                                           color: Colors.redAccent,
//                                           fontSize: 16.0),
//                                       hintText: 'Select subcategory',
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(5.0))),
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton<String>(
//                                       value: _selectedSubcategory[
//                                           "_subcategoryName"],
//                                       isDense: true,
//                                       onChanged: (newValue) {
//                                         if (newValue != null)
//                                           _selectedSubcategory[
//                                               "_subcategoryName"] = newValue;
//                                         print(newValue);
//                                       },
//                                       items: _subcategories.map((value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value.name,
//                                           child: Text(value.id),
//                                         );
//                                       }).toList(),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                             Text('Product Image Sample',
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     color: Color(0xFF000000),
//                                     fontWeight: FontWeight.bold)),
//                             SizedBox(
//                               height: 10.h,
//                             ),
//                             Container(
//                               height: 160,
//                               width: 200,
//                               child: Column(
//                                 children: [
//                                   if (imageFile != null)
//                                     Container(
//                                       child: Image.file(
//                                         File(imageFile!.path),
//                                       ),
//                                     ),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           primary: Color(0xFFAB47BC),
//                                           onPrimary: Colors.white,
//                                           shape: new RoundedRectangleBorder(
//                                             borderRadius:
//                                                 new BorderRadius.circular(30.0),
//                                           ),
//                                         ),
//                                         onPressed: selectFile,
//                                         child: const Text(
//                                           'Select file',
//                                         )),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.center,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Color(0xFFAB47BC),
//                                   onPrimary: Colors.white,
//                                   shape: new RoundedRectangleBorder(
//                                     borderRadius:
//                                         new BorderRadius.circular(30.0),
//                                   ),
//                                   elevation: 3,
//                                   minimumSize: const Size(180, 50),
//                                   maximumSize: const Size(180, 50),
//                                 ),
//                                 child: Text('Add Product',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                     )),
//                                 onPressed: () async {
//                                   if (_formKey.currentState!.validate()) {
//                                     _formKey.currentState?.save();
//                                     ShowAlert();
//
//                                     if (imageFile != null) {
//                                       try {
//                                         final ref = FirebaseStorage.instance
//                                             .ref()
//                                             .child('images/$filename');
//                                         await ref.putFile(imageFile!);
//                                         final url = await ref.getDownloadURL();
//                                         // final randomId = Random().nextInt(100000).toString();
//                                         FirebaseFirestore.instance
//                                             .collection('addproducts')
//                                             .add({
//                                           'product name':
//                                               ProductnameController.text,
//                                           'product description':
//                                               ProductDescriptionController.text,
//                                           'product price':
//                                               ProductpriceController.text,
//                                           'Image URl': url,
//                                         });
//                                       } catch (e) {
//                                         print(e);
//                                       }
//                                     } else {
//                                       print("image not selected");
//                                     }
//                                     // print(storage);
//                                   }
//                                 },
//                               ),
//                             ),
//                           ]),
//                     ])
//                         // child: Column(
//                         //     crossAxisAlignment: CrossAxisAlignment.start,
//                         //     children: <Widget>[
//                         //       SizedBox(
//                         //         height: 45.h,
//                         //       ),
//                         //       Text('Add a new product to your inventory!',
//                         //           style: TextStyle(
//                         //               fontSize: 24,
//                         //               color: Colors.purple,
//                         //               fontWeight: FontWeight.bold)),
//                         //       Padding(padding: EdgeInsets.only(top: 18)),
//                         //       Text('Product name',
//                         //           style: TextStyle(
//                         //               fontSize: 15,
//                         //               color: Color(0xFF000000),
//                         //               fontWeight: FontWeight.bold)),
//                         //       SizedBox(
//                         //         height: 5.h,
//                         //       ),
//                         //       TextFormField(
//                         //         controller: ProductnameController,
//                         //         decoration: InputDecoration(
//                         //           hintText: 'Please enter product name',
//                         //           filled: true,
//                         //           fillColor: Colors.white.withOpacity(0.1),
//                         //           contentPadding: const EdgeInsets.symmetric(
//                         //               vertical: 15, horizontal: 10.0),
//                         //           hintStyle:
//                         //               TextStyle(fontSize: 13, color: Colors.grey),
//                         //           border: OutlineInputBorder(
//                         //             borderRadius:
//                         //                 BorderRadius.all(Radius.circular(4)),
//                         //             borderSide: BorderSide(
//                         //                 width: 1, color: Colors.purple),
//                         //           ),
//                         //         ),
//                         //         textInputAction: TextInputAction.next,
//                         //         validator: (value) {
//                         //           if (value!.isEmpty) {
//                         //             return 'Please enter a product name';
//                         //           }
//                         //           return null;
//                         //         },
//                         //         onSaved: (value) => _productName = value!,
//                         //       ),
//                         //       SizedBox(
//                         //         height: 20.h,
//                         //       ),
//                         //       Text(
//                         //         'Product Description',
//                         //         style: TextStyle(
//                         //             fontSize: 15,
//                         //             color: Color(0xFF000000),
//                         //             fontWeight: FontWeight.bold),
//                         //       ),
//                         //       SizedBox(
//                         //         height: 5.h,
//                         //       ),
//                         //       TextFormField(
//                         //         controller: ProductDescriptionController,
//                         //         decoration: InputDecoration(
//                         //           hintText: 'Please enter product decription',
//                         //           filled: true,
//                         //           fillColor: Colors.white.withOpacity(0.1),
//                         //           contentPadding: const EdgeInsets.symmetric(
//                         //               vertical: 15, horizontal: 10.0),
//                         //           hintStyle:
//                         //               TextStyle(fontSize: 13, color: Colors.grey),
//                         //           border: OutlineInputBorder(
//                         //             borderRadius:
//                         //                 BorderRadius.all(Radius.circular(4)),
//                         //             borderSide: BorderSide(
//                         //                 width: 1, color: Colors.purple),
//                         //           ),
//                         //         ),
//                         //         textInputAction: TextInputAction.next,
//                         //         validator: (value) {
//                         //           if (value!.isEmpty) {
//                         //             return 'Please enter a product description';
//                         //           }
//                         //           return null;
//                         //         },
//                         //         onSaved: (value) => _productDescription = value!,
//                         //       ),
//                         //       SizedBox(
//                         //         height: 20.h,
//                         //       ),
//                         //       Text('Product Price',
//                         //           style: TextStyle(
//                         //               fontSize: 15,
//                         //               color: Color(0xFF000000),
//                         //               fontWeight: FontWeight.bold)),
//                         //       SizedBox(
//                         //         height: 5.h,
//                         //       ),
//                         //       TextFormField(
//                         //         controller: ProductpriceController,
//                         //         keyboardType: TextInputType.number,
//                         //         decoration: InputDecoration(
//                         //           hintText: 'Please enter product price',
//                         //           filled: true,
//                         //           fillColor: Colors.white.withOpacity(0.1),
//                         //           contentPadding: const EdgeInsets.symmetric(
//                         //               vertical: 15, horizontal: 10.0),
//                         //           hintStyle:
//                         //               TextStyle(fontSize: 13, color: Colors.grey),
//                         //           border: OutlineInputBorder(
//                         //             borderRadius:
//                         //                 BorderRadius.all(Radius.circular(4)),
//                         //             borderSide: BorderSide(
//                         //                 width: 1, color: Colors.orange),
//                         //           ),
//                         //         ),
//                         //         textInputAction: TextInputAction.next,
//                         //         validator: (value) {
//                         //           if (value!.isEmpty) {
//                         //             return 'Please enter a product price';
//                         //           }
//                         //           return null;
//                         //         },
//                         //         onSaved: (value) =>
//                         //             _productPrice = double.parse(value!),
//                         //       ),
//                         //       SizedBox(
//                         //         height: 20.h,
//                         //       ),
//                         //       FormField<String>(
//                         //         builder: (FormFieldState<String> state) {
//                         //           return InputDecorator(
//                         //             decoration: InputDecoration(
//                         //                 errorStyle: TextStyle(
//                         //                     color: Colors.redAccent,
//                         //                     fontSize: 16.0),
//                         //                 hintText: 'Please select expense',
//                         //                 border: OutlineInputBorder(
//                         //                     borderRadius:
//                         //                         BorderRadius.circular(5.0))),
//                         //             child: DropdownButtonHideUnderline(
//                         //               child: DropdownButton<String>(
//                         //                 value: _currentSelectedValue,
//                         //                 isDense: true,
//                         //                 onChanged: (String newValue) {
//                         //                   setState(() {
//                         //                     _currentSelectedValue = newValue;
//                         //                     state.didChange(newValue);
//                         //                   });
//                         //                 },
//                         //                 items: _currencies.map((String value) {
//                         //                   return DropdownMenuItem<String>(
//                         //                     value: value,
//                         //                     child: Text(value),
//                         //                   );
//                         //                 }).toList(),
//                         //               ),
//                         //             ),
//                         //           );
//                         //         },
//                         //       ),
//                         //       Text('Product Image Sample',
//                         //           style: TextStyle(
//                         //               fontSize: 15,
//                         //               color: Color(0xFF000000),
//                         //               fontWeight: FontWeight.bold)),
//                         //       SizedBox(
//                         //         height: 10.h,
//                         //       ),
//                         //       Container(
//                         //         height: 160,
//                         //         width: 200,
//                         //         child: Column(
//                         //           children: [
//                         //             if (imageFile != null)
//                         //               Container(
//                         //                 child: Image.file(
//                         //                   File(imageFile!.path),
//                         //                 ),
//                         //               ),
//                         //             Align(
//                         //               alignment: Alignment.centerRight,
//                         //               child: ElevatedButton(
//                         //                   style: ElevatedButton.styleFrom(
//                         //                     primary: Color(0xFFAB47BC),
//                         //                     onPrimary: Colors.white,
//                         //                     shape: new RoundedRectangleBorder(
//                         //                       borderRadius:
//                         //                           new BorderRadius.circular(30.0),
//                         //                     ),
//                         //                   ),
//                         //                   onPressed: selectFile,
//                         //                   child: const Text(
//                         //                     'Select file',
//                         //                   )),
//                         //             )
//                         //           ],
//                         //         ),
//                         //       ),
//                         //       Align(
//                         //         alignment: Alignment.center,
//                         //         child: ElevatedButton(
//                         //           style: ElevatedButton.styleFrom(
//                         //             primary: Color(0xFFAB47BC),
//                         //             onPrimary: Colors.white,
//                         //             shape: new RoundedRectangleBorder(
//                         //               borderRadius:
//                         //                   new BorderRadius.circular(30.0),
//                         //             ),
//                         //             elevation: 3,
//                         //             minimumSize: const Size(180, 50),
//                         //             maximumSize: const Size(180, 50),
//                         //           ),
//                         //           child: Text('Add Product',
//                         //               style: TextStyle(
//                         //                 fontWeight: FontWeight.bold,
//                         //                 fontSize: 18,
//                         //               )),
//                         //           onPressed: () async {
//                         //             if (_formKey.currentState!.validate()) {
//                         //               _formKey.currentState?.save();
//                         //               ShowAlert();
//                         //
//                         //               if (imageFile != null) {
//                         //                 try {
//                         //                   final ref = FirebaseStorage.instance
//                         //                       .ref()
//                         //                       .child('images/$filename');
//                         //                   await ref.putFile(imageFile!);
//                         //                   final url = await ref.getDownloadURL();
//                         //                   // final randomId = Random().nextInt(100000).toString();
//                         //                   FirebaseFirestore.instance
//                         //                       .collection('addproducts')
//                         //                       .add({
//                         //                     'product name':
//                         //                         ProductnameController.text,
//                         //                     'product description':
//                         //                         ProductDescriptionController.text,
//                         //                     'product price':
//                         //                         ProductpriceController.text,
//                         //                     'Image URl': url,
//                         //                   });
//                         //                 } catch (e) {
//                         //                   print(e);
//                         //                 }
//                         //               } else {
//                         //                 print("image not selected");
//                         //               }
//                         //               // print(storage);
//                         //             }
//                         //           },
//                         //         ),
//                         //       ),
//                         //     ]),
//                         )
//                   ])),
//             )));
//   }
// }
