import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'network.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    // net().A();

    super.initState();
  }

  List key = [];
  List keys = [];
  var sellerWiseProduct = [];
  var anazSpotLightsSellerProduct = [];
  var shopeName;
  var spotLightNam;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: Network().getCart(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            final id = snapshot.data['data']['cart_items'];

            List anazEmpire = [];
            List anazSpotLights = [];
            List other = [];

            for (var i = 0; i < id.listObject.length; i++) {
              var anazempire =
                  snapshot.data['data']['cart_items'][i]['is_anaz_empire'];

              if (anazempire == 1) {
                anazEmpire.add(snapshot.data['data']['cart_items'][i]);

                //     print("anaz_empire =" + i.toString());

              } else if (anazempire == 0) {
                anazSpotLights.add(snapshot.data['data']['cart_items'][i]);
              } else {
                other.add(snapshot.data['data']['cart_items'][i]);
              }
            }

            var newMap;
            newMap = groupBy(
                anazEmpire, (obj) => obj['product']['seller']['shop_name']);
            List sellerShopName = [];

            for (var i = 0; i < anazEmpire.length; i++) {
              sellerShopName
                  .add(anazEmpire[i]['product']['seller']['shop_name']);
            }
            shopeName = 'anaz anazEmpire';
            var distinctIds = sellerShopName.toSet().toList();

            for (var i = 0; i < distinctIds.length; i++) {
              key.add(distinctIds[i].rawString());

              for (var j = 0; j < newMap[distinctIds[i]].length; j++) {
                sellerWiseProduct
                    .add(newMap[distinctIds[i]][j]['product']['name']);
              }
            }

            var newSpotLight;
            newSpotLight = groupBy(
                anazSpotLights, (obj) => obj['product']['seller']['shop_name']);
            List spotLight = [];

            for (var i = 0; i < anazSpotLights.length; i++) {
              spotLight
                  .add(anazSpotLights[i]['product']['seller']['shop_name']);
            }
            spotLightNam = 'Anaz SpotLight';
            var distinctIdnewSpotLight = spotLight.toSet().toList();

            for (var i = 0; i < distinctIdnewSpotLight.length; i++) {
              keys.add(distinctIdnewSpotLight[i].rawString());

              for (var j = 0;
                  j < newSpotLight[distinctIdnewSpotLight[i]].length;
                  j++) {
                anazSpotLightsSellerProduct.add(
                    newSpotLight[distinctIdnewSpotLight[i]][j]['product']
                        ['name']);
              }
            }

            return ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(children: [
                    buildColumn(
                        newMap: newMap,
                        distinctIds: distinctIds,
                        shopeName: shopeName,
                        key: key),


                    if(other.isNotEmpty == false)
                    buildColumn(
                        newMap: newSpotLight,
                        distinctIds: distinctIdnewSpotLight,
                        shopeName: spotLightNam,
                        key: keys),
                  ]);
                });
          }
        },
      )),
    );
  }

  Column buildColumn({newMap, List distinctIds, shopeName, key}) {
    return Column(
      children: [
        Card(
          color: Colors.yellowAccent,
          child: Text(shopeName),
        ),
        Column(
          children: [
            ListView.builder(
              itemCount: key.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      color: Colors.blue,
                      child: Text(key[index]),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newMap[distinctIds[index]].length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            Card(
                              elevation: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 20,
                                    alignment: Alignment.topLeft,
                                    child: Text("Item No: " + (i + 1).toString()
                                        //  + (i + 1).toString()
                                        ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        "https://anazbd.com/${newMap[distinctIds[index]][i]['product']['feature_image'].rawString().replaceAll('"', '')}",
                                        height: 100,
                                        width: 100,
                                      ),
                                      // Expanded(
                                      //     flex: 1,
                                      //     child: Text((store.basket[i].originalPrice *
                                      //             store.basket[i].qty)
                                      //         .toString())),
                                      SizedBox(width: 3),

                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: 30,
                                            child: Text(
                                              newMap[distinctIds[index]][i]
                                                      ['product']['name']
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            "Price: " +
                                                (newMap[distinctIds[index]][i]
                                                            ['product']
                                                        ['original_price'])
                                                    .toString(),
                                          ),
                                          Text(
                                            "Sub Total: " +
                                                (newMap[distinctIds[index]][i]
                                                        ['subtotal'])
                                                    .toString(),
                                            // (store.basket[i].originalPrice *
                                            //         store.basket[i].qty)
                                            //     .toString(),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                //alignment: Alignment.center,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 40,

                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.remove),
                                                      //   onPressed: () {
                                                      //     // store.removeOneItemToBasket(
                                                      //     //     store.basket[i]);
                                                      //     // Navigator.of(context)
                                                      //     //     .push(new MaterialPageRoute(
                                                      //     //     builder: (context) => BasketPage()))
                                                      //     //     .whenComplete(Network().getCart);
                                                      //     //
                                                      //     // setState(() {
                                                      //     //   Network().getItemDecrementCart(
                                                      //     //       cartIds: myItems[index].id.toString(),
                                                      //     //       context: context);
                                                      //     // });
                                                      //  },
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        newMap[distinctIds[
                                                                    index]][i]
                                                                ['qty']
                                                            .toString(),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        icon: Icon(Icons.add),
                                                        onPressed: () {
                                                          // setState(() {
                                                          //   Navigator.of(context)
                                                          //       .push(new MaterialPageRoute(
                                                          //       builder: (context) => BasketPage()))
                                                          //       .whenComplete(Network().getCart);
                                                          //
                                                          //   Network().getItemUpdateCart(
                                                          //       cartIds: myItems[index].id.toString(),
                                                          //       context: context);
                                                          // });
                                                        }),
                                                  ],
                                                ),
                                              ),
                                              // Container(
                                              //   alignment: Alignment.topRight,
                                              //   margin: EdgeInsets.symmetric(
                                              //       horizontal: 18),
                                              //   child: IconButton(
                                              //     icon: Icon(
                                              //         Icons.remove_shopping_cart),
                                              // //     onPressed: () {
                                              // //       store.removeOneItemIntoBasket(
                                              // //           store.basket[i]);
                                              // //     },
                                              //   ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 31),
                                        child: IconButton(
                                          alignment: Alignment.bottomLeft,
                                          icon:
                                              Icon(Icons.remove_shopping_cart),
                                          // onPressed: () {
                                          //   //   store.removeOneItemIntoBasket(store.basket[i]);
                                          //   Navigator.of(context)
                                          //       .push(new MaterialPageRoute(
                                          //       builder: (context) => BasketPage()))
                                          //       .whenComplete(Network().getCart);
                                          //
                                          //   setState(() {
                                          //     Network().getItemDeleteCart(
                                          //         cartIds: myItems[index].id.toString(),
                                          //         context: context);
                                          //   });
                                          // },
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     SizedBox(
                                  //       width: 20,
                                  //     ),
                                  //     SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     // Column(
                                  //     //   children: [
                                  //     //     // Text(
                                  //     //     //   "Price: " +
                                  //     //     //       (store.basket[i].originalPrice)
                                  //     //     //           .toString(),
                                  //     //     // ),
                                  //     //     // Text(
                                  //     //     //   "Sub Total: " +
                                  //     //     //       (store.basket[i].originalPrice *
                                  //     //     //               store.basket[i].qty)
                                  //     //     //           .toString(),
                                  //     //     // ),
                                  //     //   ],
                                  //     // ),
                                  //     SizedBox(
                                  //       width: 60,
                                  //     ),
                                  //     //   Wrap(
                                  //     //     children: [
                                  //     //       Container(
                                  //     //         alignment: Alignment.center,
                                  //     //         width: 40,
                                  //     //         height: 150,
                                  //     //         //    margin: new EdgeInsets.symmetric(
                                  //     //         //       horizontal: 22.0, vertical: 10.0),
                                  //     //         decoration: BoxDecoration(
                                  //     //             border:
                                  //     //                 Border.all(color: Colors.blue)),
                                  //     //         child: Column(
                                  //     //           mainAxisAlignment:
                                  //     //               MainAxisAlignment.center,
                                  //     //           children: [
                                  //     //             IconButton(
                                  //     //                 icon: Icon(Icons.add),
                                  //     //                 onPressed: () {
                                  //     //                   store.addOneItemtoBasket(
                                  //     //                       store.basket[i]);
                                  //     //                 }),
                                  //     //             Container(
                                  //     //               decoration: BoxDecoration(
                                  //     //                   border: Border.all(
                                  //     //                       color: Colors.amber)),
                                  //     //               child: Text(store.basket[i].qty
                                  //     //                   .toString()),
                                  //     //             ),
                                  //     //             IconButton(
                                  //     //                 icon: Icon(Icons.remove),
                                  //     //                 onPressed: () {
                                  //     //                   store.removeOneItemtoBasket(
                                  //     //                       store.basket[i]);
                                  //     //                 }),
                                  //     //           ],
                                  //     //         ),
                                  //     //       ),
                                  //     //     ],
                                  //     //   ),
                                  //     // ],
                                  //   ],
                                  // ),

                                  // SizedBox(
                                  //   height: 7,
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     SizedBox(
                                  //       height: 7,
                                  //     ),
                                  //     Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceAround,
                                  //       children: [
                                  //         Container(
                                  //           //alignment: Alignment.center,
                                  //           width: 110,
                                  //           height: 40,
                                  //           //    margin: new EdgeInsets.symmetric(
                                  //           //       horizontal: 22.0, vertical: 10.0),
                                  //           decoration: BoxDecoration(
                                  //               border:
                                  //                   Border.all(color: Colors.blue)),
                                  //           child: Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.start,
                                  //             children: [
                                  //               IconButton(
                                  //                   icon: Icon(Icons.add),
                                  //                   onPressed: () {
                                  //                     store.addOneItemtoBasket(
                                  //                         store.basket[i]);
                                  //                   }),
                                  //               Container(
                                  //                 decoration: BoxDecoration(
                                  //                     //  border: Border.all(color: Colors.amber)),
                                  //                     //  border: Border.all()
                                  //                     ),
                                  //                 child: Text(store.basket[i].qty
                                  //                     .toString()),
                                  //               ),
                                  //               IconButton(
                                  //                   icon: Icon(Icons.remove),
                                  //                   onPressed: () {
                                  //                     store.removeOneItemtoBasket(
                                  //                         store.basket[i]);
                                  //                   }),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //         Container(
                                  //           margin: EdgeInsets.symmetric(
                                  //               horizontal: 18),
                                  //           child: IconButton(
                                  //             icon:
                                  //                 Icon(Icons.remove_shopping_cart),
                                  //             onPressed: () {
                                  //               store.removeOneItemIntoBasket(
                                  //                   store.basket[i]);
                                  //             },
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),

                                  // SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
