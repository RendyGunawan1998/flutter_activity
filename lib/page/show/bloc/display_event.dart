part of 'display_bloc.dart';

abstract class DisplayEvent extends Equatable {
  const DisplayEvent();

  @override
  List<Object> get props => [];
}

class ActivityFetch extends DisplayEvent {
  final int status;

  // ignore: prefer_const_constructors_in_immutables
  ActivityFetch({@required this.status});
  @override
  String toString() => 'Fetch Activity Event';
}

class InfoFetch extends DisplayEvent {
  final int id;

  // ignore: prefer_const_constructors_in_immutables
  InfoFetch({@required this.id});
  @override
  String toString() => 'Fetch Info Event';
}
