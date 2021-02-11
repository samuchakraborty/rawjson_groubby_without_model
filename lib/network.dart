import 'package:flutter/services.dart';
import 'package:g_json/g_json.dart';
import "package:collection/collection.dart";

class Network {
  getCart() async {
    final jsonResponse = await rootBundle.loadString("assets/data.json");

    final j = JSON.parse(jsonResponse);
   // final _id = j['data'];
    final id = j['data']['cart_items'];

    List anazEmpire = [];
    List anazSpotLights = [];
    List other = [];

    ///
    for (var i = 0; i < id.listObject.length; i++) {
      // ignore: unrelated_type_equality_checks
      var anazempire = j['data']['cart_items'][i]['is_anaz_empire'];
      // ignore: unrelated_type_equality_checks
      if (anazempire == 1) {
        //   anazEmpire.add(j['data']['cart_items'][i]);

        //print("anaz_empire =" + i.toString());
        // ignore: unrelated_type_equality_checks
      } else if (anazempire == 0) {
        //   anazSpotLights.add(j['data']['cart_items'][i]);
        //print("anaz Spotlight=" + i.toString());
      } else {
        other.add(j['data']['cart_items'][i]);
      }
    }

    // print(anazSpotLights.length);
    // print(anazEmpire.length);
    // anazEmpire
    //     .forEach((element) => print("anazEmpire   " + element.toString()));
    // anazSpotLights
    //     .forEach((element) => print("anazSpotLights   " + element.toString()));
    var newMap;
    newMap = groupBy(j['data']['cart_items'].listObject,
        (obj) => obj['product']['seller']['shop_name']);
    //   streetsList = new List<String>.from(newMap);
    // print("anaz Groceries");
    // print(newMap['Anaz Groceries']);

//     print("anaz ANAZ MALL");
//     print(newMap.length);
// print(newMap.isEmpty);
    List sellerShopName = [];

    for (var i = 0; i < j['data']['cart_items'].listObject.length; i++) {
      sellerShopName
          .add(j['data']['cart_items'][i]['product']['seller']['shop_name']);
    }
    var distinctIds = sellerShopName.toSet().toList();
    // print(distinctIds);

    for (var i = 0; i < distinctIds.length; i++) {
      //  print(distinctIds[i].rawString());

      for (var j = 0; j < newMap[distinctIds[i]].length; j++) {
        //print(newMap[distinctIds[i]][j]['product']['name']);
      }
    }

    // for (var i = 0; i < id.listObject.length; i++) {
    //   // ignore: unrelated_type_equality_checks
    //   var anaemic = j['data']['cart_items'][i]['is_anaz_empire'];
    //   // ignore: unrelated_type_equality_checks
    //   if (anaemic == 1) {
    //     print("Anaz Empire");
    //     for (var i = 0; i < distinctIds.length; i++) {
    //       print(distinctIds[i].rawString());
    //
    //       for (var j = 0; j < newMap[distinctIds[i]].length; j++) {
    //         print(newMap[distinctIds[i]][j]['product']['name']);
    //       }
    //     }
    //
    //   } else if (anaemic == 0) {
    //     print("Anaz Spotlight");
    //     for (var i = 0; i < distinctIds.length; i++) {
    //       print(distinctIds[i].rawString());
    //
    //       for (var j = 0; j < newMap[distinctIds[i]].length; j++) {
    //         print(newMap[distinctIds[i]][j]['product']['name']);
    //       }
    //     }
    //
    //   } else {
    //     print("others");
    //     for (var i = 0; i < distinctIds.length; i++) {
    //       print(distinctIds[i].rawString());
    //
    //       for (var j = 0; j < newMap[distinctIds[i]].length; j++) {
    //         print(newMap[distinctIds[i]][j]['product']['name']);
    //       }
    //     }
    //
    //   }
    // }
    //print(newMap[distinctIds[1]][1]['is_anaz_spotlight']);
    for (var i = 0; i < distinctIds.length; i++) {
      //  print(distinctIds[i].rawString());

      for (var j = 0; j < newMap[distinctIds[i]].length; j++) {
        if (newMap[distinctIds[i]][j]['is_anaz_spotlight'] == 1) {
          //  print("is_anaz_empire");
          //  print(newMap[distinctIds[i]][j]['product']['name']);
          anazEmpire.add(newMap[distinctIds[i]][j]['product']['name']);
        } else {
          //  print("anazSpotLights");
          //  print(newMap[distinctIds[i]][j]['product']['name']);
          anazSpotLights.add(newMap[distinctIds[i]][j]['product']['name']);
        }
      }
    }

    // var anaz = anazSpotLights.toSet().toList();
    // print(anaz[1]);
    // print(anazSpotLights);
    //  print(anazEmpire);
    // print(anaz.toList());

    //  anazEmpire.forEach((element) => print("anazEmpire   " + element.toString()));
    anazSpotLights
        .forEach((element) => print("AnazSpotLights " + element.toString()));

    // if (newMap[distinctIds[i]][j]['is_anaz_empire'] == 0) {
    //   //print("Anaz empire");
    //   print(newMap[distinctIds[i]][j]['product']['name']);
    // } else if (newMap[distinctIds[i]][j]['is_anaz_empire'] == 1) {
    //   //print("Anaz SpotLight");
    //   print(newMap[distinctIds[i]][j]['product']['name']);
    // }

    // for (var j = 0; j < newMap[distinctIds[0]].length; j++) {
    //   // print(distinctIds[i]);
    //   print(newMap[sellerShopName[0]][j]['product']['name']);
    // }
  }
}
