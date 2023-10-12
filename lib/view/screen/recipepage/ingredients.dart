// ignore_for_file: avoid_print

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ingredients extends StatefulWidget {
  final String? id;
  final List items;
  final List grams;

  const Ingredients(
      {super.key, required this.id, required this.items, required this.grams});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  // late final ref;
  // late final ingredientsData;

  // String id = "TVdDvXJ94ZxARPRm1lOw";
  String name = "recipe";
  bool select = false;
  // var data;
  List dataIngredientList = [];
  List datatItemsList = [];
  List datatgramssList = [];

  // ingredients() async {
  //   ingredientsData = await FirebaseFirestore.instance
  //       .collection(name)
  //       .doc(widget.id)
  //       .collection("ingredients")
  //       .get();
  //   setState(() {
  //     dataIngredientList.addAll(ingredientsData.docs);

  //     datatItemsList = dataIngredientList[0]["component"]["items"];
  //     datatgramssList = dataIngredientList[0]["component"]["gram"];
  //   });
  //   print("================================================");
  //   print(ingredientsData);
  //   print(dataIngredientList[0]["component"]["items"][0]);
  //   print(datatItemsList);

  //   print("================================================");
  // }

  @override
  void initState() {
    // ingredients();
    print("================================================");
    print(widget.items);
    print(widget.grams);
    print("================================================");
    super.initState();
  }

  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    // List Detials = [
    //   {"id": "1", "icon": "suger", "name": "suger", "garm": "160"},
    //   {
    //     "id": "2",
    //     "icon": "ground almond",
    //     "name": "ground almond",
    //     "garm": "160"
    //   },
    //   {"id": "3", "icon": "cocolate", "name": "cocolate", "garm": "110"},
    //   // {"id": "4", "icon": "", "name": "", "garm": ""},
    //   // {"id": "5", "icon": "", "name": "", "garm": ""},
    // ];

    return ListView.builder(
      // controller: ScrollController(keepScrollOffset: false),
      controller: _controller,
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (select == false) {
                    select = true;
                    print(index);
                  } else {
                    select = false;
                    print(index);
                  }
                });
              },
              child: Container(
                height: 27,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: select == true ? Colors.amber : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.fastfood_outlined),
                        Container(
                          width: 15,
                        ),
                        Text(widget.items[index]),
                        // Text("${datatItemsList[index]}"),
                      ],
                    ),
                    Text("${widget.grams[index]} g")
                    // Text("${datatgramssList[index]} g")
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
