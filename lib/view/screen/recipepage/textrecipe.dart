
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:wasfah/view/screen/recipepage/ingredients.dart';

class TextReciepe extends StatelessWidget {
  final String? iddata;
  final String? name;
  final String? rate;
  final String? cal;
  final String? time;
  final String? discription;
  final String? imageurl;
  final String? preparation;
  final String? ratehard;
  final List items;
  final  grams;
  const TextReciepe(
      {super.key,
      required this.name,
      required this.iddata,
      required this.rate,
      required this.cal,
      required this.discription,
      required this.imageurl,
      required this.preparation,
      required this.ratehard,
      required this.time,
      required this.items,
      this.grams});

  @override
  Widget build(BuildContext context) {
    // String namefood = "Meat";
    // int cal = 512;
    // int time = 10;
    // String descriptiontitle =
    //     "chocolate is the best kid of dessert ! these choco macarons are simply heavenly! delicate little cookies filed with chocolate ganache";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "$name",
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[600],
                    ),
                    Text("$rate")
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.grey[400],
                ),
                Text(
                  "$time mins",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.equalizer_rounded,
                  color: Colors.grey[400],
                ),
                Text(
                  "$ratehard ",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.local_fire_department_outlined,
                  color: Colors.grey[400],
                ),
                Text(
                  "$cal cal",
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Description",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "$discription",
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Ingredients",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                  // height: MediaQuery.sizeOf(context).height-284,
                  height: items.length*45,
                  child: Ingredients(
                    id: iddata,
                    items: items,
                    grams: grams,
                  )),
            ),
            const Text(
              "Preparation",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$preparation",
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
