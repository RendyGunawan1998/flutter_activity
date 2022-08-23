// ignore_for_file: prefer_const_constructors_in_immutables

part of 'create_bloc.dart';

abstract class CreateState extends Equatable {
  const CreateState();

  @override
  List<Object> get props => [];
}

class CreateLoading extends CreateState {}

// #================DIFFERENT==============#
// #================ERROR==============#

class CreateOnFailure extends CreateState {
  final String error;

  CreateOnFailure(this.error);
  @override
  List<Object> get props => [error];
}

// #================DIFFERENT==============#
// #================LOAD SUCCESS==============#

class CreateDataLoaded extends CreateState {}

class EditDataSukses extends CreateState {
  final DispayActivity dataList;

  const EditDataSukses({@required this.dataList});

  @override
  List<Object> get props => [dataList];
}

class EditOnFailure extends CreateState {
  final int error;

  EditOnFailure(this.error);
  @override
  List<Object> get props => [error];
}
