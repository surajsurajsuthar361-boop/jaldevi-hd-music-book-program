
import 'package:equatable/equatable.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';

abstract class PackageState extends Equatable {
  const PackageState();

  @override
  List<Object> get props => [];
}

class PackageInitial extends PackageState {
  const PackageInitial();
}

class PackageLoading extends PackageState {
  const PackageLoading();
}

class PackageSuccess extends PackageState {
  final List<Package> packages;

  const PackageSuccess(this.packages);

  @override
  List<Object> get props => [packages];
}

class PackageError extends PackageState {
  final String message;

  const PackageError(this.message);

  @override
  List<Object> get props => [message];
}
