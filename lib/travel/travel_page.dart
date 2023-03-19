// ignore: unused_import
import 'dart:core';

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:velocity_x/velocity_x.dart';
// ignore: unused_import
import 'package:flutter_svg/flutter_svg.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});
  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
 
  final pic1 =
      "https://images.unsplash.com/photo-1533929736458-ca588d08c8be?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60";
  final pic2 =
      "https://images.unsplash.com/photo-1582050041567-9cfdd330d545?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60";
  // ignore: unused_field
  double anim = 1.0;
  double anim2 = 1.0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    withAnimation(
      vsync: this,
      tween: Tween(begin:  1.0, end: 0.0),
      callBack: (animationVal, controllerVal) {
        anim = animationVal!;
        setState(() {});
      },
    );
    withRepeatAnimation(
      vsync: this,
      isRepeatReversed: true,
      tween: Tween(begin: 2.0, end: 3.0),
      callBack: (animationVal, controllerVal) {
        anim2 = animationVal!;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
     final tabindex=_tabController.index;
    return Scaffold(
      backgroundColor: Vx.purple500,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0, // for appbar transparent
        leading: VStack([
          // vstack is A widget that displays its children in a vertical array
          VxBox().size(20, 2).white.make(), // vxbox its a box
          5.heightBox,
          VxBox().size(28, 2).white.make(),
          5.heightBox,
          VxBox().size(15, 2).white.make(),
        ]).pOnly(left: 16, top: 16), //pOnly for padding
      ),
      body: VStack([
        VxBox(
                child: [
          VxBox()
              .square(100)
              .roundedFull
              .neumorphic(
                  color: Vx.purple500,
                  elevation:
                      30) // neumorphic Use for convert your box to the neumorphic design. Use it wisely.
              // ignore: unnecessary_string_escapes, prefer_const_constructors
              .bgImage(DecorationImage(
                  // ignore: prefer_const_constructors
                  image: AssetImage('assets/images/dev.jpg')))
              .make(),
          "Hi, "
              .richText
              .withTextSpanChildren(["Dev".textSpan.bold.make()])
              .white
              .xl2
              .make()
              // ignore: prefer_const_constructors
              .p8()
              .offset(offset: Offset(-300 * anim, 0)),
          "Solo Traveller".text.white.make(),
          // ignore: prefer_const_constructors
          VxTextField(
            // under the type is properties of vxtextfield
            borderType: VxTextFieldBorderType.none,
            borderRadius: 18, //radius for your tetxt
            hint: "Search", // for string
            fillColor: Vx.gray200.withOpacity(0.3), //for coloring
            contentPaddingTop: 13, //for padding
            autofocus: false, //focus of sliding when tapped button
            // ignore: prefer_const_constructors
            prefixIcon: Icon(
              // for search icon
              Icons.search_outlined, color: Colors.white,
            ),
          )
              .customTheme(themeData: ThemeData(brightness: Brightness.dark))
              .cornerRadius(10)
              .p16()
        ].column())
            .makeCentered(),
        ClipRRect(
                // for Creates a rounded-rectangular clip.
                // ignore: prefer_const_constructors
                borderRadius: BorderRadius.only(
                  // ignore: prefer_const_constructors
                  topLeft: Radius.circular(20),
                  // ignore: prefer_const_constructors
                  topRight: Radius.circular(20),
                ),
                child: VxBox(
                    child: VStack([
                  TabBar(
                    controller: _tabController,
                    // ignore: prefer_const_literals_to_create_immutables
                    indicatorColor: Colors.purple,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Vx.purple500,
                    unselectedLabelColor: Vx.gray400,
                    labelPadding: Vx.m16,
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      // ignore: prefer_const_constructors
                      Icon(Icons.map, size:10).scale(scaleValue:tabindex==0? anim2:3.0),
                      // ignore: prefer_const_constructors
                      Icon(Icons.pin_drop, size:10).scale(scaleValue:tabindex==1? anim2:3.0),
                      // ignore: prefer_const_constructors
                      Icon(Icons.restaurant, size:10).scale(scaleValue:tabindex==2? anim2:3.0),
                      // ignore: prefer_const_constructors
                      Icon(Icons.person, size:10).scale(scaleValue:tabindex==3? anim2:3.0),
                    ],
                  ),
                  TabBarView(
                          controller: _tabController,
                          // ignore: prefer_const_constructors
                          children: ["1", "2", "3", "4"]
                              // ignore: prefer_const_constructors
                              .map((e) => VStack([
                                    "Discover places in London"
                                        .text
                                        .bold
                                        .gray600
                                        .xl2
                                        .make(),
                                    20.heightBox,
                                    TravelCard(
                                        imageurl: pic1,
                                        title: "Tower bridge",
                                        subtitle: "southork"),
                                    20.heightBox,
                                    TravelCard(
                                        imageurl: pic2,
                                        title: "London Eye",
                                        subtitle: "Country Hall"),
                                  ]).p16())
                              .toList())
                      .expand()
                ])).white.make())
            .expand()
      ]),
    );
  }
}

class TravelCard extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final String title, subtitle, imageurl;

  const TravelCard(
      {Key? key,
      required this.imageurl,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HStack([
      Image.network(
        imageurl,
        fit: BoxFit.cover,
      ).wh(150, 100).cornerRadius(8),
      // ignore: prefer_const_constructors
      WidthBox(20),
      VStack(
        [
          title.text.semiBold.make(),
          3.heightBox,
          subtitle.text.make().shimmer(),
          5.heightBox,
          [
            VxRating(size: 13, onRatingUpdate: (value) {}),
            5.heightBox,
            "(100)".text.xs.gray600.make()
          ].row()
        ],
        crossAlignment: CrossAxisAlignment.start,
      ).expand()
    ]).cornerRadius(8).backgroundColor(Vx.gray200);
  }
}
