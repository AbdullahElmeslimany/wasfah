import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class RecommendationState extends StatelessWidget {
  final data;
  const RecommendationState({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List imagelist = [
      {"id": "1", "name": "meat", "Url": "assets/images/imageone.jpg"},
      {"id": "2", "name": "fish", "Url": "assets/images/imagetwo.jpg"},
      {"id": "3", "name": "potatoes", "Url": "assets/images/imagethree.jpg"},
      {"id": "4", "name": "food", "Url": "assets/images/imagefour.jpg"}
    ];
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length < 4 ? data.length : 4,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 17),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: data[index]["urlimage"] == null
                                ? Image.asset("assets/images/loading2.gif")
                                : Image.network(
                                    data[index]["urlimage"],
                                    width: 150,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data[index]["name"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
