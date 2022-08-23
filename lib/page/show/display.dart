import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:pretestflutter/extra/core.dart';

class DisplayHome extends StatefulWidget {
  const DisplayHome({Key key}) : super(key: key);

  @override
  _DisplayHomeState createState() => _DisplayHomeState();
}

class _DisplayHomeState extends State<DisplayHome> {
  final DisplayBloc _displayBloc = DisplayBloc(activityRepo: ActivityRepo());

  @override
  void initState() {
    super.initState();

    _displayBloc.add(ActivityFetch(status: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDisplay(),
      body: BlocProvider(
        create: (context) => DisplayBloc(
          activityRepo: ActivityRepo(),
        ),
        child: BlocBuilder<DisplayBloc, DisplayState>(
            bloc: _displayBloc,
            builder: (context, state) {
              if (state is DisplayOnFailure) {
                return Center(
                  child: LoadDataError(
                    subtitle: state.error,
                  ),
                );
              }
              if (state is DisplayDataLoaded) {
                if (state.dataList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                    ),
                  );
                }
                return bodyDisplay(state.dataList);
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => NewActivity());
        },
        backgroundColor: HexColor('#001689'),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }

  // group(List<DispayActivity> data) {
  //   final dataSet = data;
  //   print('data set :: ${dataSet[0].when}');
  //   var groupByDate = groupBy(dataSet, (obj) => obj['when'].substring(0, 10));
  //   groupByDate.forEach((date, list) {
  //     // Header
  //     print('${date}:');

  //     // Group
  //     list.forEach((listItem) {
  //       // List item
  //       print('${listItem.when}, ${listItem.remarks}');
  //     });
  //     // day section divider
  //     print('\n');
  //   });
  // }

  Widget bodyDisplay(List<DispayActivity> data) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: GroupedListView<dynamic, String>(
        elements: data,
        groupBy: (element) => element.when,
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1.activityType.compareTo(item2.activityType),
        order: GroupedListOrder.DESC,
        // useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hbox(10),
              Text(
                DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(value)),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        itemBuilder: (c, element) {
          return InkWell(
            onTap: () {
              Get.to(() => InfoActivity(
                    id: element.id,
                  ));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Card(
                elevation: 0,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('HH:mm')
                              .format(DateTime.parse(element.when)),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        wbox(10),
                        Flexible(
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: HexColor('#747EAF'),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    element.remarks,
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  hbox(10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    hbox(4),
                    Divider(
                      color: HexColor('#E2E2E2'),
                      thickness: 1.5,
                    ),
                    hbox(4),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget appbarDisplay() {
    return AppBar(
      backgroundColor: HexColor('#001689'),
      title: Center(
        child: Text(
          'Activities',
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottom: PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(bottom: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bAppBar(
                () {
                  print('press open activities');
                },
                Colors.white,
                Colors.white,
                0,
                'Open',
                Colors.black,
              ),
              bAppBar(
                () {
                  print('press complete activities');
                },
                Colors.transparent,
                Colors.white54,
                1,
                'Complete',
                Colors.white54,
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(50),
      ),
    );
  }
}
