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
    //  Network().getCart();

    super.initState();
  }

  List key = [];
  var sellerWiseProduct = [];

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
            var newMap;
            newMap = groupBy(snapshot.data['data']['cart_items'].listObject,
                (obj) => obj['product']['seller']['shop_name']);

            List sellerShopName = [];

            for (var i = 0;
                i < snapshot.data['data']['cart_items'].listObject.length;
                i++) {
              sellerShopName.add(snapshot.data['data']['cart_items'][i]
                  ['product']['seller']['shop_name']);
            }
            var distinctIds = sellerShopName.toSet().toList();
            //  print(newMap[distinctIds[1]][1]['is_anaz_empire']);

            for (var i = 0; i < distinctIds.length; i++) {
              key.add(distinctIds[i].rawString());

              for (var j = 0; j < newMap[distinctIds[i]].length; j++) {
                sellerWiseProduct
                    .add(newMap[distinctIds[i]][j]['product']['name']);
              }
            }

            return ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    ListView.builder(
                      itemCount: key.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(

                              color: Colors.blue,
                                child: Text(key[index]),),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: newMap[distinctIds[index]].length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    Card(
                                      color: Colors.red,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            height: 20,
                                            alignment: Alignment.topLeft,
                                            child: Text("Item No: " + (i + 1).toString()
                                              //  + (i + 1).toString()
                                            ),
                                          ),
                                          Text(newMap[distinctIds[index]][i]
                                              ['product']['name']),

Container(
  height: 120,

  child:   Image.network("https://anazbd.com/"+newMap[distinctIds[index]][i]

                                  ['product']['feature_image'] ),
),

                                        ],
                                      ),
                                    ),

                                    // reuseAbleCard(
                                    //     index: i,
                                    //     context: context,
                                    //     myItems: sellerWiseProduct),
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
        },
      )),
    );
  }
}

Widget reuseAbleCard({int index, BuildContext context, myItems, myItem}) {
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
              child: Text("Item No: " + (index + 1).toString()
                  //  + (i + 1).toString()
                  ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 3),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 30,
                        child: Text(
                          myItems[index],
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ]),
          ],
        ),
      )
    ],
  );
}
