import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:effectivess_app/models/activity.dart';
import 'package:effectivess_app/models/status.dart';
import 'package:effectivess_app/models/time_segment.dart';
import 'package:effectivess_app/models/tags.dart';

part 'database.g.dart';

@DriftDatabase(tables: [ActivitiesTable, Tags])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // MARK: - Activities Logic

  Future<List<ActivityEntry>> get allActivityEntries =>
      select(activitiesTable).get();

  Future<List<ActivityEntry>> findActivitiesForTimeSegment(
      TimeSegment segment) async {
    return <ActivityEntry>[];
  }

  // MARK:: - Tags Logic

  // Future<List<Tag>> get allTagEntries => select(tags).get();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
