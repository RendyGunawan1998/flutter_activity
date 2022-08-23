import 'package:get/get.dart';
import 'package:pretestflutter/extra/core.dart';

class MyActivityPage extends StatefulWidget {
  const MyActivityPage({Key key}) : super(key: key);

  @override
  _MyActivityPageState createState() => _MyActivityPageState();
}

class _MyActivityPageState extends State<MyActivityPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Text('My Activity Page'),
        ),
      ),
    );
  }
}
