import 'package:pretestflutter/extra/core.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int pageIndex = 0;
  DateTime currentBackPressTime;

  List<Widget> tabs = <Widget>[
    DisplayHome(),
    MyActivityPage(),
    OrderPage(),
    ProfilePage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DisplayHome();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPopLogout,
      child: Scaffold(
        // body: tabs.elementAt(pageIndex),
        body: PageStorage(bucket: bucket, child: currentScreen),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 2,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: HexColor('#001689'),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 3, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  iconNav(
                    () {
                      setState(() {
                        currentScreen = DisplayHome();
                        pageIndex = 0;
                      });
                    },
                    Icons.home_sharp,
                    'Home',
                  ),
                  iconNav(() {
                    setState(() {
                      currentScreen = MyActivityPage();
                      pageIndex = 1;
                    });
                  }, Icons.calendar_month, 'Activity'),
                  iconNav(() {
                    setState(() {
                      currentScreen = OrderPage();
                      pageIndex = 2;
                    });
                  }, Icons.library_books_outlined, 'Orders'),
                  iconNav(() {
                    setState(() {
                      currentScreen = ProfilePage();
                      pageIndex = 3;
                    });
                  }, Icons.person, 'My Profile'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget iconNav(Function() func, IconData icon, String isi) {
    return Expanded(
      child: MaterialButton(
        onPressed: func,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            hbox(2),
            Text(
              isi,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onWillPopLogout() async {
    // await showDialog or Show add banners or whatever
    // then
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "double click to exit", backgroundColor: Colors.black);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
