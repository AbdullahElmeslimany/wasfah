import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfah/loginpage/loginscreen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late bool onboarder = false;
  addsharedpref() async {
    SharedPreferences prefget = await SharedPreferences.getInstance();
    await prefget.setBool("onboarder", onboarder);
  }

  String url = "assets/images/";

  List name = [
    "Find your favorite food",
    "Enjoy Great Food",
    "onboarderthree.png"
  ];
  List paragraph = [
    "Find the best meal and choose \n from your favorite menu to eat",
    "Enjoy your favorite food You will cook food \n in an easier way with less effort",
    "onboarderthree.png"
  ];

  @override
  void initState() {
    addsharedpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List image = [
      "${url}onboarderone.png",
      "${url}onboardertwo.png",
      "${url}onboarderthree.png"
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFF1E8),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        onboarder = true;
                      });
                      addsharedpref();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogInPage(),
                          ));
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          color: Color.fromARGB(255, 170, 169, 169),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height - 280,
              child: PageView.builder(
                itemBuilder: (context, i) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("${image[i]}"),
                      Text(
                        "${name[i]}",
                        style: const TextStyle(
                            color: Color(0xffC80000),
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${paragraph[i]}",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.sizeOf(context).width - 205),
                        child: SizedBox(
                          height: 9,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: image.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 9,
                                    width: 9,
                                    decoration: BoxDecoration(
                                        color: i == index
                                            ? Colors.amber
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width / 2,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 236, 72, 72),
                  borderRadius: BorderRadius.circular(25)),
              child: MaterialButton(
                onPressed: () {},
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
