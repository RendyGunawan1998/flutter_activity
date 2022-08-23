import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pretestflutter/extra/core.dart';
import 'package:pretestflutter/page/edit/edit_activity.dart';

class InfoActivity extends StatefulWidget {
  final int id;
  const InfoActivity({Key key, this.id}) : super(key: key);

  @override
  _InfoActivityState createState() => _InfoActivityState();
}

class _InfoActivityState extends State<InfoActivity> {
  final DisplayBloc _infoBloc = DisplayBloc(activityRepo: ActivityRepo());

  TextEditingController result = TextEditingController();
  int tempId;

  @override
  void initState() {
    super.initState();
    tempId = widget.id;
    // print('temp id :: $tempId');
    _infoBloc.add(InfoFetch(id: tempId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarInfo(),
      body: BlocProvider(
        create: (context) => DisplayBloc(
          activityRepo: ActivityRepo(),
        ),
        child: BlocBuilder<DisplayBloc, DisplayState>(
            bloc: _infoBloc,
            builder: (context, state) {
              if (state is DisplayOnFailure) {
                return Center(
                  child: LoadDataError(
                    subtitle: state.error,
                  ),
                );
              }
              if (state is InfoDataLoaded) {
                if (state.dataList == null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(60, 140, 50, 0),
                        child: Image.asset(
                          "assets/images/no_data.png",
                          width: 150,
                          height: 100,
                          fit: BoxFit.fill,
                          // color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 50),
                        child: Column(
                          children: [
                            Text("Data Kosong"),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return bodyInfo(state.dataList);
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  Widget bodyInfo(DispayActivity data) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            containerDetails(data),
            hbox(15),
            Text(
              'What is the result ?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            hbox(7),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: TextField(
                  maxLines: 4,
                  controller: result,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        'Customer setuju untuk membeli dalam jumlah banyak',
                  ),
                ),
              ),
            ),
            hbox(15),
            buttonComplete(),
          ],
        ),
      ),
    );
  }

  Widget buttonComplete() {
    return Container(
      height: 50,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: HexColor('#20C3AF'),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          'Complete Activity',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget containerDetails(DispayActivity data) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            hbox(5),
            Text(
              '${data.activityType.capitalizeFirst} with ${data.institution} at ${DateFormat('dd-MMMM-yyyy HH:mm').format(DateTime.parse(data.when))} to discuss about ${data.objective}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            hbox(5),
            InkWell(
              onTap: () {
                Get.to(() => EditActivity(
                      id: data.id,
                      data: data,
                    ));
              },
              child: Container(
                height: 35,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: HexColor('#001689'),
                ),
                child: Center(
                  child: Text(
                    'Edit Activity',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appbarInfo() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: HexColor('#001689'),
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => TabBarPage());
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          children: [
            wbox(70),
            Text(
              'Activity Info',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
