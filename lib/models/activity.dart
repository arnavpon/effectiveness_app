import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:provider/provider.dart';

import 'package:effectivess_app/models/database/mongo_handler.dart';
import 'package:effectivess_app/models/status.dart';
import 'package:effectivess_app/models/tags.dart';
import 'package:effectivess_app/models/time_segment.dart';

@DataClassName("ActivityEntry")
class ActivitiesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get status => intEnum<Status>()(); // auto-maps from status enum
  TextColumn get title => text()();
  IntColumn get value => integer().nullable()();
  RealColumn get correctedUrgency => real().nullable()();
}

class Activity {
  // don't use this class directly w/ db b/c there's no id at time of initialization***

  static const String activityDbCollection = "activity_collection";

  String title;
  Status status = Status.active;
  List<Activity> children = [];
  List<TimeSegment> timeSegments =
      []; // need to be able to query time segments, so don't serialize, but don't want to store segments in the db. Essentially, we need to know what activities have been done within a given time segment, which means checking against this list.
  List<Tag> tags = [];
  int value = 0;
  double correctedUrgency = 0;

  Activity({required this.title});

  String getReadableStatus() {
    switch (status) {
      case Status.completed:
        return "Completed";
      case Status.awaiting:
        return "Awaiting";
      case Status.active:
        return "Active";
    }
  }

  // MARK: - CRUD Methods

  Future<DbCollection> getCollection(BuildContext context) async {
    var dbHandler = Provider.of<MongoHandler>(context, listen: false);
    await dbHandler.dbConnection!.open();
    return dbHandler.dbConnection!.collection(activityDbCollection);
  }

  Future insertDbo(BuildContext context) async {
    var collection = await getCollection(context);
    var success = await collection.insertOne({
      "title": title,
      "status": status.index,
      "tags": tags.map((tag) => tag.name).toList(),
    });
    log("[Insert] Success? ${success.isSuccess}");
  }

  Future fetchDbo(BuildContext context) async {
    // *** remove fetch from within class, should be on handler
    var collection = await getCollection(context);
    var results = collection.find().take(10);
    var r = await results.take(10).toList();
    for (var result in r) {
      log("[Fetch] ${result.toString()}");
    }
  }

  Future updateDbo() async {}
  Future deleteDbo() async {}
}
