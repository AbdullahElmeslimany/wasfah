import 'package:flutter/material.dart';

class RecommendationState extends StatelessWidget {
  const RecommendationState({super.key});

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
        itemCount: imagelist.length,
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
                            child: Image.asset(
                              imagelist[index]["Url"],
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
                          imagelist[index]["name"],
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
