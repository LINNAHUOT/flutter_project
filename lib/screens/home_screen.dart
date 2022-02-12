import 'dart:convert';
import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourtaste/components/dimensions.dart';
import 'package:yourtaste/data/soup.dart';
import '../components/btext.dart';
import '../components/colors.dart';
import '../components/stext.dart';
import '../data/soup_data.dart';
import 'details_screen.dart';

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
          Expanded(child: SingleChildScrollView(
            child: HomeBody(items),
          )),
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
  //List<> items = [];

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
        SizedBox(height: 10,),
       Container(
         height:700,
         child:  ListView.builder(
             physics: NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             itemCount: SOUPDATA.length,
             itemBuilder: (BuildContext context,int index){
    var post=SOUPDATA.elementAt(index) ;
    print("===>post ${post["image"]}");
    // return GestureDetector(
    // onTap: () {
    // Navigator.of(context).push(MaterialPageRoute(
    // builder: (context) => DetailScreen()));
    return Container(
    margin: EdgeInsets.only(left: 5,right: 5,bottom: 10),
    child: Row(
    children: [
    Container(
    width: 120,
    height: 120,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Colors.white38,
    image: DecorationImage(
    image: ExactAssetImage(
    "${post["image"]}",
    ),
    fit: BoxFit.fitHeight,
    ),
    )),
    SizedBox(
    width: 10,
    ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text(
    "${post["title"]}",
    style: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black),
    ),
    ]),
    ]));
    }))],
            );

    // ListTile(
    //     leading: Icon(Icons.list),
    //     trailing: Text("GFG",
    //       style: TextStyle(
    //           color: Colors.green,fontSize: 15),),
    //     title:Text("List item $index")
    // );
    }
    // );
    // }),
    //

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
    // Positioned(
    // top:130 ,//size.height * 0.25 + space
    // right: 0,
    // left: 0,
    // child: Container(
    // decoration: BoxDecoration(
    // color: Color(0xffF1F1FA),
    // borderRadius: BorderRadius.only(
    // topLeft: Radius.circular(40),
    // topRight: Radius.circular(40) //Radius=40
    // ),
    // )
    // )
        // ListView.builder(
        //     physics: BouncingScrollPhysics(
        //         parent: AlwaysScrollableScrollPhysics()),
        //     shrinkWrap: true,
        //     itemCount: items.length,
        //     itemBuilder: (context, index) {
        //       var post = items[index];
        //       print("===>post ${post.image}");
        //       return GestureDetector(
        //         onTap: () {
        //           Navigator.of(context).push(MaterialPageRoute(
        //               builder: (context) => DetailScreen()));
        //           // Navigate to Certain Video of the list from DATABASE
        //         },
        //         child: Container(
        //           margin: EdgeInsets.only(top: 30),//size.width * 0.031597
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Container(
        //                   height: 80.0,
        //                   width: 80.0,
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.all(
        //                       Radius.circular(5),
        //                     ),
        //                     image: DecorationImage(
        //                       image: ExactAssetImage(
        //                         "${post.image}",
        //                       ),
        //                       fit: BoxFit.fitHeight,
        //                     ),
        //                   )),
        //               SizedBox(
        //                 width: 10,
        //               ),
        //               Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: <Widget>[
        //                   Text(
        //                     "${post.title}",
        //                     style: const TextStyle(
        //                         fontSize: 14,
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.black),
        //                   ),
        //                  ],
        //           ),
        //         ]),
        //       ));
        //     })
  }

  Widget _buildPageItem(int index) {
    return Stack(
      children: [
        Container(
          height: 180,
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


