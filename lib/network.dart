import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:g_json/g_json.dart';
import "package:collection/collection.dart";

class Network {
  getCart() async {
    final jsonResponse = await rootBundle.loadString("assets/data.json");

    final j = JSON.parse(jsonResponse);
    final _id = j['data'];
    final id = j['data']['cart_items'];

    List<Object> anazEmpire = [];
    List<Object> anazSpotLights = [];

    // for (var i = 0; i < id.listObject.length; i++) {
    //   // ignore: unrelated_type_equality_checks
    //   anaz_empire = j['data']['cart_items'][i]['is_anaz_empire'];
    //   if (anaz_empire == 1) {
    //     anazEmpire.add(j['data']['cart_items'][i]);
    //
    //     //print("anaz_empire =" + i.toString());
    //   } else if (anaz_empire == 0) {
    //     anazSpotLights.add(j['data']['cart_items'][i]);
    //     //print("anaz Spotlight=" + i.toString());
    //   }
    // }
    // anazEmpire
    //     .forEach((element) => print("anazEmpire   " + element.toString()));
    // anazSpotLights
    //     .forEach((element) => print("anazSpotLights   " + element.toString()));
    var newMap;
    List<String> streetsList;
    var listonMaps = j['data']['cart_items'];
  // for(var i =0; i<listonMaps.listValue.length;i++) {
      newMap =
     groupBy(j['data']['cart_items'].listObject, (
         obj) => obj['product']['seller']['shop_name']);
   //   streetsList = new List<String>.from(newMap);
    print("anaz Groceries");
    print(newMap['Anaz Groceries']);

    print("anaz ANAZ MALL");
    print(newMap['ANAZ MALL']);

  // }
     // print(streetsList);

    // var data = [
    //   {"title": 'Avengers', "release_date": '10/01/2019'},
    //   {"title": 'Creed', "release_date": '10/01/2019'},
    //   {"title": 'Jumanji', "release_date": '30/10/2019'},
    // ];


    // var newMap = groupBy(data, (obj) => obj['release_date']).map(
    //         (k, v) => MapEntry(k, v.map((item) { item.remove('release_date'); return item;}).toList()));
    //
    // print(newMap);








  }
}
