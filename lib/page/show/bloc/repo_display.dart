part of 'display_bloc.dart';

class ActivityRepo {
  Future<List<DispayActivity>> fetchActivity({int status}) async {
    var _url = LIST_ACTIVITY_URL + '?status=$status';
    print("[DISPLAY] FETCH ACTIVITY URL, GET: $_url");
    // #=====================================================================#

    var client = http.Client();

    final response = await client.get(
      Uri.parse(_url),
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
    print('S.CODE DISPLAY ACTIVITY :: ${response.statusCode}');

    if (response.statusCode < 200 || response.statusCode > 204) {
      print("S.CODE DISPLAY != 200");
      throw ErrorModel.fromJson(json.decode(response.body));
    }
    final res = json.decode(response.body);
    print('res body :: ${response.body}');
    print('res :: $res');
    final data = res['activities'] as List;
    return data.map((data) => DispayActivity.fromJson(data)).toList();
  }

  Future<DispayActivity> fetchActivityByID({int id}) async {
    var _url = LIST_ACTIVITY_URL + '/$id';
    print("[INFO] FETCH ACTIVITY BY ID URL, GET: $_url");
    // #=====================================================================#

    var client = http.Client();

    final response = await client.get(
      Uri.parse(_url),
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
    print('S.CODE INFO ACTIVITY :: ${response.statusCode}');

    if (response.statusCode < 200 || response.statusCode > 204) {
      print("S.CODE INFO != 200");
      throw ErrorModel.fromJson(json.decode(response.body));
    }
    final res = json.decode(response.body);
    final data = res;
    return DispayActivity.fromJson(data);
  }
}
