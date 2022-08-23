import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pretestflutter/extra/booms.dart';
import 'package:pretestflutter/model/display_model.dart';
import 'package:pretestflutter/model/error.dart';
import 'package:http/http.dart' as http;

part 'display_event.dart';
part 'display_state.dart';
part 'repo_display.dart';

class DisplayBloc extends Bloc<DisplayEvent, DisplayState> {
  final ActivityRepo activityRepo;

  DisplayBloc({@required this.activityRepo}) : super(null);

  @override
  Stream<DisplayState> mapEventToState(DisplayEvent event) async* {
    if (event is ActivityFetch) {
      // try {
      print("ACTIVITY FETCH");
      yield DisplayLoading();
      final dataList = await activityRepo.fetchActivity(status: event.status);
      yield DisplayDataLoaded(dataList: dataList);
      // } catch (error) {
      //   print("error fetch display bloc : $error");
      //   yield DisplayOnFailure(error);
      // }
    } else if (event is InfoFetch) {
      try {
        print("INFO FETCH");
        yield DisplayLoading();
        final dataList = await activityRepo.fetchActivityByID(id: event.id);
        yield InfoDataLoaded(dataList: dataList);
      } catch (error) {
        print("error fetch info bloc : $error");
        yield DisplayOnFailure(error);
      }
    }
  }
}
