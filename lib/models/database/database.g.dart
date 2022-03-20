// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ActivityEntry extends DataClass implements Insertable<ActivityEntry> {
  final int id;
  final Status status;
  final String title;
  final int? value;
  final double? correctedUrgency;
  ActivityEntry(
      {required this.id,
      required this.status,
      required this.title,
      this.value,
      this.correctedUrgency});
  factory ActivityEntry.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ActivityEntry(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      status: $ActivitiesTableTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status']))!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      value: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value']),
      correctedUrgency: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}corrected_urgency']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      final converter = $ActivitiesTableTable.$converter0;
      map['status'] = Variable<int>(converter.mapToSql(status)!);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<int?>(value);
    }
    if (!nullToAbsent || correctedUrgency != null) {
      map['corrected_urgency'] = Variable<double?>(correctedUrgency);
    }
    return map;
  }

  ActivitiesTableCompanion toCompanion(bool nullToAbsent) {
    return ActivitiesTableCompanion(
      id: Value(id),
      status: Value(status),
      title: Value(title),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      correctedUrgency: correctedUrgency == null && nullToAbsent
          ? const Value.absent()
          : Value(correctedUrgency),
    );
  }

  factory ActivityEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityEntry(
      id: serializer.fromJson<int>(json['id']),
      status: serializer.fromJson<Status>(json['status']),
      title: serializer.fromJson<String>(json['title']),
      value: serializer.fromJson<int?>(json['value']),
      correctedUrgency: serializer.fromJson<double?>(json['correctedUrgency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'status': serializer.toJson<Status>(status),
      'title': serializer.toJson<String>(title),
      'value': serializer.toJson<int?>(value),
      'correctedUrgency': serializer.toJson<double?>(correctedUrgency),
    };
  }

  ActivityEntry copyWith(
          {int? id,
          Status? status,
          String? title,
          int? value,
          double? correctedUrgency}) =>
      ActivityEntry(
        id: id ?? this.id,
        status: status ?? this.status,
        title: title ?? this.title,
        value: value ?? this.value,
        correctedUrgency: correctedUrgency ?? this.correctedUrgency,
      );
  @override
  String toString() {
    return (StringBuffer('ActivityEntry(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('title: $title, ')
          ..write('value: $value, ')
          ..write('correctedUrgency: $correctedUrgency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, status, title, value, correctedUrgency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityEntry &&
          other.id == this.id &&
          other.status == this.status &&
          other.title == this.title &&
          other.value == this.value &&
          other.correctedUrgency == this.correctedUrgency);
}

class ActivitiesTableCompanion extends UpdateCompanion<ActivityEntry> {
  final Value<int> id;
  final Value<Status> status;
  final Value<String> title;
  final Value<int?> value;
  final Value<double?> correctedUrgency;
  const ActivitiesTableCompanion({
    this.id = const Value.absent(),
    this.status = const Value.absent(),
    this.title = const Value.absent(),
    this.value = const Value.absent(),
    this.correctedUrgency = const Value.absent(),
  });
  ActivitiesTableCompanion.insert({
    this.id = const Value.absent(),
    required Status status,
    required String title,
    this.value = const Value.absent(),
    this.correctedUrgency = const Value.absent(),
  })  : status = Value(status),
        title = Value(title);
  static Insertable<ActivityEntry> custom({
    Expression<int>? id,
    Expression<Status>? status,
    Expression<String>? title,
    Expression<int?>? value,
    Expression<double?>? correctedUrgency,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (title != null) 'title': title,
      if (value != null) 'value': value,
      if (correctedUrgency != null) 'corrected_urgency': correctedUrgency,
    });
  }

  ActivitiesTableCompanion copyWith(
      {Value<int>? id,
      Value<Status>? status,
      Value<String>? title,
      Value<int?>? value,
      Value<double?>? correctedUrgency}) {
    return ActivitiesTableCompanion(
      id: id ?? this.id,
      status: status ?? this.status,
      title: title ?? this.title,
      value: value ?? this.value,
      correctedUrgency: correctedUrgency ?? this.correctedUrgency,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (status.present) {
      final converter = $ActivitiesTableTable.$converter0;
      map['status'] = Variable<int>(converter.mapToSql(status.value)!);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (value.present) {
      map['value'] = Variable<int?>(value.value);
    }
    if (correctedUrgency.present) {
      map['corrected_urgency'] = Variable<double?>(correctedUrgency.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitiesTableCompanion(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('title: $title, ')
          ..write('value: $value, ')
          ..write('correctedUrgency: $correctedUrgency')
          ..write(')'))
        .toString();
  }
}

class $ActivitiesTableTable extends ActivitiesTable
    with TableInfo<$ActivitiesTableTable, ActivityEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitiesTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<Status, int?> status =
      GeneratedColumn<int?>('status', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<Status>($ActivitiesTableTable.$converter0);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int?> value = GeneratedColumn<int?>(
      'value', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _correctedUrgencyMeta =
      const VerificationMeta('correctedUrgency');
  @override
  late final GeneratedColumn<double?> correctedUrgency =
      GeneratedColumn<double?>('corrected_urgency', aliasedName, true,
          type: const RealType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, status, title, value, correctedUrgency];
  @override
  String get aliasedName => _alias ?? 'activities_table';
  @override
  String get actualTableName => 'activities_table';
  @override
  VerificationContext validateIntegrity(Insertable<ActivityEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('corrected_urgency')) {
      context.handle(
          _correctedUrgencyMeta,
          correctedUrgency.isAcceptableOrUnknown(
              data['corrected_urgency']!, _correctedUrgencyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ActivityEntry.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ActivitiesTableTable createAlias(String alias) {
    return $ActivitiesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Status, int> $converter0 =
      const EnumIndexConverter<Status>(Status.values);
}

class TagEntry extends DataClass implements Insertable<TagEntry> {
  final int id;
  final String name;
  TagEntry({required this.id, required this.name});
  factory TagEntry.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TagEntry(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory TagEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagEntry(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  TagEntry copyWith({int? id, String? name}) => TagEntry(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('TagEntry(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagEntry && other.id == this.id && other.name == this.name);
}

class TagsCompanion extends UpdateCompanion<TagEntry> {
  final Value<int> id;
  final Value<String> name;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<TagEntry> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TagsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, TagEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'tags';
  @override
  String get actualTableName => 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<TagEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TagEntry.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ActivitiesTableTable activitiesTable =
      $ActivitiesTableTable(this);
  late final $TagsTable tags = $TagsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [activitiesTable, tags];
}
