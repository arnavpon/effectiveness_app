import 'package:drift/drift.dart';

@DataClassName("TagEntry")
class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class Tag {
  final String name;

  Tag(this.name);
}
