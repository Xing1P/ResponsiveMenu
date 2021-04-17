import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff36383F), statusBarBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xff36383F)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool showMenu = false;
  bool isExtend = false;
  double oldWidth;
  String mTitle = " My Days";
  Color mColor = Color(0xffBAC3E6);
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: LayoutBuilder(
          builder: (context, constrain) {
            isExtend = constrain.maxWidth > 700;
            if (oldWidth != constrain.maxWidth && showMenu) {
              showMenu = false;
            }
            oldWidth = constrain.maxWidth;
            print("check extend $isExtend");
            return Stack(
              children: [
                ContainerPage(isExtend, mTitle, mColor, () {
                  setState(() {
                    showMenu = true;
                    print("showMenu $showMenu");
                    _animationController.forward();
                  });
                }),
                CollapseMenu(isExtend, showMenu, (color, title) {
                  setState(() {
                    mTitle = title;
                    mColor = color;
                    showMenu = false;
                    _animationController.reverse();
                  });
                }, () {
                  _animationController.reverse();
                  setState(() {
                    showMenu = false;
                  });
                }, _animationController)
              ],
            );
          },
        ),
      ),
    );
  }
}

class ContainerPage extends StatelessWidget {
  final bool isExtend;
  final String title;
  final Color color;
  final VoidCallback showMenuCallback;

  ContainerPage(this.isExtend, this.title, this.color, this.showMenuCallback);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: isExtend ? 300 : 10, top: 10, bottom: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(color: color),
          width: double.infinity,
          child: ListView(
            children: [
              isExtend
                  ? Center()
                  : Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          showMenuCallback();
                        },
                        icon: Icon(Icons.menu),
                      )),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Header("Session A"),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecommendCard("assets/s4.jpg"),
                    RecommendCard("assets/s7.png"),
                    RecommendCard("assets/s6.jpg"),
                    RecommendCard("assets/s4.jpg"),
                    RecommendCard("assets/s7.png"),
                    RecommendCard("assets/s6.jpg")
                  ],
                ),
              ),
              Header("Session B"),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecommendCard("assets/s4.jpg"),
                    RecommendCard("assets/s7.png"),
                    RecommendCard("assets/s6.jpg"),
                    RecommendCard("assets/s4.jpg"),
                    RecommendCard("assets/s7.png"),
                    RecommendCard("assets/s6.jpg")
                  ],
                ),
              ),
              Header("Session C"),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecommendCard("assets/s4.jpg"),
                    RecommendCard("assets/s7.png"),
                    RecommendCard("assets/s6.jpg"),
                    RecommendCard("assets/s4.jpg"),
                    RecommendCard("assets/s7.png"),
                    RecommendCard("assets/s6.jpg")
                  ],
                ),
              ),
              Header("Session D"),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecommendCard("assets/s4.jpg"),
                    RecommendCard("assets/s7.png"),
                    RecommendCard("assets/s6.jpg"),
                    RecommendCard("assets/s4.jpg"),
                    RecommendCard("assets/s7.png"),
                    RecommendCard("assets/s6.jpg")
                  ],
                ),
              ),
              Header("Session E"),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecommendCard("assets/s4.jpg"),
                    RecommendCard("assets/s7.png"),
                    RecommendCard("assets/s6.jpg"),
                    RecommendCard("assets/s4.jpg"),
                    RecommendCard("assets/s7.png"),
                    RecommendCard("assets/s6.jpg")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CollapseMenu extends StatefulWidget {
  final bool isExtend;
  final bool showMenu;
  final Function(Color, String) menuListener;
  final VoidCallback hideMenuCallback;
  final AnimationController animationController;

  CollapseMenu(this.isExtend, this.showMenu, this.menuListener,
      this.hideMenuCallback, this.animationController);

  @override
  _CollapseMenuState createState() => _CollapseMenuState();
}

class _CollapseMenuState extends State<CollapseMenu> {
  int menuIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, snapshot) {
          Offset offset = Offset(-300, 0);
          if (widget.isExtend) {
            offset = Offset(0, 0);
          } else if (widget.showMenu) {
            offset = Offset(-300 + (widget.animationController.value * 300), 0);
          }
          return Stack(
            children: [
              Visibility(
                visible: widget.showMenu,
                child: GestureDetector(
                  onTap: () {
                    widget.hideMenuCallback();
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
              Transform.translate(
                offset: offset,
                child: Container(
                  width: 300,
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      MenuRow(Color(0xff6579C8), Icons.wb_sunny, "My Days",
                          menuIndex == 0, () {
                        setState(() {
                          menuIndex = 0;
                        });
                        widget.menuListener(Color(0xffBAC3E6), "My Days");
                      }),
                      MenuRow(Color(0xff166F6B), Icons.favorite, "Important",
                          menuIndex == 1, () {
                        setState(() {
                          menuIndex = 1;
                        });
                        widget.menuListener(Color(0xff97BFBD), "Important");
                      }),
                      MenuRow(Color(0xffAC395D), Icons.calendar_today,
                          "Planned", menuIndex == 2, () {
                        setState(() {
                          menuIndex = 2;
                        });
                        widget.menuListener(Color(0xffD9A7B7), "Planned");
                      }),
                      MenuRow(Color(0xff2196F3), Icons.account_circle_outlined,
                          "Assigned to you", menuIndex == 3, () {
                        setState(() {
                          menuIndex = 3;
                        });
                        widget.menuListener(
                            Color(0xffBDDFFB), "Assigned to you");
                      }),
                      MenuRow(Color(0xffF6C23E), Icons.home_outlined, "Tasks",
                          menuIndex == 4, () {
                        setState(() {
                          menuIndex = 4;
                        });
                        widget.menuListener(Color(0xffFBE3A9), "Tasks");
                      })
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class MenuRow extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final String title;
  final bool isActive;
  final VoidCallback voidCallback;

  MenuRow(
      this.color, this.iconData, this.title, this.isActive, this.voidCallback);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        voidCallback();
      },
      child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              iconData,
              size: isActive ? 18 : 15,
              color: isActive ? color : Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive ? color : Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendCard extends StatelessWidget {
  final String image;

  RecommendCard(this.image);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.loose,
        children: [
          Container(
            height: 100,
            width: 380,
            decoration: BoxDecoration(
                color: Color(0xff36383F),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 120, top: 10, bottom: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rear Window",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Cornell Woolrich",
                    style: TextStyle(color: Colors.white54),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.orange,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.orange,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.orange,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.orange,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.circle,
                          size: 10,
                          color: Color(0xff5C5E65),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "4.8",
                          style: TextStyle(color: Colors.orange, fontSize: 10),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 20,
            child: Hero(
              tag: image,
              child: SizedBox(
                width: 100,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;

  Header(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            "All",
            style: TextStyle(color: Colors.black),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
