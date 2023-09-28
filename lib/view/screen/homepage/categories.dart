import 'package:flutter/material.dart';
import 'package:wasfah/categoriestypeselectpage/selectcategoriespage.dart';


class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List categorieslist = [
      {
        "id": "1",
        "name": "Breakfast",
        "icon": Icons.food_bank_rounded,
        "type": "breakfast"
      },
      {
        "id": "2",
        "name": "Lunch",
        "icon": Icons.food_bank_rounded,
        "type": "lunch"
      },
      {
        "id": "3",
        "name": "Dinner",
        "icon": Icons.food_bank_rounded,
        "type": "dinner"
      },
      {
        "id": "4",
        "name": "Dessert",
        "icon": Icons.food_bank_rounded,
        "type": "dessert"
      },
      {
        "id": "5",
        "name": "juice",
        "icon": Icons.food_bank_rounded,
        "type": "juice"
      },
      {
        "id": "5",
        "name": "Salad",
        "icon": Icons.food_bank_rounded,
        "type": "salad"
      },
      {
        "id": "5",
        "name": "Sauce",
        "icon": Icons.food_bank_rounded,
        "type": "sauce"
      }
    ];
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categorieslist.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: () {
                  print(categorieslist[index]["type"]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectCategoriesScreen(
                            name: categorieslist[index]["name"],
                            type: categorieslist[index]["type"]),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17)),
                  width: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Icon(categorieslist[index]["icon"]),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        categorieslist[index]["name"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey[500]),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
