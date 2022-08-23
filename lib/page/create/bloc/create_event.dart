part of 'create_bloc.dart';

abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

class ActivityPost extends CreateEvent {
  final String activityType, institution, when, objective, remark;
  final int status;

  // ignore: prefer_const_constructors_in_immutables
  ActivityPost(
      {@required this.activityType,
      this.institution,
      this.when,
      this.objective,
      this.remark,
      this.status});
  @override
  String toString() => 'Post Activity Event';
}

class ActivityEdit extends CreateEvent {
  final String activityType, institution, when, objective, remark;
  final int status, id;

  // ignore: prefer_const_constructors_in_immutables
  ActivityEdit({
    @required this.activityType,
    this.institution,
    this.when,
    this.objective,
    this.remark,
    this.status,
    this.id,
  });
  @override
  String toString() => 'Edit Activity Event';
}
