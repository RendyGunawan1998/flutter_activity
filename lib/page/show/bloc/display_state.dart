part of 'display_bloc.dart';

abstract class DisplayState extends Equatable {
  const DisplayState();

  @override
  List<Object> get props => [];
}

class DisplayLoading extends DisplayState {}

// #================DIFFERENT==============#
// #================ERROR==============#

class DisplayOnFailure extends DisplayState {
  final String error;

  DisplayOnFailure(this.error);
  @override
  List<Object> get props => [error];

  // final ErrorModel dataError;

  // const DisplayOnFailure({this.dataError});

  // @override
  // List<Object> get props => [dataError];

  // @override
  // String toString() => 'DisplayOnFailure { items: ${dataError.message} }';
}

// #================DIFFERENT==============#
// #================LOAD SUCCESS==============#

class DisplayDataLoaded extends DisplayState {
  final List<DispayActivity> dataList;

  const DisplayDataLoaded({@required this.dataList});

  @override
  List<Object> get props => [dataList];
}

class InfoDataLoaded extends DisplayState {
  final DispayActivity dataList;

  const InfoDataLoaded({@required this.dataList});

  @override
  List<Object> get props => [dataList];
}
