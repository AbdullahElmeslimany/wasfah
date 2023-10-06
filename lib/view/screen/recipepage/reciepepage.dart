// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasfah/view/screen/recipepage/textrecipe.dart';

class RecipePage extends StatefulWidget {
  final String? id;

  const RecipePage({super.key, required this.id});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late final ref;
  late final QuerySnapshot ingredientsData;

  // String id = "TVdDvXJ94ZxARPRm1lOw";
  String name = "recipe";
  var data;
  List dataIngredientList = [];

  getdata() async {
    ref =
        await FirebaseFirestore.instance.collection(name).doc(widget.id).get();
    setState(() {
      data = ref;
    });
  }

  ingredients() async {
    ingredientsData = await FirebaseFirestore.instance
        .collection(name)
        .doc(widget.id)
        .collection("ingredients")
        .get();
    setState(() {
      dataIngredientList.addAll(ingredientsData.docs);
    });
    print(ingredientsData);
  }

  @override
  void initState() {
    getdata();
    ingredients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: data == null
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      color: Colors.black,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                            data["urlimage"],fit: BoxFit.fill,),
                                      ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.sizeOf(context).height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white,
                      ),
                      child: TextReciepe(iddata: widget.id,
                          name: data["name"],
                          rate: data["rate"],
                          ratehard: data["details"]["ratehard"],
                          cal: data["details"]["cal"],
                          discription: data["description"],
                          imageurl: data["name"],
                          preparation: data["preparetion"],
                          time: data["details"]["time"],
                          grams: data["component"]["gram"],
                          items: data["component"]["items"],

                          ),

                    ),
                  ],
                ),
        ),
      )),
    );
  }
}
