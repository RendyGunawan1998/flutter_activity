import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:pretestflutter/extra/booms.dart';
import 'package:pretestflutter/model/error.dart';
import 'package:http/http.dart' as http;
import 'package:pretestflutter/page/edit/edit_activity.dart';

import '../../../extra/core.dart';

part 'create_event.dart';
part 'create_state.dart';
part 'repo_create.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  final PostRepo postRepo;

  CreateBloc({@required this.postRepo}) : super(null);

  @override
  Stream<CreateState> mapEventToState(CreateEvent event) async* {
    if (event is ActivityPost) {
      try {
        print("Create Activity");
        yield CreateLoading();
        await postRepo.postActivities(
            activityType: event.activityType,
            institution: event.institution,
            objective: event.objective,
            remarks: event.remark,
            status: event.status,
            when: event.when);
        yield CreateDataLoaded();
      } catch (error) {
        print("error post bloc : $error");
        yield CreateOnFailure(error);
      }
    } else if (event is ActivityEdit) {
      // try {
      print("Edit Activity");
      yield CreateLoading();
      final dataList = await postRepo.editAct(
          id: event.id,
          activityType: event.activityType,
          institution: event.institution,
          objective: event.objective,
          remarks: event.remark,
          status: event.status,
          when: event.when);
      print('await done');
      yield EditDataSukses(dataList: dataList);
      print('loaded done');
      // } catch (error) {
      //   print("error edit bloc : $error");
      //   yield EditOnFailure(error);
      // }
    }
  }
}
