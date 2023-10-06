import 'dart:io';

import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasfah/constant/const.dart';

class AdditemFirebase extends StatefulWidget {
  const AdditemFirebase({super.key});

  @override
  State<AdditemFirebase> createState() => _AdditemFirebaseState();
}

class _AdditemFirebaseState extends State<AdditemFirebase> {
  File? image;
  String? url;

  final ImagePicker picker = ImagePicker();
  selectImage() async {
    final XFile? imageSelect =
        await picker.pickImage(source: ImageSource.gallery);

    if (imageSelect != null) {
      setState(() {
        image = File(imageSelect.path);
      });
      String nameimage = basename(image!.path);
      Reference ref = FirebaseStorage.instance.ref().child(nameimage);
      print("=============================================================");
      print(ref);
      print("=============================================================");
      await ref.putFile(image!);
      print(await ref.getDownloadURL());
      print("=============================================================");
      String urlimage = await ref.getDownloadURL();

      print("=============================================================");
      setState(() {
        url = urlimage;
      });
    }
  }

  String? name;
  String? rate;
  String? time;
  String? ratehardselect;
  String? description;
  String? preparetion;
  String? cal;
  String? items;
  String? grams;
  String? type;
  String? dropdownValue;

  List<String> typefood = [
    "breakfast",
    "lunch",
    "dinner",
    "dessert",
    "juice",
    "salad",
    "sauce"
  ];
  List<String> ratehard = ["hard", "medium", "hard"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "اضافة وصفة",
                  style: TextStyle(
                      color: Color(0xffC80000),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: image == null
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      if (image != null)
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: url == null
                              ? const CircularProgressIndicator(
                                  color: Color(0xffC80000),
                                )
                              : SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(image!))),
                        ),
                      Container(
                        decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: MaterialButton(
                          onPressed: () {
                            selectImage();
                          },
                          child: const Text(
                            "Image",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      // : Image.file(image!)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 20,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "rate",
                        ),
                        textAlign: TextAlign.end,
                        onChanged: (value) {
                          setState(() {
                            rate = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 20,
                      child: TextFormField(
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "description",
                  ),
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 15,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "time",
                        ),
                        textAlign: TextAlign.end,
                        onChanged: (value) {
                          setState(() {
                            time = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 15,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "cal",
                        ),
                        textAlign: TextAlign.end,
                        onChanged: (value) {
                          setState(() {
                            cal = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  // width: MediaQuery.sizeOf(context).width / 3 - 30,
                  child: DropdownMenu(
                      initialSelection: ratehard.first,
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          ratehardselect = value!;
                        });
                      },
                      dropdownMenuEntries: ratehard
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList()),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 15,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "items",
                        ),
                        textAlign: TextAlign.end,
                        onChanged: (value) {
                          setState(() {
                            items = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 15,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "grams",
                        ),
                        textAlign: TextAlign.end,
                        onChanged: (value) {
                          setState(() {
                            grams = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "preparetion",
                  ),
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {
                      preparetion = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownMenu(
                    initialSelection: typefood.first,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    dropdownMenuEntries:
                        typefood.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList()),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    child: const Text(
                      "اضف",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("recipe")
                          .add({
                        "name": name,
                        "urlimage": url,
                        "rate": ratehardselect,
                        "type": dropdownValue,
                        "preparetion": preparetion,
                        "description": description,
                        "component": {
                          "items": [items],
                          "gram": [grams]
                        },
                        "details": {
                          "time": time,
                          "ratehard": ratehard,
                          "cal": cal
                        },
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
