import 'package:flutter/material.dart';
import 'package:wasfah/view/screen/searchpage/searchscreen.dart';

class SearchBarHome extends StatelessWidget {
  const SearchBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ));
            },
            child: TextField(
              enabled: false,
              onTap: () {},
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
                  hintText: "Search Any Recipes",
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Icon(
                      Icons.search,
                      size: 30,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
