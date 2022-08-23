import 'package:get/get.dart';
import 'package:pretestflutter/extra/core.dart';

Widget hbox(double h) {
  return SizedBox(
    height: h,
  );
}

Widget wbox(double w) {
  return SizedBox(
    width: w,
  );
}

Widget bAppBar(Function() func, Color wrnaBGBorder, Color wrnaBorder, double w,
    String isi, Color wrnaIsi) {
  return InkWell(
    onTap: func,
    child: Container(
      height: 38,
      width: Get.width * 0.45,
      decoration: BoxDecoration(
        color: wrnaBGBorder,
        border: Border.all(color: wrnaBorder, width: w),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          isi,
          style: TextStyle(
            color: wrnaIsi,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
