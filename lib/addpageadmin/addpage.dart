import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class AddPageAdmin extends StatefulWidget {
  const AddPageAdmin({super.key});

  @override
  State<AddPageAdmin> createState() => _AddPageAdminState();
}

class _AddPageAdminState extends State<AddPageAdmin> {
  @override
  Widget build(BuildContext context) {
    String? name;
    String? rate;
    String? time;
    String? ratehard;
    String? description;
    String? preparetion;
    String? cal;
    String? items;
    String? grams;
    String? type;
    List<String> typefood = [
      "breakfast",
      "lunch",
      "dinner",
      "dessert",
      "juice",
      "salad",
      "sauce"
    ];
    String? dropdownValue ;
    List typefoodAR = [
      "فطار",
      "غداء",
      "عشاء",
      "حلويات",
      "عصائر",
      "سلطة",
      "صوص"
    ];
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Row(
            //   children: [
            //     Center(
            //       child: Padding(
            //         padding: const EdgeInsets.only(left: 55.0),
            //         child: Text(
            //           "اضافة وصفة",
            //           style: TextStyle(
            //               color: Colors.teal[500],
            //               fontSize: 30,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ),
            //     const Row(
            //       children: [
            //         Padding(
            //           padding: EdgeInsets.only(right: 10.0),
            //           child: Icon(
            //             Icons.clear_all_outlined,
            //             size: 40,
            //             color: Colors.orange,
            //           ),
            //         ),
            //       ],
            //     )
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 3,
            //       child:
            TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "name",
                    ),
                    textAlign: TextAlign.end,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                // ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       flex: 2,
            //       child: TextFormField(
            //         keyboardType: TextInputType.number,
            //         decoration: const InputDecoration(
            //           border: OutlineInputBorder(),
            //           labelText: "rate",
            //         ),
            //         textAlign: TextAlign.end,
            //         onChanged: (value) {
            //           setState(() {
            //             rate = value;
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextFormField(
            //         keyboardType: TextInputType.number,
            //         decoration: const InputDecoration(
            //           border: OutlineInputBorder(),
            //           labelText: "time",
            //         ),
            //         textAlign: TextAlign.end,
            //         onChanged: (value) {
            //           setState(() {
            //             time = value;
            //           });
            //         },
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: TextFormField(
            //         decoration: const InputDecoration(
            //           border: OutlineInputBorder(),
            //           labelText: "ratehard",
            //         ),
            //         textAlign: TextAlign.end,
            //         onChanged: (value) {
            //           setState(() {
            //             ratehard = value;
            //           });
            //         },
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: TextFormField(
            //         keyboardType: TextInputType.number,
            //         decoration: const InputDecoration(
            //           border: OutlineInputBorder(),
            //           labelText: "cal",
            //         ),
            //         textAlign: TextAlign.end,
            //         onChanged: (value) {
            //           setState(() {
            //             cal = value;
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // TextFormField(
            //   minLines: 3,
            //   maxLines: 9,
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: "description",
            //   ),
            //   textAlign: TextAlign.end,
            //   onChanged: (value) {
            //     setState(() {
            //       description = value;
            //     });
            //   },
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: TextFormField(
            //         decoration: const InputDecoration(
            //           border: OutlineInputBorder(),
            //           labelText: "items",
            //         ),
            //         textAlign: TextAlign.end,
            //         onChanged: (value) {
            //           setState(() {
            //             items = value;
            //           });
            //         },
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 15,
            //     ),
            //     Expanded(
            //       child: TextFormField(
            //         keyboardType: TextInputType.number,
            //         decoration: const InputDecoration(
            //           border: OutlineInputBorder(),
            //           labelText: "grams",
            //         ),
            //         textAlign: TextAlign.end,
            //         onChanged: (value) {
            //           setState(() {
            //             grams = value;
            //           });
            //         },
            //       ),
            //     )
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // TextFormField(
            //   minLines: 3,
            //   maxLines: 9,
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: "preparetion",
            //   ),
            //   textAlign: TextAlign.end,
            //   onChanged: (value) {
            //     setState(() {
            //       preparetion = value;
            //     });
            //   },
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // DropdownMenu(
            //     initialSelection: typefood.first,
            //     onSelected: (String? value) {
            //       // This is called when the user selects an item.
            //       setState(() {
            //         dropdownValue = value!;
            //       });
            //     },
            //     dropdownMenuEntries:
            //         typefood.map<DropdownMenuEntry<String>>((String value) {
            //       return DropdownMenuEntry<String>(value: value, label: value);
            //     }).toList()),
            // const SizedBox(
            //   height: 20,
            // ),
            Container(
              // width: MediaQuery.sizeOf(context).width - 30,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () async {
                  print(dropdownValue);
                  // await FirebaseFirestore.instance.collection("recipe").add({
                  //   "name": name,
                  //   "rate": rate,
                  //   "type": dropdownValue,
                  //   "preparetion": preparetion,
                  //   "description": description,
                  //   "component": {
                  //     "items": [items],
                  //     "gram": [grams]
                  //   },
                  //   "details": {"time": time, "ratehard": ratehard, "cal": cal},
                  // });

                  // await FirebaseFirestore.instance
                  //     .collection("recipe")
                  //     .doc("VCuVVJ9buuRWZOeQKcpE")
                  //     .collection("ingredients")
                  //     .add({
                  //   "component": {
                  //     "items": [items],
                  //     "gram": [grams]
                  //   }
                  // });
                },
                child: const Text(
                  "اضف",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      )),
    ));
  }
}
