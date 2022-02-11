import 'dart:convert';
import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourtaste/data/soup.dart';
import '../components/btext.dart';
import '../components/colors.dart';
import '../components/stext.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<SoupDart> items = [];

  @override
  void initState() {

    getJson().then((value) =>
        () {
      setState(() {
        Iterable list = json.decode(value);
        items = list.map((e) => SoupDart.fromJson(e)).toList();
        log(items.length);
      });
    });
    super.initState();
  }

  Future<String> getJson()
  {
    return rootBundle.loadString('assets/soup.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child:
            Container(
                margin: EdgeInsets.only(top: 45,bottom:15),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BText(
                          text: "Your Taste",
                          color: AppColors.mainColor,
                        ),
                        Row(
                          children: [
                            SText(text: "Soup", color: Colors.black54,),
                            Icon(Icons.arrow_drop_down_rounded),
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 45,
                        height: 45,
                        child: Icon(Icons.search, color: AppColors.iconColor1, size: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color : AppColors.mainColor,
                        ),
                      ),
                    )
                  ],
                )
            ),
          ),
          HomeBody(items),
        ],
      ),
    );
  }
}
class HomeBody extends StatefulWidget {
  List<SoupDart> items = [];
  HomeBody(List<SoupDart> items){
    this.items = items;
  }

  @override
  _HomeBodyState createState() => _HomeBodyState(items);
}

class _HomeBodyState extends State<HomeBody> {
  PageController pageController = PageController(viewportFraction: 0.80);
  var _currPageValue = 0.0;
  List<SoupDart> items = [];

  _HomeBodyState(List<SoupDart> items){
    this.items = items;
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //stack
        Container(
          height: 180,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        //Dot
        DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
         // Container(
        //   height: 100,
        //   child: ListView.separated(
        //     itemCount: items.length,
        //     itemBuilder: (context, index) {
        //       return Row(
        //         children: [
        //           Image.asset(items.elementAt(index).image),
        //           Text(items.elementAt(index).title)
        //         ],
        //       );
        //     }, separatorBuilder: (BuildContext context, int index) { return Divider(); },),
        // )
      ],

    );
  }

  Widget _buildPageItem(int index) {
    return Stack(
      children: [
        Container(
          height: 170,
          margin: EdgeInsets.only(left: 0, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage
                  ('assets/images/s.png'),
              )
          ),
        ),
      ],
    );

  }

}
