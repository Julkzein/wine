// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CellarsTable extends Cellars with TableInfo<$CellarsTable, CellarRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CellarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<CellarType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CellarType>($CellarsTable.$convertertype);
  static const VerificationMeta _rowsMeta = const VerificationMeta('rows');
  @override
  late final GeneratedColumn<int> rows = GeneratedColumn<int>(
      'rows', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _columnsMeta =
      const VerificationMeta('columns');
  @override
  late final GeneratedColumn<int> columns = GeneratedColumn<int>(
      'columns', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
      'depth', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, rows, columns, depth, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cellars';
  @override
  VerificationContext validateIntegrity(Insertable<CellarRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('rows')) {
      context.handle(
          _rowsMeta, rows.isAcceptableOrUnknown(data['rows']!, _rowsMeta));
    } else if (isInserting) {
      context.missing(_rowsMeta);
    }
    if (data.containsKey('columns')) {
      context.handle(_columnsMeta,
          columns.isAcceptableOrUnknown(data['columns']!, _columnsMeta));
    } else if (isInserting) {
      context.missing(_columnsMeta);
    }
    if (data.containsKey('depth')) {
      context.handle(
          _depthMeta, depth.isAcceptableOrUnknown(data['depth']!, _depthMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CellarRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CellarRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: $CellarsTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      rows: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rows'])!,
      columns: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}columns'])!,
      depth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}depth'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CellarsTable createAlias(String alias) {
    return $CellarsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CellarType, String, String> $convertertype =
      const EnumNameConverter<CellarType>(CellarType.values);
}

class CellarRow extends DataClass implements Insertable<CellarRow> {
  final String id;
  final String name;
  final CellarType type;
  final int rows;
  final int columns;
  final int depth;
  final DateTime createdAt;
  const CellarRow(
      {required this.id,
      required this.name,
      required this.type,
      required this.rows,
      required this.columns,
      required this.depth,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>($CellarsTable.$convertertype.toSql(type));
    }
    map['rows'] = Variable<int>(rows);
    map['columns'] = Variable<int>(columns);
    map['depth'] = Variable<int>(depth);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CellarsCompanion toCompanion(bool nullToAbsent) {
    return CellarsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      rows: Value(rows),
      columns: Value(columns),
      depth: Value(depth),
      createdAt: Value(createdAt),
    );
  }

  factory CellarRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CellarRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: $CellarsTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      rows: serializer.fromJson<int>(json['rows']),
      columns: serializer.fromJson<int>(json['columns']),
      depth: serializer.fromJson<int>(json['depth']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type':
          serializer.toJson<String>($CellarsTable.$convertertype.toJson(type)),
      'rows': serializer.toJson<int>(rows),
      'columns': serializer.toJson<int>(columns),
      'depth': serializer.toJson<int>(depth),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CellarRow copyWith(
          {String? id,
          String? name,
          CellarType? type,
          int? rows,
          int? columns,
          int? depth,
          DateTime? createdAt}) =>
      CellarRow(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        rows: rows ?? this.rows,
        columns: columns ?? this.columns,
        depth: depth ?? this.depth,
        createdAt: createdAt ?? this.createdAt,
      );
  CellarRow copyWithCompanion(CellarsCompanion data) {
    return CellarRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      rows: data.rows.present ? data.rows.value : this.rows,
      columns: data.columns.present ? data.columns.value : this.columns,
      depth: data.depth.present ? data.depth.value : this.depth,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CellarRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('rows: $rows, ')
          ..write('columns: $columns, ')
          ..write('depth: $depth, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, rows, columns, depth, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CellarRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.rows == this.rows &&
          other.columns == this.columns &&
          other.depth == this.depth &&
          other.createdAt == this.createdAt);
}

class CellarsCompanion extends UpdateCompanion<CellarRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<CellarType> type;
  final Value<int> rows;
  final Value<int> columns;
  final Value<int> depth;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CellarsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.rows = const Value.absent(),
    this.columns = const Value.absent(),
    this.depth = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CellarsCompanion.insert({
    required String id,
    required String name,
    required CellarType type,
    required int rows,
    required int columns,
    this.depth = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        rows = Value(rows),
        columns = Value(columns),
        createdAt = Value(createdAt);
  static Insertable<CellarRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? rows,
    Expression<int>? columns,
    Expression<int>? depth,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (rows != null) 'rows': rows,
      if (columns != null) 'columns': columns,
      if (depth != null) 'depth': depth,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CellarsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<CellarType>? type,
      Value<int>? rows,
      Value<int>? columns,
      Value<int>? depth,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return CellarsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      rows: rows ?? this.rows,
      columns: columns ?? this.columns,
      depth: depth ?? this.depth,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($CellarsTable.$convertertype.toSql(type.value));
    }
    if (rows.present) {
      map['rows'] = Variable<int>(rows.value);
    }
    if (columns.present) {
      map['columns'] = Variable<int>(columns.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CellarsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('rows: $rows, ')
          ..write('columns: $columns, ')
          ..write('depth: $depth, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WinesTable extends Wines with TableInfo<$WinesTable, WineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vintageMeta =
      const VerificationMeta('vintage');
  @override
  late final GeneratedColumn<int> vintage = GeneratedColumn<int>(
      'vintage', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _labelImagePathMeta =
      const VerificationMeta('labelImagePath');
  @override
  late final GeneratedColumn<String> labelImagePath = GeneratedColumn<String>(
      'label_image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<WineType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<WineType>($WinesTable.$convertertype);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subRegionMeta =
      const VerificationMeta('subRegion');
  @override
  late final GeneratedColumn<String> subRegion = GeneratedColumn<String>(
      'sub_region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _appellationMeta =
      const VerificationMeta('appellation');
  @override
  late final GeneratedColumn<String> appellation = GeneratedColumn<String>(
      'appellation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _producerMeta =
      const VerificationMeta('producer');
  @override
  late final GeneratedColumn<String> producer = GeneratedColumn<String>(
      'producer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _winemakerMeta =
      const VerificationMeta('winemaker');
  @override
  late final GeneratedColumn<String> winemaker = GeneratedColumn<String>(
      'winemaker', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _alcoholContentMeta =
      const VerificationMeta('alcoholContent');
  @override
  late final GeneratedColumn<double> alcoholContent = GeneratedColumn<double>(
      'alcohol_content', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _bodyScoreMeta =
      const VerificationMeta('bodyScore');
  @override
  late final GeneratedColumn<int> bodyScore = GeneratedColumn<int>(
      'body_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _tanninLevelMeta =
      const VerificationMeta('tanninLevel');
  @override
  late final GeneratedColumn<int> tanninLevel = GeneratedColumn<int>(
      'tannin_level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _acidityLevelMeta =
      const VerificationMeta('acidityLevel');
  @override
  late final GeneratedColumn<int> acidityLevel = GeneratedColumn<int>(
      'acidity_level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sweetnessLevelMeta =
      const VerificationMeta('sweetnessLevel');
  @override
  late final GeneratedColumn<int> sweetnessLevel = GeneratedColumn<int>(
      'sweetness_level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _drinkFromMeta =
      const VerificationMeta('drinkFrom');
  @override
  late final GeneratedColumn<int> drinkFrom = GeneratedColumn<int>(
      'drink_from', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _drinkUntilMeta =
      const VerificationMeta('drinkUntil');
  @override
  late final GeneratedColumn<int> drinkUntil = GeneratedColumn<int>(
      'drink_until', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _peakFromMeta =
      const VerificationMeta('peakFrom');
  @override
  late final GeneratedColumn<int> peakFrom = GeneratedColumn<int>(
      'peak_from', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _peakUntilMeta =
      const VerificationMeta('peakUntil');
  @override
  late final GeneratedColumn<int> peakUntil = GeneratedColumn<int>(
      'peak_until', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<AgingPotential?, String>
      agingPotential = GeneratedColumn<String>(
              'aging_potential', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<AgingPotential?>(
              $WinesTable.$converteragingPotentialn);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _purchaseDateMeta =
      const VerificationMeta('purchaseDate');
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
      'purchase_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _purchasePriceMeta =
      const VerificationMeta('purchasePrice');
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
      'purchase_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _purchaseLocationMeta =
      const VerificationMeta('purchaseLocation');
  @override
  late final GeneratedColumn<String> purchaseLocation = GeneratedColumn<String>(
      'purchase_location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cellarIdMeta =
      const VerificationMeta('cellarId');
  @override
  late final GeneratedColumn<String> cellarId = GeneratedColumn<String>(
      'cellar_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES cellars (id) ON DELETE SET NULL'));
  static const VerificationMeta _rackRowMeta =
      const VerificationMeta('rackRow');
  @override
  late final GeneratedColumn<int> rackRow = GeneratedColumn<int>(
      'rack_row', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _rackColumnMeta =
      const VerificationMeta('rackColumn');
  @override
  late final GeneratedColumn<int> rackColumn = GeneratedColumn<int>(
      'rack_column', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _rackDepthMeta =
      const VerificationMeta('rackDepth');
  @override
  late final GeneratedColumn<int> rackDepth = GeneratedColumn<int>(
      'rack_depth', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userRatingMeta =
      const VerificationMeta('userRating');
  @override
  late final GeneratedColumn<double> userRating = GeneratedColumn<double>(
      'user_rating', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tastingNotesMeta =
      const VerificationMeta('tastingNotes');
  @override
  late final GeneratedColumn<String> tastingNotes = GeneratedColumn<String>(
      'tasting_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _personalNotesMeta =
      const VerificationMeta('personalNotes');
  @override
  late final GeneratedColumn<String> personalNotes = GeneratedColumn<String>(
      'personal_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _foodPairingsMeta =
      const VerificationMeta('foodPairings');
  @override
  late final GeneratedColumn<String> foodPairings = GeneratedColumn<String>(
      'food_pairings', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<WineSource, String> source =
      GeneratedColumn<String>('source', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<WineSource>($WinesTable.$convertersource);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        vintage,
        labelImagePath,
        type,
        country,
        region,
        subRegion,
        appellation,
        producer,
        winemaker,
        alcoholContent,
        bodyScore,
        tanninLevel,
        acidityLevel,
        sweetnessLevel,
        drinkFrom,
        drinkUntil,
        peakFrom,
        peakUntil,
        agingPotential,
        quantity,
        purchaseDate,
        purchasePrice,
        purchaseLocation,
        cellarId,
        rackRow,
        rackColumn,
        rackDepth,
        userRating,
        tastingNotes,
        personalNotes,
        tags,
        foodPairings,
        isFavorite,
        createdAt,
        updatedAt,
        source
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wines';
  @override
  VerificationContext validateIntegrity(Insertable<WineRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('vintage')) {
      context.handle(_vintageMeta,
          vintage.isAcceptableOrUnknown(data['vintage']!, _vintageMeta));
    }
    if (data.containsKey('label_image_path')) {
      context.handle(
          _labelImagePathMeta,
          labelImagePath.isAcceptableOrUnknown(
              data['label_image_path']!, _labelImagePathMeta));
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    }
    if (data.containsKey('sub_region')) {
      context.handle(_subRegionMeta,
          subRegion.isAcceptableOrUnknown(data['sub_region']!, _subRegionMeta));
    }
    if (data.containsKey('appellation')) {
      context.handle(
          _appellationMeta,
          appellation.isAcceptableOrUnknown(
              data['appellation']!, _appellationMeta));
    }
    if (data.containsKey('producer')) {
      context.handle(_producerMeta,
          producer.isAcceptableOrUnknown(data['producer']!, _producerMeta));
    }
    if (data.containsKey('winemaker')) {
      context.handle(_winemakerMeta,
          winemaker.isAcceptableOrUnknown(data['winemaker']!, _winemakerMeta));
    }
    if (data.containsKey('alcohol_content')) {
      context.handle(
          _alcoholContentMeta,
          alcoholContent.isAcceptableOrUnknown(
              data['alcohol_content']!, _alcoholContentMeta));
    }
    if (data.containsKey('body_score')) {
      context.handle(_bodyScoreMeta,
          bodyScore.isAcceptableOrUnknown(data['body_score']!, _bodyScoreMeta));
    }
    if (data.containsKey('tannin_level')) {
      context.handle(
          _tanninLevelMeta,
          tanninLevel.isAcceptableOrUnknown(
              data['tannin_level']!, _tanninLevelMeta));
    }
    if (data.containsKey('acidity_level')) {
      context.handle(
          _acidityLevelMeta,
          acidityLevel.isAcceptableOrUnknown(
              data['acidity_level']!, _acidityLevelMeta));
    }
    if (data.containsKey('sweetness_level')) {
      context.handle(
          _sweetnessLevelMeta,
          sweetnessLevel.isAcceptableOrUnknown(
              data['sweetness_level']!, _sweetnessLevelMeta));
    }
    if (data.containsKey('drink_from')) {
      context.handle(_drinkFromMeta,
          drinkFrom.isAcceptableOrUnknown(data['drink_from']!, _drinkFromMeta));
    }
    if (data.containsKey('drink_until')) {
      context.handle(
          _drinkUntilMeta,
          drinkUntil.isAcceptableOrUnknown(
              data['drink_until']!, _drinkUntilMeta));
    }
    if (data.containsKey('peak_from')) {
      context.handle(_peakFromMeta,
          peakFrom.isAcceptableOrUnknown(data['peak_from']!, _peakFromMeta));
    }
    if (data.containsKey('peak_until')) {
      context.handle(_peakUntilMeta,
          peakUntil.isAcceptableOrUnknown(data['peak_until']!, _peakUntilMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
          _purchaseDateMeta,
          purchaseDate.isAcceptableOrUnknown(
              data['purchase_date']!, _purchaseDateMeta));
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
          _purchasePriceMeta,
          purchasePrice.isAcceptableOrUnknown(
              data['purchase_price']!, _purchasePriceMeta));
    }
    if (data.containsKey('purchase_location')) {
      context.handle(
          _purchaseLocationMeta,
          purchaseLocation.isAcceptableOrUnknown(
              data['purchase_location']!, _purchaseLocationMeta));
    }
    if (data.containsKey('cellar_id')) {
      context.handle(_cellarIdMeta,
          cellarId.isAcceptableOrUnknown(data['cellar_id']!, _cellarIdMeta));
    }
    if (data.containsKey('rack_row')) {
      context.handle(_rackRowMeta,
          rackRow.isAcceptableOrUnknown(data['rack_row']!, _rackRowMeta));
    }
    if (data.containsKey('rack_column')) {
      context.handle(
          _rackColumnMeta,
          rackColumn.isAcceptableOrUnknown(
              data['rack_column']!, _rackColumnMeta));
    }
    if (data.containsKey('rack_depth')) {
      context.handle(_rackDepthMeta,
          rackDepth.isAcceptableOrUnknown(data['rack_depth']!, _rackDepthMeta));
    }
    if (data.containsKey('user_rating')) {
      context.handle(
          _userRatingMeta,
          userRating.isAcceptableOrUnknown(
              data['user_rating']!, _userRatingMeta));
    }
    if (data.containsKey('tasting_notes')) {
      context.handle(
          _tastingNotesMeta,
          tastingNotes.isAcceptableOrUnknown(
              data['tasting_notes']!, _tastingNotesMeta));
    }
    if (data.containsKey('personal_notes')) {
      context.handle(
          _personalNotesMeta,
          personalNotes.isAcceptableOrUnknown(
              data['personal_notes']!, _personalNotesMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('food_pairings')) {
      context.handle(
          _foodPairingsMeta,
          foodPairings.isAcceptableOrUnknown(
              data['food_pairings']!, _foodPairingsMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WineRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      vintage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vintage']),
      labelImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}label_image_path']),
      type: $WinesTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country']),
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region']),
      subRegion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sub_region']),
      appellation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}appellation']),
      producer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}producer']),
      winemaker: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}winemaker']),
      alcoholContent: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}alcohol_content']),
      bodyScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}body_score']),
      tanninLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tannin_level']),
      acidityLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}acidity_level']),
      sweetnessLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sweetness_level']),
      drinkFrom: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}drink_from']),
      drinkUntil: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}drink_until']),
      peakFrom: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}peak_from']),
      peakUntil: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}peak_until']),
      agingPotential: $WinesTable.$converteragingPotentialn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}aging_potential'])),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      purchaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}purchase_date']),
      purchasePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}purchase_price']),
      purchaseLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}purchase_location']),
      cellarId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cellar_id']),
      rackRow: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rack_row']),
      rackColumn: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rack_column']),
      rackDepth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rack_depth']),
      userRating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}user_rating']),
      tastingNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tasting_notes']),
      personalNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}personal_notes']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      foodPairings: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_pairings'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      source: $WinesTable.$convertersource.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!),
    );
  }

  @override
  $WinesTable createAlias(String alias) {
    return $WinesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WineType, String, String> $convertertype =
      const EnumNameConverter<WineType>(WineType.values);
  static JsonTypeConverter2<AgingPotential, String, String>
      $converteragingPotential =
      const EnumNameConverter<AgingPotential>(AgingPotential.values);
  static JsonTypeConverter2<AgingPotential?, String?, String?>
      $converteragingPotentialn =
      JsonTypeConverter2.asNullable($converteragingPotential);
  static JsonTypeConverter2<WineSource, String, String> $convertersource =
      const EnumNameConverter<WineSource>(WineSource.values);
}

class WineRow extends DataClass implements Insertable<WineRow> {
  final String id;
  final String name;
  final int? vintage;
  final String? labelImagePath;
  final WineType type;
  final String? country;
  final String? region;
  final String? subRegion;
  final String? appellation;
  final String? producer;
  final String? winemaker;
  final double? alcoholContent;
  final int? bodyScore;
  final int? tanninLevel;
  final int? acidityLevel;
  final int? sweetnessLevel;
  final int? drinkFrom;
  final int? drinkUntil;
  final int? peakFrom;
  final int? peakUntil;
  final AgingPotential? agingPotential;
  final int quantity;
  final DateTime? purchaseDate;
  final double? purchasePrice;
  final String? purchaseLocation;
  final String? cellarId;
  final int? rackRow;
  final int? rackColumn;
  final int? rackDepth;
  final double? userRating;
  final String? tastingNotes;
  final String? personalNotes;
  final String tags;
  final String foodPairings;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
  final WineSource source;
  const WineRow(
      {required this.id,
      required this.name,
      this.vintage,
      this.labelImagePath,
      required this.type,
      this.country,
      this.region,
      this.subRegion,
      this.appellation,
      this.producer,
      this.winemaker,
      this.alcoholContent,
      this.bodyScore,
      this.tanninLevel,
      this.acidityLevel,
      this.sweetnessLevel,
      this.drinkFrom,
      this.drinkUntil,
      this.peakFrom,
      this.peakUntil,
      this.agingPotential,
      required this.quantity,
      this.purchaseDate,
      this.purchasePrice,
      this.purchaseLocation,
      this.cellarId,
      this.rackRow,
      this.rackColumn,
      this.rackDepth,
      this.userRating,
      this.tastingNotes,
      this.personalNotes,
      required this.tags,
      required this.foodPairings,
      required this.isFavorite,
      required this.createdAt,
      required this.updatedAt,
      required this.source});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || vintage != null) {
      map['vintage'] = Variable<int>(vintage);
    }
    if (!nullToAbsent || labelImagePath != null) {
      map['label_image_path'] = Variable<String>(labelImagePath);
    }
    {
      map['type'] = Variable<String>($WinesTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || subRegion != null) {
      map['sub_region'] = Variable<String>(subRegion);
    }
    if (!nullToAbsent || appellation != null) {
      map['appellation'] = Variable<String>(appellation);
    }
    if (!nullToAbsent || producer != null) {
      map['producer'] = Variable<String>(producer);
    }
    if (!nullToAbsent || winemaker != null) {
      map['winemaker'] = Variable<String>(winemaker);
    }
    if (!nullToAbsent || alcoholContent != null) {
      map['alcohol_content'] = Variable<double>(alcoholContent);
    }
    if (!nullToAbsent || bodyScore != null) {
      map['body_score'] = Variable<int>(bodyScore);
    }
    if (!nullToAbsent || tanninLevel != null) {
      map['tannin_level'] = Variable<int>(tanninLevel);
    }
    if (!nullToAbsent || acidityLevel != null) {
      map['acidity_level'] = Variable<int>(acidityLevel);
    }
    if (!nullToAbsent || sweetnessLevel != null) {
      map['sweetness_level'] = Variable<int>(sweetnessLevel);
    }
    if (!nullToAbsent || drinkFrom != null) {
      map['drink_from'] = Variable<int>(drinkFrom);
    }
    if (!nullToAbsent || drinkUntil != null) {
      map['drink_until'] = Variable<int>(drinkUntil);
    }
    if (!nullToAbsent || peakFrom != null) {
      map['peak_from'] = Variable<int>(peakFrom);
    }
    if (!nullToAbsent || peakUntil != null) {
      map['peak_until'] = Variable<int>(peakUntil);
    }
    if (!nullToAbsent || agingPotential != null) {
      map['aging_potential'] = Variable<String>(
          $WinesTable.$converteragingPotentialn.toSql(agingPotential));
    }
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    if (!nullToAbsent || purchasePrice != null) {
      map['purchase_price'] = Variable<double>(purchasePrice);
    }
    if (!nullToAbsent || purchaseLocation != null) {
      map['purchase_location'] = Variable<String>(purchaseLocation);
    }
    if (!nullToAbsent || cellarId != null) {
      map['cellar_id'] = Variable<String>(cellarId);
    }
    if (!nullToAbsent || rackRow != null) {
      map['rack_row'] = Variable<int>(rackRow);
    }
    if (!nullToAbsent || rackColumn != null) {
      map['rack_column'] = Variable<int>(rackColumn);
    }
    if (!nullToAbsent || rackDepth != null) {
      map['rack_depth'] = Variable<int>(rackDepth);
    }
    if (!nullToAbsent || userRating != null) {
      map['user_rating'] = Variable<double>(userRating);
    }
    if (!nullToAbsent || tastingNotes != null) {
      map['tasting_notes'] = Variable<String>(tastingNotes);
    }
    if (!nullToAbsent || personalNotes != null) {
      map['personal_notes'] = Variable<String>(personalNotes);
    }
    map['tags'] = Variable<String>(tags);
    map['food_pairings'] = Variable<String>(foodPairings);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    {
      map['source'] =
          Variable<String>($WinesTable.$convertersource.toSql(source));
    }
    return map;
  }

  WinesCompanion toCompanion(bool nullToAbsent) {
    return WinesCompanion(
      id: Value(id),
      name: Value(name),
      vintage: vintage == null && nullToAbsent
          ? const Value.absent()
          : Value(vintage),
      labelImagePath: labelImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(labelImagePath),
      type: Value(type),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      region:
          region == null && nullToAbsent ? const Value.absent() : Value(region),
      subRegion: subRegion == null && nullToAbsent
          ? const Value.absent()
          : Value(subRegion),
      appellation: appellation == null && nullToAbsent
          ? const Value.absent()
          : Value(appellation),
      producer: producer == null && nullToAbsent
          ? const Value.absent()
          : Value(producer),
      winemaker: winemaker == null && nullToAbsent
          ? const Value.absent()
          : Value(winemaker),
      alcoholContent: alcoholContent == null && nullToAbsent
          ? const Value.absent()
          : Value(alcoholContent),
      bodyScore: bodyScore == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyScore),
      tanninLevel: tanninLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(tanninLevel),
      acidityLevel: acidityLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(acidityLevel),
      sweetnessLevel: sweetnessLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(sweetnessLevel),
      drinkFrom: drinkFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(drinkFrom),
      drinkUntil: drinkUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(drinkUntil),
      peakFrom: peakFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(peakFrom),
      peakUntil: peakUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(peakUntil),
      agingPotential: agingPotential == null && nullToAbsent
          ? const Value.absent()
          : Value(agingPotential),
      quantity: Value(quantity),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      purchasePrice: purchasePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePrice),
      purchaseLocation: purchaseLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseLocation),
      cellarId: cellarId == null && nullToAbsent
          ? const Value.absent()
          : Value(cellarId),
      rackRow: rackRow == null && nullToAbsent
          ? const Value.absent()
          : Value(rackRow),
      rackColumn: rackColumn == null && nullToAbsent
          ? const Value.absent()
          : Value(rackColumn),
      rackDepth: rackDepth == null && nullToAbsent
          ? const Value.absent()
          : Value(rackDepth),
      userRating: userRating == null && nullToAbsent
          ? const Value.absent()
          : Value(userRating),
      tastingNotes: tastingNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(tastingNotes),
      personalNotes: personalNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(personalNotes),
      tags: Value(tags),
      foodPairings: Value(foodPairings),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      source: Value(source),
    );
  }

  factory WineRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WineRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      vintage: serializer.fromJson<int?>(json['vintage']),
      labelImagePath: serializer.fromJson<String?>(json['labelImagePath']),
      type: $WinesTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      country: serializer.fromJson<String?>(json['country']),
      region: serializer.fromJson<String?>(json['region']),
      subRegion: serializer.fromJson<String?>(json['subRegion']),
      appellation: serializer.fromJson<String?>(json['appellation']),
      producer: serializer.fromJson<String?>(json['producer']),
      winemaker: serializer.fromJson<String?>(json['winemaker']),
      alcoholContent: serializer.fromJson<double?>(json['alcoholContent']),
      bodyScore: serializer.fromJson<int?>(json['bodyScore']),
      tanninLevel: serializer.fromJson<int?>(json['tanninLevel']),
      acidityLevel: serializer.fromJson<int?>(json['acidityLevel']),
      sweetnessLevel: serializer.fromJson<int?>(json['sweetnessLevel']),
      drinkFrom: serializer.fromJson<int?>(json['drinkFrom']),
      drinkUntil: serializer.fromJson<int?>(json['drinkUntil']),
      peakFrom: serializer.fromJson<int?>(json['peakFrom']),
      peakUntil: serializer.fromJson<int?>(json['peakUntil']),
      agingPotential: $WinesTable.$converteragingPotentialn
          .fromJson(serializer.fromJson<String?>(json['agingPotential'])),
      quantity: serializer.fromJson<int>(json['quantity']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      purchasePrice: serializer.fromJson<double?>(json['purchasePrice']),
      purchaseLocation: serializer.fromJson<String?>(json['purchaseLocation']),
      cellarId: serializer.fromJson<String?>(json['cellarId']),
      rackRow: serializer.fromJson<int?>(json['rackRow']),
      rackColumn: serializer.fromJson<int?>(json['rackColumn']),
      rackDepth: serializer.fromJson<int?>(json['rackDepth']),
      userRating: serializer.fromJson<double?>(json['userRating']),
      tastingNotes: serializer.fromJson<String?>(json['tastingNotes']),
      personalNotes: serializer.fromJson<String?>(json['personalNotes']),
      tags: serializer.fromJson<String>(json['tags']),
      foodPairings: serializer.fromJson<String>(json['foodPairings']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      source: $WinesTable.$convertersource
          .fromJson(serializer.fromJson<String>(json['source'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'vintage': serializer.toJson<int?>(vintage),
      'labelImagePath': serializer.toJson<String?>(labelImagePath),
      'type':
          serializer.toJson<String>($WinesTable.$convertertype.toJson(type)),
      'country': serializer.toJson<String?>(country),
      'region': serializer.toJson<String?>(region),
      'subRegion': serializer.toJson<String?>(subRegion),
      'appellation': serializer.toJson<String?>(appellation),
      'producer': serializer.toJson<String?>(producer),
      'winemaker': serializer.toJson<String?>(winemaker),
      'alcoholContent': serializer.toJson<double?>(alcoholContent),
      'bodyScore': serializer.toJson<int?>(bodyScore),
      'tanninLevel': serializer.toJson<int?>(tanninLevel),
      'acidityLevel': serializer.toJson<int?>(acidityLevel),
      'sweetnessLevel': serializer.toJson<int?>(sweetnessLevel),
      'drinkFrom': serializer.toJson<int?>(drinkFrom),
      'drinkUntil': serializer.toJson<int?>(drinkUntil),
      'peakFrom': serializer.toJson<int?>(peakFrom),
      'peakUntil': serializer.toJson<int?>(peakUntil),
      'agingPotential': serializer.toJson<String?>(
          $WinesTable.$converteragingPotentialn.toJson(agingPotential)),
      'quantity': serializer.toJson<int>(quantity),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'purchasePrice': serializer.toJson<double?>(purchasePrice),
      'purchaseLocation': serializer.toJson<String?>(purchaseLocation),
      'cellarId': serializer.toJson<String?>(cellarId),
      'rackRow': serializer.toJson<int?>(rackRow),
      'rackColumn': serializer.toJson<int?>(rackColumn),
      'rackDepth': serializer.toJson<int?>(rackDepth),
      'userRating': serializer.toJson<double?>(userRating),
      'tastingNotes': serializer.toJson<String?>(tastingNotes),
      'personalNotes': serializer.toJson<String?>(personalNotes),
      'tags': serializer.toJson<String>(tags),
      'foodPairings': serializer.toJson<String>(foodPairings),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'source': serializer
          .toJson<String>($WinesTable.$convertersource.toJson(source)),
    };
  }

  WineRow copyWith(
          {String? id,
          String? name,
          Value<int?> vintage = const Value.absent(),
          Value<String?> labelImagePath = const Value.absent(),
          WineType? type,
          Value<String?> country = const Value.absent(),
          Value<String?> region = const Value.absent(),
          Value<String?> subRegion = const Value.absent(),
          Value<String?> appellation = const Value.absent(),
          Value<String?> producer = const Value.absent(),
          Value<String?> winemaker = const Value.absent(),
          Value<double?> alcoholContent = const Value.absent(),
          Value<int?> bodyScore = const Value.absent(),
          Value<int?> tanninLevel = const Value.absent(),
          Value<int?> acidityLevel = const Value.absent(),
          Value<int?> sweetnessLevel = const Value.absent(),
          Value<int?> drinkFrom = const Value.absent(),
          Value<int?> drinkUntil = const Value.absent(),
          Value<int?> peakFrom = const Value.absent(),
          Value<int?> peakUntil = const Value.absent(),
          Value<AgingPotential?> agingPotential = const Value.absent(),
          int? quantity,
          Value<DateTime?> purchaseDate = const Value.absent(),
          Value<double?> purchasePrice = const Value.absent(),
          Value<String?> purchaseLocation = const Value.absent(),
          Value<String?> cellarId = const Value.absent(),
          Value<int?> rackRow = const Value.absent(),
          Value<int?> rackColumn = const Value.absent(),
          Value<int?> rackDepth = const Value.absent(),
          Value<double?> userRating = const Value.absent(),
          Value<String?> tastingNotes = const Value.absent(),
          Value<String?> personalNotes = const Value.absent(),
          String? tags,
          String? foodPairings,
          bool? isFavorite,
          DateTime? createdAt,
          DateTime? updatedAt,
          WineSource? source}) =>
      WineRow(
        id: id ?? this.id,
        name: name ?? this.name,
        vintage: vintage.present ? vintage.value : this.vintage,
        labelImagePath:
            labelImagePath.present ? labelImagePath.value : this.labelImagePath,
        type: type ?? this.type,
        country: country.present ? country.value : this.country,
        region: region.present ? region.value : this.region,
        subRegion: subRegion.present ? subRegion.value : this.subRegion,
        appellation: appellation.present ? appellation.value : this.appellation,
        producer: producer.present ? producer.value : this.producer,
        winemaker: winemaker.present ? winemaker.value : this.winemaker,
        alcoholContent:
            alcoholContent.present ? alcoholContent.value : this.alcoholContent,
        bodyScore: bodyScore.present ? bodyScore.value : this.bodyScore,
        tanninLevel: tanninLevel.present ? tanninLevel.value : this.tanninLevel,
        acidityLevel:
            acidityLevel.present ? acidityLevel.value : this.acidityLevel,
        sweetnessLevel:
            sweetnessLevel.present ? sweetnessLevel.value : this.sweetnessLevel,
        drinkFrom: drinkFrom.present ? drinkFrom.value : this.drinkFrom,
        drinkUntil: drinkUntil.present ? drinkUntil.value : this.drinkUntil,
        peakFrom: peakFrom.present ? peakFrom.value : this.peakFrom,
        peakUntil: peakUntil.present ? peakUntil.value : this.peakUntil,
        agingPotential:
            agingPotential.present ? agingPotential.value : this.agingPotential,
        quantity: quantity ?? this.quantity,
        purchaseDate:
            purchaseDate.present ? purchaseDate.value : this.purchaseDate,
        purchasePrice:
            purchasePrice.present ? purchasePrice.value : this.purchasePrice,
        purchaseLocation: purchaseLocation.present
            ? purchaseLocation.value
            : this.purchaseLocation,
        cellarId: cellarId.present ? cellarId.value : this.cellarId,
        rackRow: rackRow.present ? rackRow.value : this.rackRow,
        rackColumn: rackColumn.present ? rackColumn.value : this.rackColumn,
        rackDepth: rackDepth.present ? rackDepth.value : this.rackDepth,
        userRating: userRating.present ? userRating.value : this.userRating,
        tastingNotes:
            tastingNotes.present ? tastingNotes.value : this.tastingNotes,
        personalNotes:
            personalNotes.present ? personalNotes.value : this.personalNotes,
        tags: tags ?? this.tags,
        foodPairings: foodPairings ?? this.foodPairings,
        isFavorite: isFavorite ?? this.isFavorite,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        source: source ?? this.source,
      );
  WineRow copyWithCompanion(WinesCompanion data) {
    return WineRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      vintage: data.vintage.present ? data.vintage.value : this.vintage,
      labelImagePath: data.labelImagePath.present
          ? data.labelImagePath.value
          : this.labelImagePath,
      type: data.type.present ? data.type.value : this.type,
      country: data.country.present ? data.country.value : this.country,
      region: data.region.present ? data.region.value : this.region,
      subRegion: data.subRegion.present ? data.subRegion.value : this.subRegion,
      appellation:
          data.appellation.present ? data.appellation.value : this.appellation,
      producer: data.producer.present ? data.producer.value : this.producer,
      winemaker: data.winemaker.present ? data.winemaker.value : this.winemaker,
      alcoholContent: data.alcoholContent.present
          ? data.alcoholContent.value
          : this.alcoholContent,
      bodyScore: data.bodyScore.present ? data.bodyScore.value : this.bodyScore,
      tanninLevel:
          data.tanninLevel.present ? data.tanninLevel.value : this.tanninLevel,
      acidityLevel: data.acidityLevel.present
          ? data.acidityLevel.value
          : this.acidityLevel,
      sweetnessLevel: data.sweetnessLevel.present
          ? data.sweetnessLevel.value
          : this.sweetnessLevel,
      drinkFrom: data.drinkFrom.present ? data.drinkFrom.value : this.drinkFrom,
      drinkUntil:
          data.drinkUntil.present ? data.drinkUntil.value : this.drinkUntil,
      peakFrom: data.peakFrom.present ? data.peakFrom.value : this.peakFrom,
      peakUntil: data.peakUntil.present ? data.peakUntil.value : this.peakUntil,
      agingPotential: data.agingPotential.present
          ? data.agingPotential.value
          : this.agingPotential,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      purchaseLocation: data.purchaseLocation.present
          ? data.purchaseLocation.value
          : this.purchaseLocation,
      cellarId: data.cellarId.present ? data.cellarId.value : this.cellarId,
      rackRow: data.rackRow.present ? data.rackRow.value : this.rackRow,
      rackColumn:
          data.rackColumn.present ? data.rackColumn.value : this.rackColumn,
      rackDepth: data.rackDepth.present ? data.rackDepth.value : this.rackDepth,
      userRating:
          data.userRating.present ? data.userRating.value : this.userRating,
      tastingNotes: data.tastingNotes.present
          ? data.tastingNotes.value
          : this.tastingNotes,
      personalNotes: data.personalNotes.present
          ? data.personalNotes.value
          : this.personalNotes,
      tags: data.tags.present ? data.tags.value : this.tags,
      foodPairings: data.foodPairings.present
          ? data.foodPairings.value
          : this.foodPairings,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WineRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('vintage: $vintage, ')
          ..write('labelImagePath: $labelImagePath, ')
          ..write('type: $type, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('subRegion: $subRegion, ')
          ..write('appellation: $appellation, ')
          ..write('producer: $producer, ')
          ..write('winemaker: $winemaker, ')
          ..write('alcoholContent: $alcoholContent, ')
          ..write('bodyScore: $bodyScore, ')
          ..write('tanninLevel: $tanninLevel, ')
          ..write('acidityLevel: $acidityLevel, ')
          ..write('sweetnessLevel: $sweetnessLevel, ')
          ..write('drinkFrom: $drinkFrom, ')
          ..write('drinkUntil: $drinkUntil, ')
          ..write('peakFrom: $peakFrom, ')
          ..write('peakUntil: $peakUntil, ')
          ..write('agingPotential: $agingPotential, ')
          ..write('quantity: $quantity, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('purchaseLocation: $purchaseLocation, ')
          ..write('cellarId: $cellarId, ')
          ..write('rackRow: $rackRow, ')
          ..write('rackColumn: $rackColumn, ')
          ..write('rackDepth: $rackDepth, ')
          ..write('userRating: $userRating, ')
          ..write('tastingNotes: $tastingNotes, ')
          ..write('personalNotes: $personalNotes, ')
          ..write('tags: $tags, ')
          ..write('foodPairings: $foodPairings, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        vintage,
        labelImagePath,
        type,
        country,
        region,
        subRegion,
        appellation,
        producer,
        winemaker,
        alcoholContent,
        bodyScore,
        tanninLevel,
        acidityLevel,
        sweetnessLevel,
        drinkFrom,
        drinkUntil,
        peakFrom,
        peakUntil,
        agingPotential,
        quantity,
        purchaseDate,
        purchasePrice,
        purchaseLocation,
        cellarId,
        rackRow,
        rackColumn,
        rackDepth,
        userRating,
        tastingNotes,
        personalNotes,
        tags,
        foodPairings,
        isFavorite,
        createdAt,
        updatedAt,
        source
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WineRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.vintage == this.vintage &&
          other.labelImagePath == this.labelImagePath &&
          other.type == this.type &&
          other.country == this.country &&
          other.region == this.region &&
          other.subRegion == this.subRegion &&
          other.appellation == this.appellation &&
          other.producer == this.producer &&
          other.winemaker == this.winemaker &&
          other.alcoholContent == this.alcoholContent &&
          other.bodyScore == this.bodyScore &&
          other.tanninLevel == this.tanninLevel &&
          other.acidityLevel == this.acidityLevel &&
          other.sweetnessLevel == this.sweetnessLevel &&
          other.drinkFrom == this.drinkFrom &&
          other.drinkUntil == this.drinkUntil &&
          other.peakFrom == this.peakFrom &&
          other.peakUntil == this.peakUntil &&
          other.agingPotential == this.agingPotential &&
          other.quantity == this.quantity &&
          other.purchaseDate == this.purchaseDate &&
          other.purchasePrice == this.purchasePrice &&
          other.purchaseLocation == this.purchaseLocation &&
          other.cellarId == this.cellarId &&
          other.rackRow == this.rackRow &&
          other.rackColumn == this.rackColumn &&
          other.rackDepth == this.rackDepth &&
          other.userRating == this.userRating &&
          other.tastingNotes == this.tastingNotes &&
          other.personalNotes == this.personalNotes &&
          other.tags == this.tags &&
          other.foodPairings == this.foodPairings &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.source == this.source);
}

class WinesCompanion extends UpdateCompanion<WineRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int?> vintage;
  final Value<String?> labelImagePath;
  final Value<WineType> type;
  final Value<String?> country;
  final Value<String?> region;
  final Value<String?> subRegion;
  final Value<String?> appellation;
  final Value<String?> producer;
  final Value<String?> winemaker;
  final Value<double?> alcoholContent;
  final Value<int?> bodyScore;
  final Value<int?> tanninLevel;
  final Value<int?> acidityLevel;
  final Value<int?> sweetnessLevel;
  final Value<int?> drinkFrom;
  final Value<int?> drinkUntil;
  final Value<int?> peakFrom;
  final Value<int?> peakUntil;
  final Value<AgingPotential?> agingPotential;
  final Value<int> quantity;
  final Value<DateTime?> purchaseDate;
  final Value<double?> purchasePrice;
  final Value<String?> purchaseLocation;
  final Value<String?> cellarId;
  final Value<int?> rackRow;
  final Value<int?> rackColumn;
  final Value<int?> rackDepth;
  final Value<double?> userRating;
  final Value<String?> tastingNotes;
  final Value<String?> personalNotes;
  final Value<String> tags;
  final Value<String> foodPairings;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<WineSource> source;
  final Value<int> rowid;
  const WinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.vintage = const Value.absent(),
    this.labelImagePath = const Value.absent(),
    this.type = const Value.absent(),
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.subRegion = const Value.absent(),
    this.appellation = const Value.absent(),
    this.producer = const Value.absent(),
    this.winemaker = const Value.absent(),
    this.alcoholContent = const Value.absent(),
    this.bodyScore = const Value.absent(),
    this.tanninLevel = const Value.absent(),
    this.acidityLevel = const Value.absent(),
    this.sweetnessLevel = const Value.absent(),
    this.drinkFrom = const Value.absent(),
    this.drinkUntil = const Value.absent(),
    this.peakFrom = const Value.absent(),
    this.peakUntil = const Value.absent(),
    this.agingPotential = const Value.absent(),
    this.quantity = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.purchaseLocation = const Value.absent(),
    this.cellarId = const Value.absent(),
    this.rackRow = const Value.absent(),
    this.rackColumn = const Value.absent(),
    this.rackDepth = const Value.absent(),
    this.userRating = const Value.absent(),
    this.tastingNotes = const Value.absent(),
    this.personalNotes = const Value.absent(),
    this.tags = const Value.absent(),
    this.foodPairings = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WinesCompanion.insert({
    required String id,
    required String name,
    this.vintage = const Value.absent(),
    this.labelImagePath = const Value.absent(),
    required WineType type,
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.subRegion = const Value.absent(),
    this.appellation = const Value.absent(),
    this.producer = const Value.absent(),
    this.winemaker = const Value.absent(),
    this.alcoholContent = const Value.absent(),
    this.bodyScore = const Value.absent(),
    this.tanninLevel = const Value.absent(),
    this.acidityLevel = const Value.absent(),
    this.sweetnessLevel = const Value.absent(),
    this.drinkFrom = const Value.absent(),
    this.drinkUntil = const Value.absent(),
    this.peakFrom = const Value.absent(),
    this.peakUntil = const Value.absent(),
    this.agingPotential = const Value.absent(),
    this.quantity = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.purchaseLocation = const Value.absent(),
    this.cellarId = const Value.absent(),
    this.rackRow = const Value.absent(),
    this.rackColumn = const Value.absent(),
    this.rackDepth = const Value.absent(),
    this.userRating = const Value.absent(),
    this.tastingNotes = const Value.absent(),
    this.personalNotes = const Value.absent(),
    this.tags = const Value.absent(),
    this.foodPairings = const Value.absent(),
    this.isFavorite = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required WineSource source,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        source = Value(source);
  static Insertable<WineRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? vintage,
    Expression<String>? labelImagePath,
    Expression<String>? type,
    Expression<String>? country,
    Expression<String>? region,
    Expression<String>? subRegion,
    Expression<String>? appellation,
    Expression<String>? producer,
    Expression<String>? winemaker,
    Expression<double>? alcoholContent,
    Expression<int>? bodyScore,
    Expression<int>? tanninLevel,
    Expression<int>? acidityLevel,
    Expression<int>? sweetnessLevel,
    Expression<int>? drinkFrom,
    Expression<int>? drinkUntil,
    Expression<int>? peakFrom,
    Expression<int>? peakUntil,
    Expression<String>? agingPotential,
    Expression<int>? quantity,
    Expression<DateTime>? purchaseDate,
    Expression<double>? purchasePrice,
    Expression<String>? purchaseLocation,
    Expression<String>? cellarId,
    Expression<int>? rackRow,
    Expression<int>? rackColumn,
    Expression<int>? rackDepth,
    Expression<double>? userRating,
    Expression<String>? tastingNotes,
    Expression<String>? personalNotes,
    Expression<String>? tags,
    Expression<String>? foodPairings,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (vintage != null) 'vintage': vintage,
      if (labelImagePath != null) 'label_image_path': labelImagePath,
      if (type != null) 'type': type,
      if (country != null) 'country': country,
      if (region != null) 'region': region,
      if (subRegion != null) 'sub_region': subRegion,
      if (appellation != null) 'appellation': appellation,
      if (producer != null) 'producer': producer,
      if (winemaker != null) 'winemaker': winemaker,
      if (alcoholContent != null) 'alcohol_content': alcoholContent,
      if (bodyScore != null) 'body_score': bodyScore,
      if (tanninLevel != null) 'tannin_level': tanninLevel,
      if (acidityLevel != null) 'acidity_level': acidityLevel,
      if (sweetnessLevel != null) 'sweetness_level': sweetnessLevel,
      if (drinkFrom != null) 'drink_from': drinkFrom,
      if (drinkUntil != null) 'drink_until': drinkUntil,
      if (peakFrom != null) 'peak_from': peakFrom,
      if (peakUntil != null) 'peak_until': peakUntil,
      if (agingPotential != null) 'aging_potential': agingPotential,
      if (quantity != null) 'quantity': quantity,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (purchaseLocation != null) 'purchase_location': purchaseLocation,
      if (cellarId != null) 'cellar_id': cellarId,
      if (rackRow != null) 'rack_row': rackRow,
      if (rackColumn != null) 'rack_column': rackColumn,
      if (rackDepth != null) 'rack_depth': rackDepth,
      if (userRating != null) 'user_rating': userRating,
      if (tastingNotes != null) 'tasting_notes': tastingNotes,
      if (personalNotes != null) 'personal_notes': personalNotes,
      if (tags != null) 'tags': tags,
      if (foodPairings != null) 'food_pairings': foodPairings,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WinesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int?>? vintage,
      Value<String?>? labelImagePath,
      Value<WineType>? type,
      Value<String?>? country,
      Value<String?>? region,
      Value<String?>? subRegion,
      Value<String?>? appellation,
      Value<String?>? producer,
      Value<String?>? winemaker,
      Value<double?>? alcoholContent,
      Value<int?>? bodyScore,
      Value<int?>? tanninLevel,
      Value<int?>? acidityLevel,
      Value<int?>? sweetnessLevel,
      Value<int?>? drinkFrom,
      Value<int?>? drinkUntil,
      Value<int?>? peakFrom,
      Value<int?>? peakUntil,
      Value<AgingPotential?>? agingPotential,
      Value<int>? quantity,
      Value<DateTime?>? purchaseDate,
      Value<double?>? purchasePrice,
      Value<String?>? purchaseLocation,
      Value<String?>? cellarId,
      Value<int?>? rackRow,
      Value<int?>? rackColumn,
      Value<int?>? rackDepth,
      Value<double?>? userRating,
      Value<String?>? tastingNotes,
      Value<String?>? personalNotes,
      Value<String>? tags,
      Value<String>? foodPairings,
      Value<bool>? isFavorite,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<WineSource>? source,
      Value<int>? rowid}) {
    return WinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      vintage: vintage ?? this.vintage,
      labelImagePath: labelImagePath ?? this.labelImagePath,
      type: type ?? this.type,
      country: country ?? this.country,
      region: region ?? this.region,
      subRegion: subRegion ?? this.subRegion,
      appellation: appellation ?? this.appellation,
      producer: producer ?? this.producer,
      winemaker: winemaker ?? this.winemaker,
      alcoholContent: alcoholContent ?? this.alcoholContent,
      bodyScore: bodyScore ?? this.bodyScore,
      tanninLevel: tanninLevel ?? this.tanninLevel,
      acidityLevel: acidityLevel ?? this.acidityLevel,
      sweetnessLevel: sweetnessLevel ?? this.sweetnessLevel,
      drinkFrom: drinkFrom ?? this.drinkFrom,
      drinkUntil: drinkUntil ?? this.drinkUntil,
      peakFrom: peakFrom ?? this.peakFrom,
      peakUntil: peakUntil ?? this.peakUntil,
      agingPotential: agingPotential ?? this.agingPotential,
      quantity: quantity ?? this.quantity,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      purchaseLocation: purchaseLocation ?? this.purchaseLocation,
      cellarId: cellarId ?? this.cellarId,
      rackRow: rackRow ?? this.rackRow,
      rackColumn: rackColumn ?? this.rackColumn,
      rackDepth: rackDepth ?? this.rackDepth,
      userRating: userRating ?? this.userRating,
      tastingNotes: tastingNotes ?? this.tastingNotes,
      personalNotes: personalNotes ?? this.personalNotes,
      tags: tags ?? this.tags,
      foodPairings: foodPairings ?? this.foodPairings,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (vintage.present) {
      map['vintage'] = Variable<int>(vintage.value);
    }
    if (labelImagePath.present) {
      map['label_image_path'] = Variable<String>(labelImagePath.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($WinesTable.$convertertype.toSql(type.value));
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (subRegion.present) {
      map['sub_region'] = Variable<String>(subRegion.value);
    }
    if (appellation.present) {
      map['appellation'] = Variable<String>(appellation.value);
    }
    if (producer.present) {
      map['producer'] = Variable<String>(producer.value);
    }
    if (winemaker.present) {
      map['winemaker'] = Variable<String>(winemaker.value);
    }
    if (alcoholContent.present) {
      map['alcohol_content'] = Variable<double>(alcoholContent.value);
    }
    if (bodyScore.present) {
      map['body_score'] = Variable<int>(bodyScore.value);
    }
    if (tanninLevel.present) {
      map['tannin_level'] = Variable<int>(tanninLevel.value);
    }
    if (acidityLevel.present) {
      map['acidity_level'] = Variable<int>(acidityLevel.value);
    }
    if (sweetnessLevel.present) {
      map['sweetness_level'] = Variable<int>(sweetnessLevel.value);
    }
    if (drinkFrom.present) {
      map['drink_from'] = Variable<int>(drinkFrom.value);
    }
    if (drinkUntil.present) {
      map['drink_until'] = Variable<int>(drinkUntil.value);
    }
    if (peakFrom.present) {
      map['peak_from'] = Variable<int>(peakFrom.value);
    }
    if (peakUntil.present) {
      map['peak_until'] = Variable<int>(peakUntil.value);
    }
    if (agingPotential.present) {
      map['aging_potential'] = Variable<String>(
          $WinesTable.$converteragingPotentialn.toSql(agingPotential.value));
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (purchaseLocation.present) {
      map['purchase_location'] = Variable<String>(purchaseLocation.value);
    }
    if (cellarId.present) {
      map['cellar_id'] = Variable<String>(cellarId.value);
    }
    if (rackRow.present) {
      map['rack_row'] = Variable<int>(rackRow.value);
    }
    if (rackColumn.present) {
      map['rack_column'] = Variable<int>(rackColumn.value);
    }
    if (rackDepth.present) {
      map['rack_depth'] = Variable<int>(rackDepth.value);
    }
    if (userRating.present) {
      map['user_rating'] = Variable<double>(userRating.value);
    }
    if (tastingNotes.present) {
      map['tasting_notes'] = Variable<String>(tastingNotes.value);
    }
    if (personalNotes.present) {
      map['personal_notes'] = Variable<String>(personalNotes.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (foodPairings.present) {
      map['food_pairings'] = Variable<String>(foodPairings.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (source.present) {
      map['source'] =
          Variable<String>($WinesTable.$convertersource.toSql(source.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('vintage: $vintage, ')
          ..write('labelImagePath: $labelImagePath, ')
          ..write('type: $type, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('subRegion: $subRegion, ')
          ..write('appellation: $appellation, ')
          ..write('producer: $producer, ')
          ..write('winemaker: $winemaker, ')
          ..write('alcoholContent: $alcoholContent, ')
          ..write('bodyScore: $bodyScore, ')
          ..write('tanninLevel: $tanninLevel, ')
          ..write('acidityLevel: $acidityLevel, ')
          ..write('sweetnessLevel: $sweetnessLevel, ')
          ..write('drinkFrom: $drinkFrom, ')
          ..write('drinkUntil: $drinkUntil, ')
          ..write('peakFrom: $peakFrom, ')
          ..write('peakUntil: $peakUntil, ')
          ..write('agingPotential: $agingPotential, ')
          ..write('quantity: $quantity, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('purchaseLocation: $purchaseLocation, ')
          ..write('cellarId: $cellarId, ')
          ..write('rackRow: $rackRow, ')
          ..write('rackColumn: $rackColumn, ')
          ..write('rackDepth: $rackDepth, ')
          ..write('userRating: $userRating, ')
          ..write('tastingNotes: $tastingNotes, ')
          ..write('personalNotes: $personalNotes, ')
          ..write('tags: $tags, ')
          ..write('foodPairings: $foodPairings, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CellarSlotsTable extends CellarSlots
    with TableInfo<$CellarSlotsTable, CellarSlotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CellarSlotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cellarIdMeta =
      const VerificationMeta('cellarId');
  @override
  late final GeneratedColumn<String> cellarId = GeneratedColumn<String>(
      'cellar_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES cellars (id) ON DELETE CASCADE'));
  static const VerificationMeta _rowMeta = const VerificationMeta('row');
  @override
  late final GeneratedColumn<int> row = GeneratedColumn<int>(
      'row', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _columnMeta = const VerificationMeta('column');
  @override
  late final GeneratedColumn<int> column = GeneratedColumn<int>(
      'column', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
      'depth', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<String> wineId = GeneratedColumn<String>(
      'wine_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES wines (id) ON DELETE SET NULL'));
  static const VerificationMeta _isBlockedMeta =
      const VerificationMeta('isBlocked');
  @override
  late final GeneratedColumn<bool> isBlocked = GeneratedColumn<bool>(
      'is_blocked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_blocked" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [cellarId, row, column, depth, wineId, isBlocked];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cellar_slots';
  @override
  VerificationContext validateIntegrity(Insertable<CellarSlotRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cellar_id')) {
      context.handle(_cellarIdMeta,
          cellarId.isAcceptableOrUnknown(data['cellar_id']!, _cellarIdMeta));
    } else if (isInserting) {
      context.missing(_cellarIdMeta);
    }
    if (data.containsKey('row')) {
      context.handle(
          _rowMeta, row.isAcceptableOrUnknown(data['row']!, _rowMeta));
    } else if (isInserting) {
      context.missing(_rowMeta);
    }
    if (data.containsKey('column')) {
      context.handle(_columnMeta,
          column.isAcceptableOrUnknown(data['column']!, _columnMeta));
    } else if (isInserting) {
      context.missing(_columnMeta);
    }
    if (data.containsKey('depth')) {
      context.handle(
          _depthMeta, depth.isAcceptableOrUnknown(data['depth']!, _depthMeta));
    } else if (isInserting) {
      context.missing(_depthMeta);
    }
    if (data.containsKey('wine_id')) {
      context.handle(_wineIdMeta,
          wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta));
    }
    if (data.containsKey('is_blocked')) {
      context.handle(_isBlockedMeta,
          isBlocked.isAcceptableOrUnknown(data['is_blocked']!, _isBlockedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cellarId, row, column, depth};
  @override
  CellarSlotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CellarSlotRow(
      cellarId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cellar_id'])!,
      row: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}row'])!,
      column: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}column'])!,
      depth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}depth'])!,
      wineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wine_id']),
      isBlocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_blocked'])!,
    );
  }

  @override
  $CellarSlotsTable createAlias(String alias) {
    return $CellarSlotsTable(attachedDatabase, alias);
  }
}

class CellarSlotRow extends DataClass implements Insertable<CellarSlotRow> {
  final String cellarId;
  final int row;
  final int column;
  final int depth;
  final String? wineId;
  final bool isBlocked;
  const CellarSlotRow(
      {required this.cellarId,
      required this.row,
      required this.column,
      required this.depth,
      this.wineId,
      required this.isBlocked});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cellar_id'] = Variable<String>(cellarId);
    map['row'] = Variable<int>(row);
    map['column'] = Variable<int>(column);
    map['depth'] = Variable<int>(depth);
    if (!nullToAbsent || wineId != null) {
      map['wine_id'] = Variable<String>(wineId);
    }
    map['is_blocked'] = Variable<bool>(isBlocked);
    return map;
  }

  CellarSlotsCompanion toCompanion(bool nullToAbsent) {
    return CellarSlotsCompanion(
      cellarId: Value(cellarId),
      row: Value(row),
      column: Value(column),
      depth: Value(depth),
      wineId:
          wineId == null && nullToAbsent ? const Value.absent() : Value(wineId),
      isBlocked: Value(isBlocked),
    );
  }

  factory CellarSlotRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CellarSlotRow(
      cellarId: serializer.fromJson<String>(json['cellarId']),
      row: serializer.fromJson<int>(json['row']),
      column: serializer.fromJson<int>(json['column']),
      depth: serializer.fromJson<int>(json['depth']),
      wineId: serializer.fromJson<String?>(json['wineId']),
      isBlocked: serializer.fromJson<bool>(json['isBlocked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cellarId': serializer.toJson<String>(cellarId),
      'row': serializer.toJson<int>(row),
      'column': serializer.toJson<int>(column),
      'depth': serializer.toJson<int>(depth),
      'wineId': serializer.toJson<String?>(wineId),
      'isBlocked': serializer.toJson<bool>(isBlocked),
    };
  }

  CellarSlotRow copyWith(
          {String? cellarId,
          int? row,
          int? column,
          int? depth,
          Value<String?> wineId = const Value.absent(),
          bool? isBlocked}) =>
      CellarSlotRow(
        cellarId: cellarId ?? this.cellarId,
        row: row ?? this.row,
        column: column ?? this.column,
        depth: depth ?? this.depth,
        wineId: wineId.present ? wineId.value : this.wineId,
        isBlocked: isBlocked ?? this.isBlocked,
      );
  CellarSlotRow copyWithCompanion(CellarSlotsCompanion data) {
    return CellarSlotRow(
      cellarId: data.cellarId.present ? data.cellarId.value : this.cellarId,
      row: data.row.present ? data.row.value : this.row,
      column: data.column.present ? data.column.value : this.column,
      depth: data.depth.present ? data.depth.value : this.depth,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      isBlocked: data.isBlocked.present ? data.isBlocked.value : this.isBlocked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CellarSlotRow(')
          ..write('cellarId: $cellarId, ')
          ..write('row: $row, ')
          ..write('column: $column, ')
          ..write('depth: $depth, ')
          ..write('wineId: $wineId, ')
          ..write('isBlocked: $isBlocked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(cellarId, row, column, depth, wineId, isBlocked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CellarSlotRow &&
          other.cellarId == this.cellarId &&
          other.row == this.row &&
          other.column == this.column &&
          other.depth == this.depth &&
          other.wineId == this.wineId &&
          other.isBlocked == this.isBlocked);
}

class CellarSlotsCompanion extends UpdateCompanion<CellarSlotRow> {
  final Value<String> cellarId;
  final Value<int> row;
  final Value<int> column;
  final Value<int> depth;
  final Value<String?> wineId;
  final Value<bool> isBlocked;
  final Value<int> rowid;
  const CellarSlotsCompanion({
    this.cellarId = const Value.absent(),
    this.row = const Value.absent(),
    this.column = const Value.absent(),
    this.depth = const Value.absent(),
    this.wineId = const Value.absent(),
    this.isBlocked = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CellarSlotsCompanion.insert({
    required String cellarId,
    required int row,
    required int column,
    required int depth,
    this.wineId = const Value.absent(),
    this.isBlocked = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : cellarId = Value(cellarId),
        row = Value(row),
        column = Value(column),
        depth = Value(depth);
  static Insertable<CellarSlotRow> custom({
    Expression<String>? cellarId,
    Expression<int>? row,
    Expression<int>? column,
    Expression<int>? depth,
    Expression<String>? wineId,
    Expression<bool>? isBlocked,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cellarId != null) 'cellar_id': cellarId,
      if (row != null) 'row': row,
      if (column != null) 'column': column,
      if (depth != null) 'depth': depth,
      if (wineId != null) 'wine_id': wineId,
      if (isBlocked != null) 'is_blocked': isBlocked,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CellarSlotsCompanion copyWith(
      {Value<String>? cellarId,
      Value<int>? row,
      Value<int>? column,
      Value<int>? depth,
      Value<String?>? wineId,
      Value<bool>? isBlocked,
      Value<int>? rowid}) {
    return CellarSlotsCompanion(
      cellarId: cellarId ?? this.cellarId,
      row: row ?? this.row,
      column: column ?? this.column,
      depth: depth ?? this.depth,
      wineId: wineId ?? this.wineId,
      isBlocked: isBlocked ?? this.isBlocked,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cellarId.present) {
      map['cellar_id'] = Variable<String>(cellarId.value);
    }
    if (row.present) {
      map['row'] = Variable<int>(row.value);
    }
    if (column.present) {
      map['column'] = Variable<int>(column.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<String>(wineId.value);
    }
    if (isBlocked.present) {
      map['is_blocked'] = Variable<bool>(isBlocked.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CellarSlotsCompanion(')
          ..write('cellarId: $cellarId, ')
          ..write('row: $row, ')
          ..write('column: $column, ')
          ..write('depth: $depth, ')
          ..write('wineId: $wineId, ')
          ..write('isBlocked: $isBlocked, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TastingNotesTable extends TastingNotes
    with TableInfo<$TastingNotesTable, TastingNoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TastingNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<String> wineId = GeneratedColumn<String>(
      'wine_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES wines (id) ON DELETE CASCADE'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _appearanceMeta =
      const VerificationMeta('appearance');
  @override
  late final GeneratedColumn<String> appearance = GeneratedColumn<String>(
      'appearance', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noseMeta = const VerificationMeta('nose');
  @override
  late final GeneratedColumn<String> nose = GeneratedColumn<String>(
      'nose', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _palateMeta = const VerificationMeta('palate');
  @override
  late final GeneratedColumn<String> palate = GeneratedColumn<String>(
      'palate', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _finishMeta = const VerificationMeta('finish');
  @override
  late final GeneratedColumn<String> finish = GeneratedColumn<String>(
      'finish', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _occasionMeta =
      const VerificationMeta('occasion');
  @override
  late final GeneratedColumn<String> occasion = GeneratedColumn<String>(
      'occasion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _foodPairedMeta =
      const VerificationMeta('foodPaired');
  @override
  late final GeneratedColumn<String> foodPaired = GeneratedColumn<String>(
      'food_paired', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        wineId,
        date,
        appearance,
        nose,
        palate,
        finish,
        notes,
        rating,
        photoPath,
        occasion,
        foodPaired
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasting_notes';
  @override
  VerificationContext validateIntegrity(Insertable<TastingNoteRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('wine_id')) {
      context.handle(_wineIdMeta,
          wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta));
    } else if (isInserting) {
      context.missing(_wineIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('appearance')) {
      context.handle(
          _appearanceMeta,
          appearance.isAcceptableOrUnknown(
              data['appearance']!, _appearanceMeta));
    }
    if (data.containsKey('nose')) {
      context.handle(
          _noseMeta, nose.isAcceptableOrUnknown(data['nose']!, _noseMeta));
    }
    if (data.containsKey('palate')) {
      context.handle(_palateMeta,
          palate.isAcceptableOrUnknown(data['palate']!, _palateMeta));
    }
    if (data.containsKey('finish')) {
      context.handle(_finishMeta,
          finish.isAcceptableOrUnknown(data['finish']!, _finishMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('occasion')) {
      context.handle(_occasionMeta,
          occasion.isAcceptableOrUnknown(data['occasion']!, _occasionMeta));
    }
    if (data.containsKey('food_paired')) {
      context.handle(
          _foodPairedMeta,
          foodPaired.isAcceptableOrUnknown(
              data['food_paired']!, _foodPairedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TastingNoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TastingNoteRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      wineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wine_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      appearance: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}appearance']),
      nose: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nose']),
      palate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}palate']),
      finish: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}finish']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      occasion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}occasion']),
      foodPaired: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_paired']),
    );
  }

  @override
  $TastingNotesTable createAlias(String alias) {
    return $TastingNotesTable(attachedDatabase, alias);
  }
}

class TastingNoteRow extends DataClass implements Insertable<TastingNoteRow> {
  final String id;
  final String wineId;
  final DateTime date;
  final String? appearance;
  final String? nose;
  final String? palate;
  final String? finish;
  final String? notes;
  final double? rating;
  final String? photoPath;
  final String? occasion;
  final String? foodPaired;
  const TastingNoteRow(
      {required this.id,
      required this.wineId,
      required this.date,
      this.appearance,
      this.nose,
      this.palate,
      this.finish,
      this.notes,
      this.rating,
      this.photoPath,
      this.occasion,
      this.foodPaired});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['wine_id'] = Variable<String>(wineId);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || appearance != null) {
      map['appearance'] = Variable<String>(appearance);
    }
    if (!nullToAbsent || nose != null) {
      map['nose'] = Variable<String>(nose);
    }
    if (!nullToAbsent || palate != null) {
      map['palate'] = Variable<String>(palate);
    }
    if (!nullToAbsent || finish != null) {
      map['finish'] = Variable<String>(finish);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || occasion != null) {
      map['occasion'] = Variable<String>(occasion);
    }
    if (!nullToAbsent || foodPaired != null) {
      map['food_paired'] = Variable<String>(foodPaired);
    }
    return map;
  }

  TastingNotesCompanion toCompanion(bool nullToAbsent) {
    return TastingNotesCompanion(
      id: Value(id),
      wineId: Value(wineId),
      date: Value(date),
      appearance: appearance == null && nullToAbsent
          ? const Value.absent()
          : Value(appearance),
      nose: nose == null && nullToAbsent ? const Value.absent() : Value(nose),
      palate:
          palate == null && nullToAbsent ? const Value.absent() : Value(palate),
      finish:
          finish == null && nullToAbsent ? const Value.absent() : Value(finish),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      occasion: occasion == null && nullToAbsent
          ? const Value.absent()
          : Value(occasion),
      foodPaired: foodPaired == null && nullToAbsent
          ? const Value.absent()
          : Value(foodPaired),
    );
  }

  factory TastingNoteRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TastingNoteRow(
      id: serializer.fromJson<String>(json['id']),
      wineId: serializer.fromJson<String>(json['wineId']),
      date: serializer.fromJson<DateTime>(json['date']),
      appearance: serializer.fromJson<String?>(json['appearance']),
      nose: serializer.fromJson<String?>(json['nose']),
      palate: serializer.fromJson<String?>(json['palate']),
      finish: serializer.fromJson<String?>(json['finish']),
      notes: serializer.fromJson<String?>(json['notes']),
      rating: serializer.fromJson<double?>(json['rating']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      occasion: serializer.fromJson<String?>(json['occasion']),
      foodPaired: serializer.fromJson<String?>(json['foodPaired']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'wineId': serializer.toJson<String>(wineId),
      'date': serializer.toJson<DateTime>(date),
      'appearance': serializer.toJson<String?>(appearance),
      'nose': serializer.toJson<String?>(nose),
      'palate': serializer.toJson<String?>(palate),
      'finish': serializer.toJson<String?>(finish),
      'notes': serializer.toJson<String?>(notes),
      'rating': serializer.toJson<double?>(rating),
      'photoPath': serializer.toJson<String?>(photoPath),
      'occasion': serializer.toJson<String?>(occasion),
      'foodPaired': serializer.toJson<String?>(foodPaired),
    };
  }

  TastingNoteRow copyWith(
          {String? id,
          String? wineId,
          DateTime? date,
          Value<String?> appearance = const Value.absent(),
          Value<String?> nose = const Value.absent(),
          Value<String?> palate = const Value.absent(),
          Value<String?> finish = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<double?> rating = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          Value<String?> occasion = const Value.absent(),
          Value<String?> foodPaired = const Value.absent()}) =>
      TastingNoteRow(
        id: id ?? this.id,
        wineId: wineId ?? this.wineId,
        date: date ?? this.date,
        appearance: appearance.present ? appearance.value : this.appearance,
        nose: nose.present ? nose.value : this.nose,
        palate: palate.present ? palate.value : this.palate,
        finish: finish.present ? finish.value : this.finish,
        notes: notes.present ? notes.value : this.notes,
        rating: rating.present ? rating.value : this.rating,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        occasion: occasion.present ? occasion.value : this.occasion,
        foodPaired: foodPaired.present ? foodPaired.value : this.foodPaired,
      );
  TastingNoteRow copyWithCompanion(TastingNotesCompanion data) {
    return TastingNoteRow(
      id: data.id.present ? data.id.value : this.id,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      date: data.date.present ? data.date.value : this.date,
      appearance:
          data.appearance.present ? data.appearance.value : this.appearance,
      nose: data.nose.present ? data.nose.value : this.nose,
      palate: data.palate.present ? data.palate.value : this.palate,
      finish: data.finish.present ? data.finish.value : this.finish,
      notes: data.notes.present ? data.notes.value : this.notes,
      rating: data.rating.present ? data.rating.value : this.rating,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      occasion: data.occasion.present ? data.occasion.value : this.occasion,
      foodPaired:
          data.foodPaired.present ? data.foodPaired.value : this.foodPaired,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TastingNoteRow(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('date: $date, ')
          ..write('appearance: $appearance, ')
          ..write('nose: $nose, ')
          ..write('palate: $palate, ')
          ..write('finish: $finish, ')
          ..write('notes: $notes, ')
          ..write('rating: $rating, ')
          ..write('photoPath: $photoPath, ')
          ..write('occasion: $occasion, ')
          ..write('foodPaired: $foodPaired')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wineId, date, appearance, nose, palate,
      finish, notes, rating, photoPath, occasion, foodPaired);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TastingNoteRow &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.date == this.date &&
          other.appearance == this.appearance &&
          other.nose == this.nose &&
          other.palate == this.palate &&
          other.finish == this.finish &&
          other.notes == this.notes &&
          other.rating == this.rating &&
          other.photoPath == this.photoPath &&
          other.occasion == this.occasion &&
          other.foodPaired == this.foodPaired);
}

class TastingNotesCompanion extends UpdateCompanion<TastingNoteRow> {
  final Value<String> id;
  final Value<String> wineId;
  final Value<DateTime> date;
  final Value<String?> appearance;
  final Value<String?> nose;
  final Value<String?> palate;
  final Value<String?> finish;
  final Value<String?> notes;
  final Value<double?> rating;
  final Value<String?> photoPath;
  final Value<String?> occasion;
  final Value<String?> foodPaired;
  final Value<int> rowid;
  const TastingNotesCompanion({
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.date = const Value.absent(),
    this.appearance = const Value.absent(),
    this.nose = const Value.absent(),
    this.palate = const Value.absent(),
    this.finish = const Value.absent(),
    this.notes = const Value.absent(),
    this.rating = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.occasion = const Value.absent(),
    this.foodPaired = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TastingNotesCompanion.insert({
    required String id,
    required String wineId,
    required DateTime date,
    this.appearance = const Value.absent(),
    this.nose = const Value.absent(),
    this.palate = const Value.absent(),
    this.finish = const Value.absent(),
    this.notes = const Value.absent(),
    this.rating = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.occasion = const Value.absent(),
    this.foodPaired = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        wineId = Value(wineId),
        date = Value(date);
  static Insertable<TastingNoteRow> custom({
    Expression<String>? id,
    Expression<String>? wineId,
    Expression<DateTime>? date,
    Expression<String>? appearance,
    Expression<String>? nose,
    Expression<String>? palate,
    Expression<String>? finish,
    Expression<String>? notes,
    Expression<double>? rating,
    Expression<String>? photoPath,
    Expression<String>? occasion,
    Expression<String>? foodPaired,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (date != null) 'date': date,
      if (appearance != null) 'appearance': appearance,
      if (nose != null) 'nose': nose,
      if (palate != null) 'palate': palate,
      if (finish != null) 'finish': finish,
      if (notes != null) 'notes': notes,
      if (rating != null) 'rating': rating,
      if (photoPath != null) 'photo_path': photoPath,
      if (occasion != null) 'occasion': occasion,
      if (foodPaired != null) 'food_paired': foodPaired,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TastingNotesCompanion copyWith(
      {Value<String>? id,
      Value<String>? wineId,
      Value<DateTime>? date,
      Value<String?>? appearance,
      Value<String?>? nose,
      Value<String?>? palate,
      Value<String?>? finish,
      Value<String?>? notes,
      Value<double?>? rating,
      Value<String?>? photoPath,
      Value<String?>? occasion,
      Value<String?>? foodPaired,
      Value<int>? rowid}) {
    return TastingNotesCompanion(
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      date: date ?? this.date,
      appearance: appearance ?? this.appearance,
      nose: nose ?? this.nose,
      palate: palate ?? this.palate,
      finish: finish ?? this.finish,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
      photoPath: photoPath ?? this.photoPath,
      occasion: occasion ?? this.occasion,
      foodPaired: foodPaired ?? this.foodPaired,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<String>(wineId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (appearance.present) {
      map['appearance'] = Variable<String>(appearance.value);
    }
    if (nose.present) {
      map['nose'] = Variable<String>(nose.value);
    }
    if (palate.present) {
      map['palate'] = Variable<String>(palate.value);
    }
    if (finish.present) {
      map['finish'] = Variable<String>(finish.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (occasion.present) {
      map['occasion'] = Variable<String>(occasion.value);
    }
    if (foodPaired.present) {
      map['food_paired'] = Variable<String>(foodPaired.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TastingNotesCompanion(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('date: $date, ')
          ..write('appearance: $appearance, ')
          ..write('nose: $nose, ')
          ..write('palate: $palate, ')
          ..write('finish: $finish, ')
          ..write('notes: $notes, ')
          ..write('rating: $rating, ')
          ..write('photoPath: $photoPath, ')
          ..write('occasion: $occasion, ')
          ..write('foodPaired: $foodPaired, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrapeCompositionsTable extends GrapeCompositions
    with TableInfo<$GrapeCompositionsTable, GrapeCompositionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrapeCompositionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<String> wineId = GeneratedColumn<String>(
      'wine_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES wines (id) ON DELETE CASCADE'));
  static const VerificationMeta _varietyMeta =
      const VerificationMeta('variety');
  @override
  late final GeneratedColumn<String> variety = GeneratedColumn<String>(
      'variety', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _percentageMeta =
      const VerificationMeta('percentage');
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
      'percentage', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, wineId, variety, percentage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grape_compositions';
  @override
  VerificationContext validateIntegrity(
      Insertable<GrapeCompositionRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wine_id')) {
      context.handle(_wineIdMeta,
          wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta));
    } else if (isInserting) {
      context.missing(_wineIdMeta);
    }
    if (data.containsKey('variety')) {
      context.handle(_varietyMeta,
          variety.isAcceptableOrUnknown(data['variety']!, _varietyMeta));
    } else if (isInserting) {
      context.missing(_varietyMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage']!, _percentageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrapeCompositionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrapeCompositionRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wine_id'])!,
      variety: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variety'])!,
      percentage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}percentage']),
    );
  }

  @override
  $GrapeCompositionsTable createAlias(String alias) {
    return $GrapeCompositionsTable(attachedDatabase, alias);
  }
}

class GrapeCompositionRow extends DataClass
    implements Insertable<GrapeCompositionRow> {
  final int id;
  final String wineId;
  final String variety;
  final double? percentage;
  const GrapeCompositionRow(
      {required this.id,
      required this.wineId,
      required this.variety,
      this.percentage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wine_id'] = Variable<String>(wineId);
    map['variety'] = Variable<String>(variety);
    if (!nullToAbsent || percentage != null) {
      map['percentage'] = Variable<double>(percentage);
    }
    return map;
  }

  GrapeCompositionsCompanion toCompanion(bool nullToAbsent) {
    return GrapeCompositionsCompanion(
      id: Value(id),
      wineId: Value(wineId),
      variety: Value(variety),
      percentage: percentage == null && nullToAbsent
          ? const Value.absent()
          : Value(percentage),
    );
  }

  factory GrapeCompositionRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrapeCompositionRow(
      id: serializer.fromJson<int>(json['id']),
      wineId: serializer.fromJson<String>(json['wineId']),
      variety: serializer.fromJson<String>(json['variety']),
      percentage: serializer.fromJson<double?>(json['percentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wineId': serializer.toJson<String>(wineId),
      'variety': serializer.toJson<String>(variety),
      'percentage': serializer.toJson<double?>(percentage),
    };
  }

  GrapeCompositionRow copyWith(
          {int? id,
          String? wineId,
          String? variety,
          Value<double?> percentage = const Value.absent()}) =>
      GrapeCompositionRow(
        id: id ?? this.id,
        wineId: wineId ?? this.wineId,
        variety: variety ?? this.variety,
        percentage: percentage.present ? percentage.value : this.percentage,
      );
  GrapeCompositionRow copyWithCompanion(GrapeCompositionsCompanion data) {
    return GrapeCompositionRow(
      id: data.id.present ? data.id.value : this.id,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      variety: data.variety.present ? data.variety.value : this.variety,
      percentage:
          data.percentage.present ? data.percentage.value : this.percentage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrapeCompositionRow(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('variety: $variety, ')
          ..write('percentage: $percentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wineId, variety, percentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrapeCompositionRow &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.variety == this.variety &&
          other.percentage == this.percentage);
}

class GrapeCompositionsCompanion extends UpdateCompanion<GrapeCompositionRow> {
  final Value<int> id;
  final Value<String> wineId;
  final Value<String> variety;
  final Value<double?> percentage;
  const GrapeCompositionsCompanion({
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.variety = const Value.absent(),
    this.percentage = const Value.absent(),
  });
  GrapeCompositionsCompanion.insert({
    this.id = const Value.absent(),
    required String wineId,
    required String variety,
    this.percentage = const Value.absent(),
  })  : wineId = Value(wineId),
        variety = Value(variety);
  static Insertable<GrapeCompositionRow> custom({
    Expression<int>? id,
    Expression<String>? wineId,
    Expression<String>? variety,
    Expression<double>? percentage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (variety != null) 'variety': variety,
      if (percentage != null) 'percentage': percentage,
    });
  }

  GrapeCompositionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? wineId,
      Value<String>? variety,
      Value<double?>? percentage}) {
    return GrapeCompositionsCompanion(
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      variety: variety ?? this.variety,
      percentage: percentage ?? this.percentage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<String>(wineId.value);
    }
    if (variety.present) {
      map['variety'] = Variable<String>(variety.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrapeCompositionsCompanion(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('variety: $variety, ')
          ..write('percentage: $percentage')
          ..write(')'))
        .toString();
  }
}

class $WishlistEntriesTable extends WishlistEntries
    with TableInfo<$WishlistEntriesTable, WishlistEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishlistEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _producerMeta =
      const VerificationMeta('producer');
  @override
  late final GeneratedColumn<String> producer = GeneratedColumn<String>(
      'producer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vintageMeta =
      const VerificationMeta('vintage');
  @override
  late final GeneratedColumn<int> vintage = GeneratedColumn<int>(
      'vintage', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _estimatedPriceMeta =
      const VerificationMeta('estimatedPrice');
  @override
  late final GeneratedColumn<double> estimatedPrice = GeneratedColumn<double>(
      'estimated_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, producer, vintage, estimatedPrice, priority, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishlist_entries';
  @override
  VerificationContext validateIntegrity(Insertable<WishlistEntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('producer')) {
      context.handle(_producerMeta,
          producer.isAcceptableOrUnknown(data['producer']!, _producerMeta));
    }
    if (data.containsKey('vintage')) {
      context.handle(_vintageMeta,
          vintage.isAcceptableOrUnknown(data['vintage']!, _vintageMeta));
    }
    if (data.containsKey('estimated_price')) {
      context.handle(
          _estimatedPriceMeta,
          estimatedPrice.isAcceptableOrUnknown(
              data['estimated_price']!, _estimatedPriceMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishlistEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishlistEntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      producer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}producer']),
      vintage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vintage']),
      estimatedPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}estimated_price']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $WishlistEntriesTable createAlias(String alias) {
    return $WishlistEntriesTable(attachedDatabase, alias);
  }
}

class WishlistEntryRow extends DataClass
    implements Insertable<WishlistEntryRow> {
  final String id;
  final String name;
  final String? producer;
  final int? vintage;
  final double? estimatedPrice;
  final int priority;
  final String? notes;
  final DateTime createdAt;
  const WishlistEntryRow(
      {required this.id,
      required this.name,
      this.producer,
      this.vintage,
      this.estimatedPrice,
      required this.priority,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || producer != null) {
      map['producer'] = Variable<String>(producer);
    }
    if (!nullToAbsent || vintage != null) {
      map['vintage'] = Variable<int>(vintage);
    }
    if (!nullToAbsent || estimatedPrice != null) {
      map['estimated_price'] = Variable<double>(estimatedPrice);
    }
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WishlistEntriesCompanion toCompanion(bool nullToAbsent) {
    return WishlistEntriesCompanion(
      id: Value(id),
      name: Value(name),
      producer: producer == null && nullToAbsent
          ? const Value.absent()
          : Value(producer),
      vintage: vintage == null && nullToAbsent
          ? const Value.absent()
          : Value(vintage),
      estimatedPrice: estimatedPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedPrice),
      priority: Value(priority),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory WishlistEntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishlistEntryRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      producer: serializer.fromJson<String?>(json['producer']),
      vintage: serializer.fromJson<int?>(json['vintage']),
      estimatedPrice: serializer.fromJson<double?>(json['estimatedPrice']),
      priority: serializer.fromJson<int>(json['priority']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'producer': serializer.toJson<String?>(producer),
      'vintage': serializer.toJson<int?>(vintage),
      'estimatedPrice': serializer.toJson<double?>(estimatedPrice),
      'priority': serializer.toJson<int>(priority),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WishlistEntryRow copyWith(
          {String? id,
          String? name,
          Value<String?> producer = const Value.absent(),
          Value<int?> vintage = const Value.absent(),
          Value<double?> estimatedPrice = const Value.absent(),
          int? priority,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      WishlistEntryRow(
        id: id ?? this.id,
        name: name ?? this.name,
        producer: producer.present ? producer.value : this.producer,
        vintage: vintage.present ? vintage.value : this.vintage,
        estimatedPrice:
            estimatedPrice.present ? estimatedPrice.value : this.estimatedPrice,
        priority: priority ?? this.priority,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  WishlistEntryRow copyWithCompanion(WishlistEntriesCompanion data) {
    return WishlistEntryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      producer: data.producer.present ? data.producer.value : this.producer,
      vintage: data.vintage.present ? data.vintage.value : this.vintage,
      estimatedPrice: data.estimatedPrice.present
          ? data.estimatedPrice.value
          : this.estimatedPrice,
      priority: data.priority.present ? data.priority.value : this.priority,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishlistEntryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('producer: $producer, ')
          ..write('vintage: $vintage, ')
          ..write('estimatedPrice: $estimatedPrice, ')
          ..write('priority: $priority, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, producer, vintage, estimatedPrice, priority, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishlistEntryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.producer == this.producer &&
          other.vintage == this.vintage &&
          other.estimatedPrice == this.estimatedPrice &&
          other.priority == this.priority &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class WishlistEntriesCompanion extends UpdateCompanion<WishlistEntryRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> producer;
  final Value<int?> vintage;
  final Value<double?> estimatedPrice;
  final Value<int> priority;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WishlistEntriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.producer = const Value.absent(),
    this.vintage = const Value.absent(),
    this.estimatedPrice = const Value.absent(),
    this.priority = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WishlistEntriesCompanion.insert({
    required String id,
    required String name,
    this.producer = const Value.absent(),
    this.vintage = const Value.absent(),
    this.estimatedPrice = const Value.absent(),
    this.priority = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<WishlistEntryRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? producer,
    Expression<int>? vintage,
    Expression<double>? estimatedPrice,
    Expression<int>? priority,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (producer != null) 'producer': producer,
      if (vintage != null) 'vintage': vintage,
      if (estimatedPrice != null) 'estimated_price': estimatedPrice,
      if (priority != null) 'priority': priority,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WishlistEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? producer,
      Value<int?>? vintage,
      Value<double?>? estimatedPrice,
      Value<int>? priority,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return WishlistEntriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      producer: producer ?? this.producer,
      vintage: vintage ?? this.vintage,
      estimatedPrice: estimatedPrice ?? this.estimatedPrice,
      priority: priority ?? this.priority,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (producer.present) {
      map['producer'] = Variable<String>(producer.value);
    }
    if (vintage.present) {
      map['vintage'] = Variable<int>(vintage.value);
    }
    if (estimatedPrice.present) {
      map['estimated_price'] = Variable<double>(estimatedPrice.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistEntriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('producer: $producer, ')
          ..write('vintage: $vintage, ')
          ..write('estimatedPrice: $estimatedPrice, ')
          ..write('priority: $priority, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CellarsTable cellars = $CellarsTable(this);
  late final $WinesTable wines = $WinesTable(this);
  late final $CellarSlotsTable cellarSlots = $CellarSlotsTable(this);
  late final $TastingNotesTable tastingNotes = $TastingNotesTable(this);
  late final $GrapeCompositionsTable grapeCompositions =
      $GrapeCompositionsTable(this);
  late final $WishlistEntriesTable wishlistEntries =
      $WishlistEntriesTable(this);
  late final WineDao wineDao = WineDao(this as AppDatabase);
  late final CellarDao cellarDao = CellarDao(this as AppDatabase);
  late final StatsDao statsDao = StatsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        cellars,
        wines,
        cellarSlots,
        tastingNotes,
        grapeCompositions,
        wishlistEntries
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('cellars',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('wines', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('cellars',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('cellar_slots', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('wines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('cellar_slots', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('wines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('tasting_notes', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('wines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('grape_compositions', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$CellarsTableCreateCompanionBuilder = CellarsCompanion Function({
  required String id,
  required String name,
  required CellarType type,
  required int rows,
  required int columns,
  Value<int> depth,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$CellarsTableUpdateCompanionBuilder = CellarsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<CellarType> type,
  Value<int> rows,
  Value<int> columns,
  Value<int> depth,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$CellarsTableReferences
    extends BaseReferences<_$AppDatabase, $CellarsTable, CellarRow> {
  $$CellarsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WinesTable, List<WineRow>> _winesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.wines,
          aliasName: $_aliasNameGenerator(db.cellars.id, db.wines.cellarId));

  $$WinesTableProcessedTableManager get winesRefs {
    final manager = $$WinesTableTableManager($_db, $_db.wines)
        .filter((f) => f.cellarId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_winesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CellarSlotsTable, List<CellarSlotRow>>
      _cellarSlotsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.cellarSlots,
              aliasName:
                  $_aliasNameGenerator(db.cellars.id, db.cellarSlots.cellarId));

  $$CellarSlotsTableProcessedTableManager get cellarSlotsRefs {
    final manager = $$CellarSlotsTableTableManager($_db, $_db.cellarSlots)
        .filter((f) => f.cellarId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cellarSlotsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CellarsTableFilterComposer
    extends Composer<_$AppDatabase, $CellarsTable> {
  $$CellarsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CellarType, CellarType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get rows => $composableBuilder(
      column: $table.rows, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get columns => $composableBuilder(
      column: $table.columns, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get depth => $composableBuilder(
      column: $table.depth, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> winesRefs(
      Expression<bool> Function($$WinesTableFilterComposer f) f) {
    final $$WinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.cellarId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableFilterComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> cellarSlotsRefs(
      Expression<bool> Function($$CellarSlotsTableFilterComposer f) f) {
    final $$CellarSlotsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cellarSlots,
        getReferencedColumn: (t) => t.cellarId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CellarSlotsTableFilterComposer(
              $db: $db,
              $table: $db.cellarSlots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CellarsTableOrderingComposer
    extends Composer<_$AppDatabase, $CellarsTable> {
  $$CellarsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rows => $composableBuilder(
      column: $table.rows, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get columns => $composableBuilder(
      column: $table.columns, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get depth => $composableBuilder(
      column: $table.depth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CellarsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CellarsTable> {
  $$CellarsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CellarType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get rows =>
      $composableBuilder(column: $table.rows, builder: (column) => column);

  GeneratedColumn<int> get columns =>
      $composableBuilder(column: $table.columns, builder: (column) => column);

  GeneratedColumn<int> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> winesRefs<T extends Object>(
      Expression<T> Function($$WinesTableAnnotationComposer a) f) {
    final $$WinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.cellarId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableAnnotationComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> cellarSlotsRefs<T extends Object>(
      Expression<T> Function($$CellarSlotsTableAnnotationComposer a) f) {
    final $$CellarSlotsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cellarSlots,
        getReferencedColumn: (t) => t.cellarId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CellarSlotsTableAnnotationComposer(
              $db: $db,
              $table: $db.cellarSlots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CellarsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CellarsTable,
    CellarRow,
    $$CellarsTableFilterComposer,
    $$CellarsTableOrderingComposer,
    $$CellarsTableAnnotationComposer,
    $$CellarsTableCreateCompanionBuilder,
    $$CellarsTableUpdateCompanionBuilder,
    (CellarRow, $$CellarsTableReferences),
    CellarRow,
    PrefetchHooks Function({bool winesRefs, bool cellarSlotsRefs})> {
  $$CellarsTableTableManager(_$AppDatabase db, $CellarsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CellarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CellarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CellarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<CellarType> type = const Value.absent(),
            Value<int> rows = const Value.absent(),
            Value<int> columns = const Value.absent(),
            Value<int> depth = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CellarsCompanion(
            id: id,
            name: name,
            type: type,
            rows: rows,
            columns: columns,
            depth: depth,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required CellarType type,
            required int rows,
            required int columns,
            Value<int> depth = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CellarsCompanion.insert(
            id: id,
            name: name,
            type: type,
            rows: rows,
            columns: columns,
            depth: depth,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CellarsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {winesRefs = false, cellarSlotsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (winesRefs) db.wines,
                if (cellarSlotsRefs) db.cellarSlots
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (winesRefs)
                    await $_getPrefetchedData<CellarRow, $CellarsTable,
                            WineRow>(
                        currentTable: table,
                        referencedTable:
                            $$CellarsTableReferences._winesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CellarsTableReferences(db, table, p0).winesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cellarId == item.id),
                        typedResults: items),
                  if (cellarSlotsRefs)
                    await $_getPrefetchedData<CellarRow, $CellarsTable,
                            CellarSlotRow>(
                        currentTable: table,
                        referencedTable:
                            $$CellarsTableReferences._cellarSlotsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CellarsTableReferences(db, table, p0)
                                .cellarSlotsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cellarId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CellarsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CellarsTable,
    CellarRow,
    $$CellarsTableFilterComposer,
    $$CellarsTableOrderingComposer,
    $$CellarsTableAnnotationComposer,
    $$CellarsTableCreateCompanionBuilder,
    $$CellarsTableUpdateCompanionBuilder,
    (CellarRow, $$CellarsTableReferences),
    CellarRow,
    PrefetchHooks Function({bool winesRefs, bool cellarSlotsRefs})>;
typedef $$WinesTableCreateCompanionBuilder = WinesCompanion Function({
  required String id,
  required String name,
  Value<int?> vintage,
  Value<String?> labelImagePath,
  required WineType type,
  Value<String?> country,
  Value<String?> region,
  Value<String?> subRegion,
  Value<String?> appellation,
  Value<String?> producer,
  Value<String?> winemaker,
  Value<double?> alcoholContent,
  Value<int?> bodyScore,
  Value<int?> tanninLevel,
  Value<int?> acidityLevel,
  Value<int?> sweetnessLevel,
  Value<int?> drinkFrom,
  Value<int?> drinkUntil,
  Value<int?> peakFrom,
  Value<int?> peakUntil,
  Value<AgingPotential?> agingPotential,
  Value<int> quantity,
  Value<DateTime?> purchaseDate,
  Value<double?> purchasePrice,
  Value<String?> purchaseLocation,
  Value<String?> cellarId,
  Value<int?> rackRow,
  Value<int?> rackColumn,
  Value<int?> rackDepth,
  Value<double?> userRating,
  Value<String?> tastingNotes,
  Value<String?> personalNotes,
  Value<String> tags,
  Value<String> foodPairings,
  Value<bool> isFavorite,
  required DateTime createdAt,
  required DateTime updatedAt,
  required WineSource source,
  Value<int> rowid,
});
typedef $$WinesTableUpdateCompanionBuilder = WinesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int?> vintage,
  Value<String?> labelImagePath,
  Value<WineType> type,
  Value<String?> country,
  Value<String?> region,
  Value<String?> subRegion,
  Value<String?> appellation,
  Value<String?> producer,
  Value<String?> winemaker,
  Value<double?> alcoholContent,
  Value<int?> bodyScore,
  Value<int?> tanninLevel,
  Value<int?> acidityLevel,
  Value<int?> sweetnessLevel,
  Value<int?> drinkFrom,
  Value<int?> drinkUntil,
  Value<int?> peakFrom,
  Value<int?> peakUntil,
  Value<AgingPotential?> agingPotential,
  Value<int> quantity,
  Value<DateTime?> purchaseDate,
  Value<double?> purchasePrice,
  Value<String?> purchaseLocation,
  Value<String?> cellarId,
  Value<int?> rackRow,
  Value<int?> rackColumn,
  Value<int?> rackDepth,
  Value<double?> userRating,
  Value<String?> tastingNotes,
  Value<String?> personalNotes,
  Value<String> tags,
  Value<String> foodPairings,
  Value<bool> isFavorite,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<WineSource> source,
  Value<int> rowid,
});

final class $$WinesTableReferences
    extends BaseReferences<_$AppDatabase, $WinesTable, WineRow> {
  $$WinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CellarsTable _cellarIdTable(_$AppDatabase db) => db.cellars
      .createAlias($_aliasNameGenerator(db.wines.cellarId, db.cellars.id));

  $$CellarsTableProcessedTableManager? get cellarId {
    final $_column = $_itemColumn<String>('cellar_id');
    if ($_column == null) return null;
    final manager = $$CellarsTableTableManager($_db, $_db.cellars)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cellarIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$CellarSlotsTable, List<CellarSlotRow>>
      _cellarSlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.cellarSlots,
          aliasName: $_aliasNameGenerator(db.wines.id, db.cellarSlots.wineId));

  $$CellarSlotsTableProcessedTableManager get cellarSlotsRefs {
    final manager = $$CellarSlotsTableTableManager($_db, $_db.cellarSlots)
        .filter((f) => f.wineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cellarSlotsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TastingNotesTable, List<TastingNoteRow>>
      _tastingNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.tastingNotes,
          aliasName: $_aliasNameGenerator(db.wines.id, db.tastingNotes.wineId));

  $$TastingNotesTableProcessedTableManager get tastingNotesRefs {
    final manager = $$TastingNotesTableTableManager($_db, $_db.tastingNotes)
        .filter((f) => f.wineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tastingNotesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GrapeCompositionsTable, List<GrapeCompositionRow>>
      _grapeCompositionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.grapeCompositions,
              aliasName: $_aliasNameGenerator(
                  db.wines.id, db.grapeCompositions.wineId));

  $$GrapeCompositionsTableProcessedTableManager get grapeCompositionsRefs {
    final manager =
        $$GrapeCompositionsTableTableManager($_db, $_db.grapeCompositions)
            .filter((f) => f.wineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_grapeCompositionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WinesTableFilterComposer extends Composer<_$AppDatabase, $WinesTable> {
  $$WinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vintage => $composableBuilder(
      column: $table.vintage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get labelImagePath => $composableBuilder(
      column: $table.labelImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<WineType, WineType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subRegion => $composableBuilder(
      column: $table.subRegion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get appellation => $composableBuilder(
      column: $table.appellation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get producer => $composableBuilder(
      column: $table.producer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get winemaker => $composableBuilder(
      column: $table.winemaker, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get alcoholContent => $composableBuilder(
      column: $table.alcoholContent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bodyScore => $composableBuilder(
      column: $table.bodyScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tanninLevel => $composableBuilder(
      column: $table.tanninLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get acidityLevel => $composableBuilder(
      column: $table.acidityLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sweetnessLevel => $composableBuilder(
      column: $table.sweetnessLevel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get drinkFrom => $composableBuilder(
      column: $table.drinkFrom, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get drinkUntil => $composableBuilder(
      column: $table.drinkUntil, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get peakFrom => $composableBuilder(
      column: $table.peakFrom, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get peakUntil => $composableBuilder(
      column: $table.peakUntil, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<AgingPotential?, AgingPotential, String>
      get agingPotential => $composableBuilder(
          column: $table.agingPotential,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get purchasePrice => $composableBuilder(
      column: $table.purchasePrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get purchaseLocation => $composableBuilder(
      column: $table.purchaseLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rackRow => $composableBuilder(
      column: $table.rackRow, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rackColumn => $composableBuilder(
      column: $table.rackColumn, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rackDepth => $composableBuilder(
      column: $table.rackDepth, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get userRating => $composableBuilder(
      column: $table.userRating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tastingNotes => $composableBuilder(
      column: $table.tastingNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get personalNotes => $composableBuilder(
      column: $table.personalNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodPairings => $composableBuilder(
      column: $table.foodPairings, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<WineSource, WineSource, String> get source =>
      $composableBuilder(
          column: $table.source,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$CellarsTableFilterComposer get cellarId {
    final $$CellarsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cellarId,
        referencedTable: $db.cellars,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CellarsTableFilterComposer(
              $db: $db,
              $table: $db.cellars,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> cellarSlotsRefs(
      Expression<bool> Function($$CellarSlotsTableFilterComposer f) f) {
    final $$CellarSlotsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cellarSlots,
        getReferencedColumn: (t) => t.wineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CellarSlotsTableFilterComposer(
              $db: $db,
              $table: $db.cellarSlots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> tastingNotesRefs(
      Expression<bool> Function($$TastingNotesTableFilterComposer f) f) {
    final $$TastingNotesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tastingNotes,
        getReferencedColumn: (t) => t.wineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TastingNotesTableFilterComposer(
              $db: $db,
              $table: $db.tastingNotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> grapeCompositionsRefs(
      Expression<bool> Function($$GrapeCompositionsTableFilterComposer f) f) {
    final $$GrapeCompositionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.grapeCompositions,
        getReferencedColumn: (t) => t.wineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GrapeCompositionsTableFilterComposer(
              $db: $db,
              $table: $db.grapeCompositions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WinesTableOrderingComposer
    extends Composer<_$AppDatabase, $WinesTable> {
  $$WinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vintage => $composableBuilder(
      column: $table.vintage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get labelImagePath => $composableBuilder(
      column: $table.labelImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subRegion => $composableBuilder(
      column: $table.subRegion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appellation => $composableBuilder(
      column: $table.appellation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get producer => $composableBuilder(
      column: $table.producer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get winemaker => $composableBuilder(
      column: $table.winemaker, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get alcoholContent => $composableBuilder(
      column: $table.alcoholContent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bodyScore => $composableBuilder(
      column: $table.bodyScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tanninLevel => $composableBuilder(
      column: $table.tanninLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get acidityLevel => $composableBuilder(
      column: $table.acidityLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sweetnessLevel => $composableBuilder(
      column: $table.sweetnessLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get drinkFrom => $composableBuilder(
      column: $table.drinkFrom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get drinkUntil => $composableBuilder(
      column: $table.drinkUntil, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get peakFrom => $composableBuilder(
      column: $table.peakFrom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get peakUntil => $composableBuilder(
      column: $table.peakUntil, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get agingPotential => $composableBuilder(
      column: $table.agingPotential,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
      column: $table.purchasePrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get purchaseLocation => $composableBuilder(
      column: $table.purchaseLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rackRow => $composableBuilder(
      column: $table.rackRow, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rackColumn => $composableBuilder(
      column: $table.rackColumn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rackDepth => $composableBuilder(
      column: $table.rackDepth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get userRating => $composableBuilder(
      column: $table.userRating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tastingNotes => $composableBuilder(
      column: $table.tastingNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get personalNotes => $composableBuilder(
      column: $table.personalNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodPairings => $composableBuilder(
      column: $table.foodPairings,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  $$CellarsTableOrderingComposer get cellarId {
    final $$CellarsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cellarId,
        referencedTable: $db.cellars,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CellarsTableOrderingComposer(
              $db: $db,
              $table: $db.cellars,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WinesTable> {
  $$WinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get vintage =>
      $composableBuilder(column: $table.vintage, builder: (column) => column);

  GeneratedColumn<String> get labelImagePath => $composableBuilder(
      column: $table.labelImagePath, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WineType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get subRegion =>
      $composableBuilder(column: $table.subRegion, builder: (column) => column);

  GeneratedColumn<String> get appellation => $composableBuilder(
      column: $table.appellation, builder: (column) => column);

  GeneratedColumn<String> get producer =>
      $composableBuilder(column: $table.producer, builder: (column) => column);

  GeneratedColumn<String> get winemaker =>
      $composableBuilder(column: $table.winemaker, builder: (column) => column);

  GeneratedColumn<double> get alcoholContent => $composableBuilder(
      column: $table.alcoholContent, builder: (column) => column);

  GeneratedColumn<int> get bodyScore =>
      $composableBuilder(column: $table.bodyScore, builder: (column) => column);

  GeneratedColumn<int> get tanninLevel => $composableBuilder(
      column: $table.tanninLevel, builder: (column) => column);

  GeneratedColumn<int> get acidityLevel => $composableBuilder(
      column: $table.acidityLevel, builder: (column) => column);

  GeneratedColumn<int> get sweetnessLevel => $composableBuilder(
      column: $table.sweetnessLevel, builder: (column) => column);

  GeneratedColumn<int> get drinkFrom =>
      $composableBuilder(column: $table.drinkFrom, builder: (column) => column);

  GeneratedColumn<int> get drinkUntil => $composableBuilder(
      column: $table.drinkUntil, builder: (column) => column);

  GeneratedColumn<int> get peakFrom =>
      $composableBuilder(column: $table.peakFrom, builder: (column) => column);

  GeneratedColumn<int> get peakUntil =>
      $composableBuilder(column: $table.peakUntil, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AgingPotential?, String>
      get agingPotential => $composableBuilder(
          column: $table.agingPotential, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
      column: $table.purchasePrice, builder: (column) => column);

  GeneratedColumn<String> get purchaseLocation => $composableBuilder(
      column: $table.purchaseLocation, builder: (column) => column);

  GeneratedColumn<int> get rackRow =>
      $composableBuilder(column: $table.rackRow, builder: (column) => column);

  GeneratedColumn<int> get rackColumn => $composableBuilder(
      column: $table.rackColumn, builder: (column) => column);

  GeneratedColumn<int> get rackDepth =>
      $composableBuilder(column: $table.rackDepth, builder: (column) => column);

  GeneratedColumn<double> get userRating => $composableBuilder(
      column: $table.userRating, builder: (column) => column);

  GeneratedColumn<String> get tastingNotes => $composableBuilder(
      column: $table.tastingNotes, builder: (column) => column);

  GeneratedColumn<String> get personalNotes => $composableBuilder(
      column: $table.personalNotes, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get foodPairings => $composableBuilder(
      column: $table.foodPairings, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WineSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$CellarsTableAnnotationComposer get cellarId {
    final $$CellarsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cellarId,
        referencedTable: $db.cellars,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CellarsTableAnnotationComposer(
              $db: $db,
              $table: $db.cellars,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> cellarSlotsRefs<T extends Object>(
      Expression<T> Function($$CellarSlotsTableAnnotationComposer a) f) {
    final $$CellarSlotsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cellarSlots,
        getReferencedColumn: (t) => t.wineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CellarSlotsTableAnnotationComposer(
              $db: $db,
              $table: $db.cellarSlots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> tastingNotesRefs<T extends Object>(
      Expression<T> Function($$TastingNotesTableAnnotationComposer a) f) {
    final $$TastingNotesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tastingNotes,
        getReferencedColumn: (t) => t.wineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TastingNotesTableAnnotationComposer(
              $db: $db,
              $table: $db.tastingNotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> grapeCompositionsRefs<T extends Object>(
      Expression<T> Function($$GrapeCompositionsTableAnnotationComposer a) f) {
    final $$GrapeCompositionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.grapeCompositions,
            getReferencedColumn: (t) => t.wineId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GrapeCompositionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.grapeCompositions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$WinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WinesTable,
    WineRow,
    $$WinesTableFilterComposer,
    $$WinesTableOrderingComposer,
    $$WinesTableAnnotationComposer,
    $$WinesTableCreateCompanionBuilder,
    $$WinesTableUpdateCompanionBuilder,
    (WineRow, $$WinesTableReferences),
    WineRow,
    PrefetchHooks Function(
        {bool cellarId,
        bool cellarSlotsRefs,
        bool tastingNotesRefs,
        bool grapeCompositionsRefs})> {
  $$WinesTableTableManager(_$AppDatabase db, $WinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int?> vintage = const Value.absent(),
            Value<String?> labelImagePath = const Value.absent(),
            Value<WineType> type = const Value.absent(),
            Value<String?> country = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<String?> subRegion = const Value.absent(),
            Value<String?> appellation = const Value.absent(),
            Value<String?> producer = const Value.absent(),
            Value<String?> winemaker = const Value.absent(),
            Value<double?> alcoholContent = const Value.absent(),
            Value<int?> bodyScore = const Value.absent(),
            Value<int?> tanninLevel = const Value.absent(),
            Value<int?> acidityLevel = const Value.absent(),
            Value<int?> sweetnessLevel = const Value.absent(),
            Value<int?> drinkFrom = const Value.absent(),
            Value<int?> drinkUntil = const Value.absent(),
            Value<int?> peakFrom = const Value.absent(),
            Value<int?> peakUntil = const Value.absent(),
            Value<AgingPotential?> agingPotential = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<DateTime?> purchaseDate = const Value.absent(),
            Value<double?> purchasePrice = const Value.absent(),
            Value<String?> purchaseLocation = const Value.absent(),
            Value<String?> cellarId = const Value.absent(),
            Value<int?> rackRow = const Value.absent(),
            Value<int?> rackColumn = const Value.absent(),
            Value<int?> rackDepth = const Value.absent(),
            Value<double?> userRating = const Value.absent(),
            Value<String?> tastingNotes = const Value.absent(),
            Value<String?> personalNotes = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<String> foodPairings = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<WineSource> source = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WinesCompanion(
            id: id,
            name: name,
            vintage: vintage,
            labelImagePath: labelImagePath,
            type: type,
            country: country,
            region: region,
            subRegion: subRegion,
            appellation: appellation,
            producer: producer,
            winemaker: winemaker,
            alcoholContent: alcoholContent,
            bodyScore: bodyScore,
            tanninLevel: tanninLevel,
            acidityLevel: acidityLevel,
            sweetnessLevel: sweetnessLevel,
            drinkFrom: drinkFrom,
            drinkUntil: drinkUntil,
            peakFrom: peakFrom,
            peakUntil: peakUntil,
            agingPotential: agingPotential,
            quantity: quantity,
            purchaseDate: purchaseDate,
            purchasePrice: purchasePrice,
            purchaseLocation: purchaseLocation,
            cellarId: cellarId,
            rackRow: rackRow,
            rackColumn: rackColumn,
            rackDepth: rackDepth,
            userRating: userRating,
            tastingNotes: tastingNotes,
            personalNotes: personalNotes,
            tags: tags,
            foodPairings: foodPairings,
            isFavorite: isFavorite,
            createdAt: createdAt,
            updatedAt: updatedAt,
            source: source,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int?> vintage = const Value.absent(),
            Value<String?> labelImagePath = const Value.absent(),
            required WineType type,
            Value<String?> country = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<String?> subRegion = const Value.absent(),
            Value<String?> appellation = const Value.absent(),
            Value<String?> producer = const Value.absent(),
            Value<String?> winemaker = const Value.absent(),
            Value<double?> alcoholContent = const Value.absent(),
            Value<int?> bodyScore = const Value.absent(),
            Value<int?> tanninLevel = const Value.absent(),
            Value<int?> acidityLevel = const Value.absent(),
            Value<int?> sweetnessLevel = const Value.absent(),
            Value<int?> drinkFrom = const Value.absent(),
            Value<int?> drinkUntil = const Value.absent(),
            Value<int?> peakFrom = const Value.absent(),
            Value<int?> peakUntil = const Value.absent(),
            Value<AgingPotential?> agingPotential = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<DateTime?> purchaseDate = const Value.absent(),
            Value<double?> purchasePrice = const Value.absent(),
            Value<String?> purchaseLocation = const Value.absent(),
            Value<String?> cellarId = const Value.absent(),
            Value<int?> rackRow = const Value.absent(),
            Value<int?> rackColumn = const Value.absent(),
            Value<int?> rackDepth = const Value.absent(),
            Value<double?> userRating = const Value.absent(),
            Value<String?> tastingNotes = const Value.absent(),
            Value<String?> personalNotes = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<String> foodPairings = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            required WineSource source,
            Value<int> rowid = const Value.absent(),
          }) =>
              WinesCompanion.insert(
            id: id,
            name: name,
            vintage: vintage,
            labelImagePath: labelImagePath,
            type: type,
            country: country,
            region: region,
            subRegion: subRegion,
            appellation: appellation,
            producer: producer,
            winemaker: winemaker,
            alcoholContent: alcoholContent,
            bodyScore: bodyScore,
            tanninLevel: tanninLevel,
            acidityLevel: acidityLevel,
            sweetnessLevel: sweetnessLevel,
            drinkFrom: drinkFrom,
            drinkUntil: drinkUntil,
            peakFrom: peakFrom,
            peakUntil: peakUntil,
            agingPotential: agingPotential,
            quantity: quantity,
            purchaseDate: purchaseDate,
            purchasePrice: purchasePrice,
            purchaseLocation: purchaseLocation,
            cellarId: cellarId,
            rackRow: rackRow,
            rackColumn: rackColumn,
            rackDepth: rackDepth,
            userRating: userRating,
            tastingNotes: tastingNotes,
            personalNotes: personalNotes,
            tags: tags,
            foodPairings: foodPairings,
            isFavorite: isFavorite,
            createdAt: createdAt,
            updatedAt: updatedAt,
            source: source,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WinesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {cellarId = false,
              cellarSlotsRefs = false,
              tastingNotesRefs = false,
              grapeCompositionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cellarSlotsRefs) db.cellarSlots,
                if (tastingNotesRefs) db.tastingNotes,
                if (grapeCompositionsRefs) db.grapeCompositions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (cellarId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cellarId,
                    referencedTable: $$WinesTableReferences._cellarIdTable(db),
                    referencedColumn:
                        $$WinesTableReferences._cellarIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cellarSlotsRefs)
                    await $_getPrefetchedData<WineRow, $WinesTable,
                            CellarSlotRow>(
                        currentTable: table,
                        referencedTable:
                            $$WinesTableReferences._cellarSlotsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WinesTableReferences(db, table, p0)
                                .cellarSlotsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wineId == item.id),
                        typedResults: items),
                  if (tastingNotesRefs)
                    await $_getPrefetchedData<WineRow, $WinesTable,
                            TastingNoteRow>(
                        currentTable: table,
                        referencedTable:
                            $$WinesTableReferences._tastingNotesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WinesTableReferences(db, table, p0)
                                .tastingNotesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wineId == item.id),
                        typedResults: items),
                  if (grapeCompositionsRefs)
                    await $_getPrefetchedData<WineRow, $WinesTable,
                            GrapeCompositionRow>(
                        currentTable: table,
                        referencedTable: $$WinesTableReferences
                            ._grapeCompositionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WinesTableReferences(db, table, p0)
                                .grapeCompositionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wineId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WinesTable,
    WineRow,
    $$WinesTableFilterComposer,
    $$WinesTableOrderingComposer,
    $$WinesTableAnnotationComposer,
    $$WinesTableCreateCompanionBuilder,
    $$WinesTableUpdateCompanionBuilder,
    (WineRow, $$WinesTableReferences),
    WineRow,
    PrefetchHooks Function(
        {bool cellarId,
        bool cellarSlotsRefs,
        bool tastingNotesRefs,
        bool grapeCompositionsRefs})>;
typedef $$CellarSlotsTableCreateCompanionBuilder = CellarSlotsCompanion
    Function({
  required String cellarId,
  required int row,
  required int column,
  required int depth,
  Value<String?> wineId,
  Value<bool> isBlocked,
  Value<int> rowid,
});
typedef $$CellarSlotsTableUpdateCompanionBuilder = CellarSlotsCompanion
    Function({
  Value<String> cellarId,
  Value<int> row,
  Value<int> column,
  Value<int> depth,
  Value<String?> wineId,
  Value<bool> isBlocked,
  Value<int> rowid,
});

final class $$CellarSlotsTableReferences
    extends BaseReferences<_$AppDatabase, $CellarSlotsTable, CellarSlotRow> {
  $$CellarSlotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CellarsTable _cellarIdTable(_$AppDatabase db) =>
      db.cellars.createAlias(
          $_aliasNameGenerator(db.cellarSlots.cellarId, db.cellars.id));

  $$CellarsTableProcessedTableManager get cellarId {
    final $_column = $_itemColumn<String>('cellar_id')!;

    final manager = $$CellarsTableTableManager($_db, $_db.cellars)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cellarIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $WinesTable _wineIdTable(_$AppDatabase db) => db.wines
      .createAlias($_aliasNameGenerator(db.cellarSlots.wineId, db.wines.id));

  $$WinesTableProcessedTableManager? get wineId {
    final $_column = $_itemColumn<String>('wine_id');
    if ($_column == null) return null;
    final manager = $$WinesTableTableManager($_db, $_db.wines)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CellarSlotsTableFilterComposer
    extends Composer<_$AppDatabase, $CellarSlotsTable> {
  $$CellarSlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get row => $composableBuilder(
      column: $table.row, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get column => $composableBuilder(
      column: $table.column, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get depth => $composableBuilder(
      column: $table.depth, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isBlocked => $composableBuilder(
      column: $table.isBlocked, builder: (column) => ColumnFilters(column));

  $$CellarsTableFilterComposer get cellarId {
    final $$CellarsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cellarId,
        referencedTable: $db.cellars,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CellarsTableFilterComposer(
              $db: $db,
              $table: $db.cellars,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$WinesTableFilterComposer get wineId {
    final $$WinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableFilterComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CellarSlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $CellarSlotsTable> {
  $$CellarSlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get row => $composableBuilder(
      column: $table.row, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get column => $composableBuilder(
      column: $table.column, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get depth => $composableBuilder(
      column: $table.depth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBlocked => $composableBuilder(
      column: $table.isBlocked, builder: (column) => ColumnOrderings(column));

  $$CellarsTableOrderingComposer get cellarId {
    final $$CellarsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cellarId,
        referencedTable: $db.cellars,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CellarsTableOrderingComposer(
              $db: $db,
              $table: $db.cellars,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$WinesTableOrderingComposer get wineId {
    final $$WinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableOrderingComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CellarSlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CellarSlotsTable> {
  $$CellarSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get row =>
      $composableBuilder(column: $table.row, builder: (column) => column);

  GeneratedColumn<int> get column =>
      $composableBuilder(column: $table.column, builder: (column) => column);

  GeneratedColumn<int> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);

  GeneratedColumn<bool> get isBlocked =>
      $composableBuilder(column: $table.isBlocked, builder: (column) => column);

  $$CellarsTableAnnotationComposer get cellarId {
    final $$CellarsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cellarId,
        referencedTable: $db.cellars,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CellarsTableAnnotationComposer(
              $db: $db,
              $table: $db.cellars,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$WinesTableAnnotationComposer get wineId {
    final $$WinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableAnnotationComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CellarSlotsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CellarSlotsTable,
    CellarSlotRow,
    $$CellarSlotsTableFilterComposer,
    $$CellarSlotsTableOrderingComposer,
    $$CellarSlotsTableAnnotationComposer,
    $$CellarSlotsTableCreateCompanionBuilder,
    $$CellarSlotsTableUpdateCompanionBuilder,
    (CellarSlotRow, $$CellarSlotsTableReferences),
    CellarSlotRow,
    PrefetchHooks Function({bool cellarId, bool wineId})> {
  $$CellarSlotsTableTableManager(_$AppDatabase db, $CellarSlotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CellarSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CellarSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CellarSlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> cellarId = const Value.absent(),
            Value<int> row = const Value.absent(),
            Value<int> column = const Value.absent(),
            Value<int> depth = const Value.absent(),
            Value<String?> wineId = const Value.absent(),
            Value<bool> isBlocked = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CellarSlotsCompanion(
            cellarId: cellarId,
            row: row,
            column: column,
            depth: depth,
            wineId: wineId,
            isBlocked: isBlocked,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String cellarId,
            required int row,
            required int column,
            required int depth,
            Value<String?> wineId = const Value.absent(),
            Value<bool> isBlocked = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CellarSlotsCompanion.insert(
            cellarId: cellarId,
            row: row,
            column: column,
            depth: depth,
            wineId: wineId,
            isBlocked: isBlocked,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CellarSlotsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({cellarId = false, wineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (cellarId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cellarId,
                    referencedTable:
                        $$CellarSlotsTableReferences._cellarIdTable(db),
                    referencedColumn:
                        $$CellarSlotsTableReferences._cellarIdTable(db).id,
                  ) as T;
                }
                if (wineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wineId,
                    referencedTable:
                        $$CellarSlotsTableReferences._wineIdTable(db),
                    referencedColumn:
                        $$CellarSlotsTableReferences._wineIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CellarSlotsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CellarSlotsTable,
    CellarSlotRow,
    $$CellarSlotsTableFilterComposer,
    $$CellarSlotsTableOrderingComposer,
    $$CellarSlotsTableAnnotationComposer,
    $$CellarSlotsTableCreateCompanionBuilder,
    $$CellarSlotsTableUpdateCompanionBuilder,
    (CellarSlotRow, $$CellarSlotsTableReferences),
    CellarSlotRow,
    PrefetchHooks Function({bool cellarId, bool wineId})>;
typedef $$TastingNotesTableCreateCompanionBuilder = TastingNotesCompanion
    Function({
  required String id,
  required String wineId,
  required DateTime date,
  Value<String?> appearance,
  Value<String?> nose,
  Value<String?> palate,
  Value<String?> finish,
  Value<String?> notes,
  Value<double?> rating,
  Value<String?> photoPath,
  Value<String?> occasion,
  Value<String?> foodPaired,
  Value<int> rowid,
});
typedef $$TastingNotesTableUpdateCompanionBuilder = TastingNotesCompanion
    Function({
  Value<String> id,
  Value<String> wineId,
  Value<DateTime> date,
  Value<String?> appearance,
  Value<String?> nose,
  Value<String?> palate,
  Value<String?> finish,
  Value<String?> notes,
  Value<double?> rating,
  Value<String?> photoPath,
  Value<String?> occasion,
  Value<String?> foodPaired,
  Value<int> rowid,
});

final class $$TastingNotesTableReferences
    extends BaseReferences<_$AppDatabase, $TastingNotesTable, TastingNoteRow> {
  $$TastingNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WinesTable _wineIdTable(_$AppDatabase db) => db.wines
      .createAlias($_aliasNameGenerator(db.tastingNotes.wineId, db.wines.id));

  $$WinesTableProcessedTableManager get wineId {
    final $_column = $_itemColumn<String>('wine_id')!;

    final manager = $$WinesTableTableManager($_db, $_db.wines)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TastingNotesTableFilterComposer
    extends Composer<_$AppDatabase, $TastingNotesTable> {
  $$TastingNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get appearance => $composableBuilder(
      column: $table.appearance, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nose => $composableBuilder(
      column: $table.nose, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get palate => $composableBuilder(
      column: $table.palate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get finish => $composableBuilder(
      column: $table.finish, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get occasion => $composableBuilder(
      column: $table.occasion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodPaired => $composableBuilder(
      column: $table.foodPaired, builder: (column) => ColumnFilters(column));

  $$WinesTableFilterComposer get wineId {
    final $$WinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableFilterComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TastingNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $TastingNotesTable> {
  $$TastingNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appearance => $composableBuilder(
      column: $table.appearance, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nose => $composableBuilder(
      column: $table.nose, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get palate => $composableBuilder(
      column: $table.palate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get finish => $composableBuilder(
      column: $table.finish, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get occasion => $composableBuilder(
      column: $table.occasion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodPaired => $composableBuilder(
      column: $table.foodPaired, builder: (column) => ColumnOrderings(column));

  $$WinesTableOrderingComposer get wineId {
    final $$WinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableOrderingComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TastingNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TastingNotesTable> {
  $$TastingNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get appearance => $composableBuilder(
      column: $table.appearance, builder: (column) => column);

  GeneratedColumn<String> get nose =>
      $composableBuilder(column: $table.nose, builder: (column) => column);

  GeneratedColumn<String> get palate =>
      $composableBuilder(column: $table.palate, builder: (column) => column);

  GeneratedColumn<String> get finish =>
      $composableBuilder(column: $table.finish, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get occasion =>
      $composableBuilder(column: $table.occasion, builder: (column) => column);

  GeneratedColumn<String> get foodPaired => $composableBuilder(
      column: $table.foodPaired, builder: (column) => column);

  $$WinesTableAnnotationComposer get wineId {
    final $$WinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableAnnotationComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TastingNotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TastingNotesTable,
    TastingNoteRow,
    $$TastingNotesTableFilterComposer,
    $$TastingNotesTableOrderingComposer,
    $$TastingNotesTableAnnotationComposer,
    $$TastingNotesTableCreateCompanionBuilder,
    $$TastingNotesTableUpdateCompanionBuilder,
    (TastingNoteRow, $$TastingNotesTableReferences),
    TastingNoteRow,
    PrefetchHooks Function({bool wineId})> {
  $$TastingNotesTableTableManager(_$AppDatabase db, $TastingNotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TastingNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TastingNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TastingNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> wineId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> appearance = const Value.absent(),
            Value<String?> nose = const Value.absent(),
            Value<String?> palate = const Value.absent(),
            Value<String?> finish = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double?> rating = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String?> occasion = const Value.absent(),
            Value<String?> foodPaired = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TastingNotesCompanion(
            id: id,
            wineId: wineId,
            date: date,
            appearance: appearance,
            nose: nose,
            palate: palate,
            finish: finish,
            notes: notes,
            rating: rating,
            photoPath: photoPath,
            occasion: occasion,
            foodPaired: foodPaired,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String wineId,
            required DateTime date,
            Value<String?> appearance = const Value.absent(),
            Value<String?> nose = const Value.absent(),
            Value<String?> palate = const Value.absent(),
            Value<String?> finish = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double?> rating = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String?> occasion = const Value.absent(),
            Value<String?> foodPaired = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TastingNotesCompanion.insert(
            id: id,
            wineId: wineId,
            date: date,
            appearance: appearance,
            nose: nose,
            palate: palate,
            finish: finish,
            notes: notes,
            rating: rating,
            photoPath: photoPath,
            occasion: occasion,
            foodPaired: foodPaired,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TastingNotesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wineId,
                    referencedTable:
                        $$TastingNotesTableReferences._wineIdTable(db),
                    referencedColumn:
                        $$TastingNotesTableReferences._wineIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TastingNotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TastingNotesTable,
    TastingNoteRow,
    $$TastingNotesTableFilterComposer,
    $$TastingNotesTableOrderingComposer,
    $$TastingNotesTableAnnotationComposer,
    $$TastingNotesTableCreateCompanionBuilder,
    $$TastingNotesTableUpdateCompanionBuilder,
    (TastingNoteRow, $$TastingNotesTableReferences),
    TastingNoteRow,
    PrefetchHooks Function({bool wineId})>;
typedef $$GrapeCompositionsTableCreateCompanionBuilder
    = GrapeCompositionsCompanion Function({
  Value<int> id,
  required String wineId,
  required String variety,
  Value<double?> percentage,
});
typedef $$GrapeCompositionsTableUpdateCompanionBuilder
    = GrapeCompositionsCompanion Function({
  Value<int> id,
  Value<String> wineId,
  Value<String> variety,
  Value<double?> percentage,
});

final class $$GrapeCompositionsTableReferences extends BaseReferences<
    _$AppDatabase, $GrapeCompositionsTable, GrapeCompositionRow> {
  $$GrapeCompositionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WinesTable _wineIdTable(_$AppDatabase db) => db.wines.createAlias(
      $_aliasNameGenerator(db.grapeCompositions.wineId, db.wines.id));

  $$WinesTableProcessedTableManager get wineId {
    final $_column = $_itemColumn<String>('wine_id')!;

    final manager = $$WinesTableTableManager($_db, $_db.wines)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GrapeCompositionsTableFilterComposer
    extends Composer<_$AppDatabase, $GrapeCompositionsTable> {
  $$GrapeCompositionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get variety => $composableBuilder(
      column: $table.variety, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => ColumnFilters(column));

  $$WinesTableFilterComposer get wineId {
    final $$WinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableFilterComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GrapeCompositionsTableOrderingComposer
    extends Composer<_$AppDatabase, $GrapeCompositionsTable> {
  $$GrapeCompositionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get variety => $composableBuilder(
      column: $table.variety, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => ColumnOrderings(column));

  $$WinesTableOrderingComposer get wineId {
    final $$WinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableOrderingComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GrapeCompositionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrapeCompositionsTable> {
  $$GrapeCompositionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get variety =>
      $composableBuilder(column: $table.variety, builder: (column) => column);

  GeneratedColumn<double> get percentage => $composableBuilder(
      column: $table.percentage, builder: (column) => column);

  $$WinesTableAnnotationComposer get wineId {
    final $$WinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WinesTableAnnotationComposer(
              $db: $db,
              $table: $db.wines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GrapeCompositionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GrapeCompositionsTable,
    GrapeCompositionRow,
    $$GrapeCompositionsTableFilterComposer,
    $$GrapeCompositionsTableOrderingComposer,
    $$GrapeCompositionsTableAnnotationComposer,
    $$GrapeCompositionsTableCreateCompanionBuilder,
    $$GrapeCompositionsTableUpdateCompanionBuilder,
    (GrapeCompositionRow, $$GrapeCompositionsTableReferences),
    GrapeCompositionRow,
    PrefetchHooks Function({bool wineId})> {
  $$GrapeCompositionsTableTableManager(
      _$AppDatabase db, $GrapeCompositionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrapeCompositionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrapeCompositionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrapeCompositionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> wineId = const Value.absent(),
            Value<String> variety = const Value.absent(),
            Value<double?> percentage = const Value.absent(),
          }) =>
              GrapeCompositionsCompanion(
            id: id,
            wineId: wineId,
            variety: variety,
            percentage: percentage,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String wineId,
            required String variety,
            Value<double?> percentage = const Value.absent(),
          }) =>
              GrapeCompositionsCompanion.insert(
            id: id,
            wineId: wineId,
            variety: variety,
            percentage: percentage,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GrapeCompositionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wineId,
                    referencedTable:
                        $$GrapeCompositionsTableReferences._wineIdTable(db),
                    referencedColumn:
                        $$GrapeCompositionsTableReferences._wineIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GrapeCompositionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GrapeCompositionsTable,
    GrapeCompositionRow,
    $$GrapeCompositionsTableFilterComposer,
    $$GrapeCompositionsTableOrderingComposer,
    $$GrapeCompositionsTableAnnotationComposer,
    $$GrapeCompositionsTableCreateCompanionBuilder,
    $$GrapeCompositionsTableUpdateCompanionBuilder,
    (GrapeCompositionRow, $$GrapeCompositionsTableReferences),
    GrapeCompositionRow,
    PrefetchHooks Function({bool wineId})>;
typedef $$WishlistEntriesTableCreateCompanionBuilder = WishlistEntriesCompanion
    Function({
  required String id,
  required String name,
  Value<String?> producer,
  Value<int?> vintage,
  Value<double?> estimatedPrice,
  Value<int> priority,
  Value<String?> notes,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$WishlistEntriesTableUpdateCompanionBuilder = WishlistEntriesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> producer,
  Value<int?> vintage,
  Value<double?> estimatedPrice,
  Value<int> priority,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$WishlistEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WishlistEntriesTable> {
  $$WishlistEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get producer => $composableBuilder(
      column: $table.producer, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vintage => $composableBuilder(
      column: $table.vintage, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estimatedPrice => $composableBuilder(
      column: $table.estimatedPrice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$WishlistEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WishlistEntriesTable> {
  $$WishlistEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get producer => $composableBuilder(
      column: $table.producer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vintage => $composableBuilder(
      column: $table.vintage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estimatedPrice => $composableBuilder(
      column: $table.estimatedPrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$WishlistEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WishlistEntriesTable> {
  $$WishlistEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get producer =>
      $composableBuilder(column: $table.producer, builder: (column) => column);

  GeneratedColumn<int> get vintage =>
      $composableBuilder(column: $table.vintage, builder: (column) => column);

  GeneratedColumn<double> get estimatedPrice => $composableBuilder(
      column: $table.estimatedPrice, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WishlistEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WishlistEntriesTable,
    WishlistEntryRow,
    $$WishlistEntriesTableFilterComposer,
    $$WishlistEntriesTableOrderingComposer,
    $$WishlistEntriesTableAnnotationComposer,
    $$WishlistEntriesTableCreateCompanionBuilder,
    $$WishlistEntriesTableUpdateCompanionBuilder,
    (
      WishlistEntryRow,
      BaseReferences<_$AppDatabase, $WishlistEntriesTable, WishlistEntryRow>
    ),
    WishlistEntryRow,
    PrefetchHooks Function()> {
  $$WishlistEntriesTableTableManager(
      _$AppDatabase db, $WishlistEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishlistEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishlistEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishlistEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> producer = const Value.absent(),
            Value<int?> vintage = const Value.absent(),
            Value<double?> estimatedPrice = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistEntriesCompanion(
            id: id,
            name: name,
            producer: producer,
            vintage: vintage,
            estimatedPrice: estimatedPrice,
            priority: priority,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> producer = const Value.absent(),
            Value<int?> vintage = const Value.absent(),
            Value<double?> estimatedPrice = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistEntriesCompanion.insert(
            id: id,
            name: name,
            producer: producer,
            vintage: vintage,
            estimatedPrice: estimatedPrice,
            priority: priority,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WishlistEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WishlistEntriesTable,
    WishlistEntryRow,
    $$WishlistEntriesTableFilterComposer,
    $$WishlistEntriesTableOrderingComposer,
    $$WishlistEntriesTableAnnotationComposer,
    $$WishlistEntriesTableCreateCompanionBuilder,
    $$WishlistEntriesTableUpdateCompanionBuilder,
    (
      WishlistEntryRow,
      BaseReferences<_$AppDatabase, $WishlistEntriesTable, WishlistEntryRow>
    ),
    WishlistEntryRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CellarsTableTableManager get cellars =>
      $$CellarsTableTableManager(_db, _db.cellars);
  $$WinesTableTableManager get wines =>
      $$WinesTableTableManager(_db, _db.wines);
  $$CellarSlotsTableTableManager get cellarSlots =>
      $$CellarSlotsTableTableManager(_db, _db.cellarSlots);
  $$TastingNotesTableTableManager get tastingNotes =>
      $$TastingNotesTableTableManager(_db, _db.tastingNotes);
  $$GrapeCompositionsTableTableManager get grapeCompositions =>
      $$GrapeCompositionsTableTableManager(_db, _db.grapeCompositions);
  $$WishlistEntriesTableTableManager get wishlistEntries =>
      $$WishlistEntriesTableTableManager(_db, _db.wishlistEntries);
}
