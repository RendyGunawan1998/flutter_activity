import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pretestflutter/extra/core.dart';
import 'package:pretestflutter/page/create/bloc/create_bloc.dart';

class NewActivity extends StatefulWidget {
  const NewActivity({Key key}) : super(key: key);

  @override
  _NewActivityState createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  List<Map<String, dynamic>> todo = [
    {"display": "Meeting", "value": "Meeting"},
    {"display": "Calling", "value": "Calling"},
  ];

  List<Map<String, dynamic>> want = [
    {"display": "New Order", "value": "New Order"},
    {"display": "Invoice", "value": "Invoice"},
    {"display": "New Leads", "value": "New Leads"},
  ];

  final CreateBloc _createBloc = CreateBloc(postRepo: PostRepo());

  String todoChoose;
  String wantChoose;
  final formKey = GlobalKey<FormState>();
  TextEditingController tujuan = TextEditingController();
  TextEditingController waktu = TextEditingController();
  TextEditingController desc = TextEditingController();
  int status = 0;
  String tWaktu = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarNA(),
      body: BlocProvider(
        create: (context) => CreateBloc(postRepo: PostRepo()),
        child: BlocBuilder<CreateBloc, CreateState>(
            bloc: _createBloc,
            builder: (context, state) {
              if (state is CreateOnFailure) {
                return Center(
                  child: Text(state.error),
                );
              }
              if (state is DisplayDataLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Data berhasil ditambahkan'),
                    TextButton(
                        onPressed: () {
                          Get.offAll(() => TabBarPage());
                        },
                        child: Text('Go To Home')),
                  ],
                );
              }
              return bodyNA(context);
            }),
      ),
    );
  }

  Widget bodyNA(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 7),
          child: columnBody(context),
        ),
      ),
    );
  }

  Widget buttonSubmit() {
    return InkWell(
      child: Container(
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
            'Submit',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      onTap: () {
        if (todoChoose != null &&
            tujuan.text != null &&
            waktu.text != null &&
            wantChoose != null &&
            desc.text != null) {
          print('validation post sukses');
          print('todoChoose, what /activity type:: $todoChoose');
          print('institution/ Who:: ${tujuan.text}');
          print('when :: $tWaktu');
          print('wantChoose (objective) // why :: $wantChoose');
          print('remark / could desc :: ${desc.text}');
          print('status :: $status');
          _createBloc.add(
            ActivityPost(
              activityType: todoChoose,
              institution: tujuan.text,
              objective: wantChoose,
              remark: desc.text,
              status: status,
              when: tWaktu,
            ),
          );
        } else {
          Get.snackbar('Alert',
              'Masih ada field kosong, harap isi terlebih dahulu sebelum submit',
              backgroundColor: Colors.white, colorText: Colors.black);
        }
      },
    );
  }

  Widget columnBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hbox(10),
        judulTeks('What do you want to do ?'),
        containerSomething(
          Padding(
            padding: EdgeInsets.fromLTRB(12, 10, 5, 0),
            child: DropdownButtonFormField(
              validator: (value) =>
                  value == null ? 'Field tidak boleh kosong' : null,
              decoration:
                  InputDecoration.collapsed(hintText: 'Meeting or Calling'),
              dropdownColor: Colors.grey[300],
              isExpanded: true,
              value: todoChoose,
              items: todo.map((item) {
                return DropdownMenuItem(
                  child: Text(item['display']),
                  value: item['value'],
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  todoChoose = value;
                  print("VALUE TODO :: $todoChoose");
                });
              },
            ),
          ),
        ),
        hbox(15),
        judulTeks('Who do you want to meet/call ?'),
        containerSomething(
          Padding(
            padding: EdgeInsets.fromLTRB(12, 15, 10, 5),
            child: TextFormField(
              validator: (value) => value == null || value.isEmpty
                  ? 'Field tidak boleh kosong'
                  : null,
              controller: tujuan,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'CV Anugrah Jaya',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        hbox(15),
        judulTeks('When do you want to meet/call ${tujuan.text ?? ''} ?'),
        containerSomething(
          Padding(
            padding: EdgeInsets.fromLTRB(12, 15, 10, 5),
            child: TextFormField(
              controller: waktu,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'dd-MM-yyyy HH:mm',
                suffixIcon: InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      dateFormat: 'dd MMMM yyyy HH:mm',
                      initialDateTime: DateTime.now(),
                      minDateTime: DateTime(2000),
                      maxDateTime: DateTime(3000),
                      onMonthChangeStartWithFirstDate: true,
                      onConfirm: (dateTime, List<int> index) {
                        DateTime selectdate = dateTime;
                        var selIOS =
                            DateFormat('dd-MM-yyyy - HH:mm').format(selectdate);
                        var parsed = DateFormat('yyyy-MM-dd HH:mm:ss')
                            .format(selectdate);
                        setState(() {
                          waktu.text = selIOS;
                          tWaktu = parsed;
                          print('WAKTU :: ${waktu.text}');
                          print('Parsed :: $tWaktu');
                        });
                      },
                    );
                  },
                  child: Icon(
                    Icons.edit_calendar_sharp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
        hbox(15),
        judulTeks('Why do you want to meet/call ${tujuan.text ?? ''} ?'),
        containerSomething(
          Padding(
            padding: EdgeInsets.fromLTRB(12, 10, 5, 0),
            child: DropdownButtonFormField(
              validator: (value) =>
                  value == null ? 'Field tidak boleh kosong' : null,
              dropdownColor: Colors.grey[300],
              decoration: InputDecoration.collapsed(
                  hintText: 'New Order, invoice, New Leads'),
              isExpanded: true,
              // hint: Text('New Order, invoice, New Leads'),
              value: wantChoose,
              items: want.map((item) {
                return DropdownMenuItem(
                  child: Text(item['display']),
                  value: item['value'],
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  wantChoose = value;
                  print("VALUE WANT :: $wantChoose");
                });
              },
            ),
          ),
        ),
        hbox(15),
        judulTeks('Could you describe it more details ?'),
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
            padding: EdgeInsets.fromLTRB(12, 0, 10, 5),
            child: TextFormField(
              validator: (value) => value == null || value.isEmpty
                  ? 'Field tidak boleh kosong'
                  : null,
              maxLines: 4,
              controller: desc,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Placeholder',
              ),
            ),
          ),
        ),
        hbox(15),
        buttonSubmit()
      ],
    );
  }

  Widget containerSomething(Widget anak) {
    return Container(
        height: 50,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
        ),
        child: anak);
  }

  Widget judulTeks(String isi) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 6),
      child: Text(
        isi,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget appbarNA() {
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
              'New Activity',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
