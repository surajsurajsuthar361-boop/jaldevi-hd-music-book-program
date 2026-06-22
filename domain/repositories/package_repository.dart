import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';

abstract class PackageRepository {
  Future<List<Package>> getPackages();
  Future<Package> getPackageById(String id);
}
