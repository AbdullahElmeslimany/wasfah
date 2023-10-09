import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasfah/constant/const.dart';
import 'package:wasfah/view/screen/recipepage/reciepepage.dart';

class SelectCategoriesScreen extends StatefulWidget {
  final name;
  final type;
  const SelectCategoriesScreen(
      {super.key, required this.name, required this.type});

  @override
  State<SelectCategoriesScreen> createState() => _SelectCategoriesScreenState();
}

class _SelectCategoriesScreenState extends State<SelectCategoriesScreen> {
  late QuerySnapshot querySnapshot;
  String namecolloction = "recipe";
  List<QueryDocumentSnapshot> data = [];
  String? name;
  bool loading = true;

  getData() async {
    querySnapshot = await FirebaseFirestore.instance
        .collection(namecolloction)
        .where("type", isEqualTo: widget.type)
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
    print("===============================================");
    print("===============================================");
    print(widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "${widget.name}",
                      style: TextStyle(
                          color: redColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height - 50,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
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
                                width: MediaQuery.sizeOf(context).width - 20,
                                height: 90,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 65,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                            data[index]["urlimage"]),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      data[index]["name"],
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      data[index]["rate"],
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    ));
  }
}
