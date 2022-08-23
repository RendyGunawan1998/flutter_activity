part of 'create_bloc.dart';

class PostRepo {
  // ignore: missing_return
  Future<DispayActivity> postActivities(
      {String activityType,
      String institution,
      String when,
      String objective,
      String remarks,
      int status}) async {
    var _url = POST_ACTIVITY_URL;
    print("[POST REPO], POST: $_url");
    var _body = {
      "activityType": activityType,
      "institution": institution,
      "when": when,
      "objective": objective,
      "remarks": remarks,
      "status": status,
    };
    print('body post :: $_body');
    // #=====================================================================#

    var client = http.Client();

    final response = await client.post(
      Uri.parse(_url),
      body: json.encode(_body),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ).timeout(
      Duration(seconds: 30),
      onTimeout: () {
        throw ErrorModel.fromJson(
            {"status": 408, "message": "Jaringan Koneksi Bermasalah"});
      },
    );

    client.close();
    print('S.CODE POST :: ${response.statusCode}');

    if (response.statusCode < 200 || response.statusCode > 204) {
      Get.snackbar('Alert', 'Ada masalah pada sistem');
      // throw ErrorModel.fromJson(json.decode(response.body));
    }
    print('post 200');
    Get.snackbar('Sukses', 'Data berhasil ditambahkan',
        backgroundColor: Colors.white);
    Get.offAll(() => TabBarPage());
    return DispayActivity.fromJson(json.decode(response.body));
  }

  // ignore: missing_return
  Future<DispayActivity> editAct(
      {String activityType,
      String institution,
      String when,
      String objective,
      String remarks,
      int status,
      int id}) async {
    var _url = EDIT_ACTIVITY_URL + '/$id';
    print("[EDIT REPO], URL: $_url");
    var _body = {
      "activityType": activityType,
      "institution": institution,
      "when": when,
      "objective": objective,
      "remarks": remarks,
      "status": status,
    };
    print('body edit :: $_body');
    // #=====================================================================#

    var client = http.Client();

    final response = await client.put(
      Uri.parse(_url),
      body: json.encode(_body),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ).timeout(
      Duration(seconds: 30),
      onTimeout: () {
        throw ErrorModel.fromJson(
            {"status": 408, "message": "Jaringan Koneksi Bermasalah"});
      },
    );

    client.close();
    print('S.CODE EDIT :: ${response.statusCode}');
    print('RES BODY EDIT :: ${response.body}');

    if (response.statusCode == 200) {
      print('edit 200');
      Get.snackbar('Sukses', 'Data berhasil diubah',
          backgroundColor: Colors.white);
      Get.offAll(() => TabBarPage());
      return DispayActivity.fromJson(json.decode(response.body));
    } else {
      Get.snackbar('Alert', 'Ada masalah pada sistem');
    }
  }
}
