// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasfah/constant/const.dart';
import 'package:wasfah/view/screen/recipepage/reciepepage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late QuerySnapshot querySnapshot;
  String? iddoc;
  String namecolloction = "recipe";
  List<QueryDocumentSnapshot> data = [];
  String? name;
  late bool loading = false;

  getData() async {
    querySnapshot = await FirebaseFirestore.instance
        .collection(namecolloction)
        .where("name", isEqualTo: "$name")
        .get();

    setState(() {
      data.addAll(querySnapshot.docs);
      loading = false;
    });
    print(data);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 30, right: 30, bottom: 20),
              child: TextFormField(
                onChanged: (value) async {
                  setState(() {
                    loading = true;

                    name = value;
                  });
                  data.clear();
                  await getData();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(25)),
              child: MaterialButton(
                child: loading == true
                    ? const CircularProgressIndicator()
                    : const Text(
                        "بحث",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                onPressed: () {
                  setState(() {
                    data.clear();
                    loading = true;
                  });
                  // print(iddoc);
                  print("===================================");
                  getData();
                },
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecipePage(id: data[index].id),
                                ));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: redColor),
                              height: 80,
                              width: MediaQuery.sizeOf(context).width - 30,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                            data[index]["urlimage"])),
                                  ),
                                  const SizedBox(
                                    width: 90,
                                  ),
                                  Text(
                                    data[index]["name"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ],
                              )))),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
