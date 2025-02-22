// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $DriftMovieModelTable extends DriftMovieModel
    with TableInfo<$DriftMovieModelTable, DriftMovieModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftMovieModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _isAdultMeta = const VerificationMeta(
    'isAdult',
  );
  @override
  late final GeneratedColumn<bool> isAdult = GeneratedColumn<bool>(
    'is_adult',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_adult" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isCachedMeta = const VerificationMeta(
    'isCached',
  );
  @override
  late final GeneratedColumn<bool> isCached = GeneratedColumn<bool>(
    'is_cached',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_cached" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _voteCountMeta = const VerificationMeta(
    'voteCount',
  );
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
    'vote_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _backdropPathMeta = const VerificationMeta(
    'backdropPath',
  );
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
    'backdrop_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalLangaugeMeta = const VerificationMeta(
    'originalLangauge',
  );
  @override
  late final GeneratedColumn<String> originalLangauge = GeneratedColumn<String>(
    'original_langauge',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalTitleMeta = const VerificationMeta(
    'originalTitle',
  );
  @override
  late final GeneratedColumn<String> originalTitle = GeneratedColumn<String>(
    'original_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posterPathMeta = const VerificationMeta(
    'posterPath',
  );
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
    'poster_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    isAdult,
    isCached,
    isFavorite,
    rating,
    voteCount,
    backdropPath,
    originalLangauge,
    originalTitle,
    overview,
    posterPath,
    source,
    sourceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_movie_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftMovieModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_adult')) {
      context.handle(
        _isAdultMeta,
        isAdult.isAcceptableOrUnknown(data['is_adult']!, _isAdultMeta),
      );
    } else if (isInserting) {
      context.missing(_isAdultMeta);
    }
    if (data.containsKey('is_cached')) {
      context.handle(
        _isCachedMeta,
        isCached.isAcceptableOrUnknown(data['is_cached']!, _isCachedMeta),
      );
    } else if (isInserting) {
      context.missing(_isCachedMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('vote_count')) {
      context.handle(
        _voteCountMeta,
        voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta),
      );
    } else if (isInserting) {
      context.missing(_voteCountMeta);
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
        _backdropPathMeta,
        backdropPath.isAcceptableOrUnknown(
          data['backdrop_path']!,
          _backdropPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_backdropPathMeta);
    }
    if (data.containsKey('original_langauge')) {
      context.handle(
        _originalLangaugeMeta,
        originalLangauge.isAcceptableOrUnknown(
          data['original_langauge']!,
          _originalLangaugeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalLangaugeMeta);
    }
    if (data.containsKey('original_title')) {
      context.handle(
        _originalTitleMeta,
        originalTitle.isAcceptableOrUnknown(
          data['original_title']!,
          _originalTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalTitleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
        _posterPathMeta,
        posterPath.isAcceptableOrUnknown(data['poster_path']!, _posterPathMeta),
      );
    } else if (isInserting) {
      context.missing(_posterPathMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftMovieModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftMovieModelData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      isAdult:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_adult'],
          )!,
      isCached:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_cached'],
          )!,
      isFavorite:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_favorite'],
          )!,
      rating:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}rating'],
          )!,
      voteCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}vote_count'],
          )!,
      backdropPath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}backdrop_path'],
          )!,
      originalLangauge:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}original_langauge'],
          )!,
      originalTitle:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}original_title'],
          )!,
      overview:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}overview'],
          )!,
      posterPath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}poster_path'],
          )!,
      source:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}source'],
          )!,
      sourceId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}source_id'],
          )!,
    );
  }

  @override
  $DriftMovieModelTable createAlias(String alias) {
    return $DriftMovieModelTable(attachedDatabase, alias);
  }
}

class DriftMovieModelData extends DataClass
    implements Insertable<DriftMovieModelData> {
  final int id;
  final bool isAdult;
  final bool isCached;
  final bool isFavorite;
  final double rating;
  final int voteCount;
  final String backdropPath;
  final String originalLangauge;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String source;
  final String sourceId;
  const DriftMovieModelData({
    required this.id,
    required this.isAdult,
    required this.isCached,
    required this.isFavorite,
    required this.rating,
    required this.voteCount,
    required this.backdropPath,
    required this.originalLangauge,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.source,
    required this.sourceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_adult'] = Variable<bool>(isAdult);
    map['is_cached'] = Variable<bool>(isCached);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['rating'] = Variable<double>(rating);
    map['vote_count'] = Variable<int>(voteCount);
    map['backdrop_path'] = Variable<String>(backdropPath);
    map['original_langauge'] = Variable<String>(originalLangauge);
    map['original_title'] = Variable<String>(originalTitle);
    map['overview'] = Variable<String>(overview);
    map['poster_path'] = Variable<String>(posterPath);
    map['source'] = Variable<String>(source);
    map['source_id'] = Variable<String>(sourceId);
    return map;
  }

  DriftMovieModelCompanion toCompanion(bool nullToAbsent) {
    return DriftMovieModelCompanion(
      id: Value(id),
      isAdult: Value(isAdult),
      isCached: Value(isCached),
      isFavorite: Value(isFavorite),
      rating: Value(rating),
      voteCount: Value(voteCount),
      backdropPath: Value(backdropPath),
      originalLangauge: Value(originalLangauge),
      originalTitle: Value(originalTitle),
      overview: Value(overview),
      posterPath: Value(posterPath),
      source: Value(source),
      sourceId: Value(sourceId),
    );
  }

  factory DriftMovieModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftMovieModelData(
      id: serializer.fromJson<int>(json['id']),
      isAdult: serializer.fromJson<bool>(json['isAdult']),
      isCached: serializer.fromJson<bool>(json['isCached']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      rating: serializer.fromJson<double>(json['rating']),
      voteCount: serializer.fromJson<int>(json['voteCount']),
      backdropPath: serializer.fromJson<String>(json['backdropPath']),
      originalLangauge: serializer.fromJson<String>(json['originalLangauge']),
      originalTitle: serializer.fromJson<String>(json['originalTitle']),
      overview: serializer.fromJson<String>(json['overview']),
      posterPath: serializer.fromJson<String>(json['posterPath']),
      source: serializer.fromJson<String>(json['source']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isAdult': serializer.toJson<bool>(isAdult),
      'isCached': serializer.toJson<bool>(isCached),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'rating': serializer.toJson<double>(rating),
      'voteCount': serializer.toJson<int>(voteCount),
      'backdropPath': serializer.toJson<String>(backdropPath),
      'originalLangauge': serializer.toJson<String>(originalLangauge),
      'originalTitle': serializer.toJson<String>(originalTitle),
      'overview': serializer.toJson<String>(overview),
      'posterPath': serializer.toJson<String>(posterPath),
      'source': serializer.toJson<String>(source),
      'sourceId': serializer.toJson<String>(sourceId),
    };
  }

  DriftMovieModelData copyWith({
    int? id,
    bool? isAdult,
    bool? isCached,
    bool? isFavorite,
    double? rating,
    int? voteCount,
    String? backdropPath,
    String? originalLangauge,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? source,
    String? sourceId,
  }) => DriftMovieModelData(
    id: id ?? this.id,
    isAdult: isAdult ?? this.isAdult,
    isCached: isCached ?? this.isCached,
    isFavorite: isFavorite ?? this.isFavorite,
    rating: rating ?? this.rating,
    voteCount: voteCount ?? this.voteCount,
    backdropPath: backdropPath ?? this.backdropPath,
    originalLangauge: originalLangauge ?? this.originalLangauge,
    originalTitle: originalTitle ?? this.originalTitle,
    overview: overview ?? this.overview,
    posterPath: posterPath ?? this.posterPath,
    source: source ?? this.source,
    sourceId: sourceId ?? this.sourceId,
  );
  DriftMovieModelData copyWithCompanion(DriftMovieModelCompanion data) {
    return DriftMovieModelData(
      id: data.id.present ? data.id.value : this.id,
      isAdult: data.isAdult.present ? data.isAdult.value : this.isAdult,
      isCached: data.isCached.present ? data.isCached.value : this.isCached,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      rating: data.rating.present ? data.rating.value : this.rating,
      voteCount: data.voteCount.present ? data.voteCount.value : this.voteCount,
      backdropPath:
          data.backdropPath.present
              ? data.backdropPath.value
              : this.backdropPath,
      originalLangauge:
          data.originalLangauge.present
              ? data.originalLangauge.value
              : this.originalLangauge,
      originalTitle:
          data.originalTitle.present
              ? data.originalTitle.value
              : this.originalTitle,
      overview: data.overview.present ? data.overview.value : this.overview,
      posterPath:
          data.posterPath.present ? data.posterPath.value : this.posterPath,
      source: data.source.present ? data.source.value : this.source,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftMovieModelData(')
          ..write('id: $id, ')
          ..write('isAdult: $isAdult, ')
          ..write('isCached: $isCached, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rating: $rating, ')
          ..write('voteCount: $voteCount, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('originalLangauge: $originalLangauge, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    isAdult,
    isCached,
    isFavorite,
    rating,
    voteCount,
    backdropPath,
    originalLangauge,
    originalTitle,
    overview,
    posterPath,
    source,
    sourceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftMovieModelData &&
          other.id == this.id &&
          other.isAdult == this.isAdult &&
          other.isCached == this.isCached &&
          other.isFavorite == this.isFavorite &&
          other.rating == this.rating &&
          other.voteCount == this.voteCount &&
          other.backdropPath == this.backdropPath &&
          other.originalLangauge == this.originalLangauge &&
          other.originalTitle == this.originalTitle &&
          other.overview == this.overview &&
          other.posterPath == this.posterPath &&
          other.source == this.source &&
          other.sourceId == this.sourceId);
}

class DriftMovieModelCompanion extends UpdateCompanion<DriftMovieModelData> {
  final Value<int> id;
  final Value<bool> isAdult;
  final Value<bool> isCached;
  final Value<bool> isFavorite;
  final Value<double> rating;
  final Value<int> voteCount;
  final Value<String> backdropPath;
  final Value<String> originalLangauge;
  final Value<String> originalTitle;
  final Value<String> overview;
  final Value<String> posterPath;
  final Value<String> source;
  final Value<String> sourceId;
  const DriftMovieModelCompanion({
    this.id = const Value.absent(),
    this.isAdult = const Value.absent(),
    this.isCached = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rating = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.originalLangauge = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceId = const Value.absent(),
  });
  DriftMovieModelCompanion.insert({
    this.id = const Value.absent(),
    required bool isAdult,
    required bool isCached,
    required bool isFavorite,
    required double rating,
    required int voteCount,
    required String backdropPath,
    required String originalLangauge,
    required String originalTitle,
    required String overview,
    required String posterPath,
    required String source,
    required String sourceId,
  }) : isAdult = Value(isAdult),
       isCached = Value(isCached),
       isFavorite = Value(isFavorite),
       rating = Value(rating),
       voteCount = Value(voteCount),
       backdropPath = Value(backdropPath),
       originalLangauge = Value(originalLangauge),
       originalTitle = Value(originalTitle),
       overview = Value(overview),
       posterPath = Value(posterPath),
       source = Value(source),
       sourceId = Value(sourceId);
  static Insertable<DriftMovieModelData> custom({
    Expression<int>? id,
    Expression<bool>? isAdult,
    Expression<bool>? isCached,
    Expression<bool>? isFavorite,
    Expression<double>? rating,
    Expression<int>? voteCount,
    Expression<String>? backdropPath,
    Expression<String>? originalLangauge,
    Expression<String>? originalTitle,
    Expression<String>? overview,
    Expression<String>? posterPath,
    Expression<String>? source,
    Expression<String>? sourceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isAdult != null) 'is_adult': isAdult,
      if (isCached != null) 'is_cached': isCached,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rating != null) 'rating': rating,
      if (voteCount != null) 'vote_count': voteCount,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (originalLangauge != null) 'original_langauge': originalLangauge,
      if (originalTitle != null) 'original_title': originalTitle,
      if (overview != null) 'overview': overview,
      if (posterPath != null) 'poster_path': posterPath,
      if (source != null) 'source': source,
      if (sourceId != null) 'source_id': sourceId,
    });
  }

  DriftMovieModelCompanion copyWith({
    Value<int>? id,
    Value<bool>? isAdult,
    Value<bool>? isCached,
    Value<bool>? isFavorite,
    Value<double>? rating,
    Value<int>? voteCount,
    Value<String>? backdropPath,
    Value<String>? originalLangauge,
    Value<String>? originalTitle,
    Value<String>? overview,
    Value<String>? posterPath,
    Value<String>? source,
    Value<String>? sourceId,
  }) {
    return DriftMovieModelCompanion(
      id: id ?? this.id,
      isAdult: isAdult ?? this.isAdult,
      isCached: isCached ?? this.isCached,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: rating ?? this.rating,
      voteCount: voteCount ?? this.voteCount,
      backdropPath: backdropPath ?? this.backdropPath,
      originalLangauge: originalLangauge ?? this.originalLangauge,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isAdult.present) {
      map['is_adult'] = Variable<bool>(isAdult.value);
    }
    if (isCached.present) {
      map['is_cached'] = Variable<bool>(isCached.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (originalLangauge.present) {
      map['original_langauge'] = Variable<String>(originalLangauge.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftMovieModelCompanion(')
          ..write('id: $id, ')
          ..write('isAdult: $isAdult, ')
          ..write('isCached: $isCached, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rating: $rating, ')
          ..write('voteCount: $voteCount, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('originalLangauge: $originalLangauge, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DriftMovieModelTable driftMovieModel = $DriftMovieModelTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [driftMovieModel];
}

typedef $$DriftMovieModelTableCreateCompanionBuilder =
    DriftMovieModelCompanion Function({
      Value<int> id,
      required bool isAdult,
      required bool isCached,
      required bool isFavorite,
      required double rating,
      required int voteCount,
      required String backdropPath,
      required String originalLangauge,
      required String originalTitle,
      required String overview,
      required String posterPath,
      required String source,
      required String sourceId,
    });
typedef $$DriftMovieModelTableUpdateCompanionBuilder =
    DriftMovieModelCompanion Function({
      Value<int> id,
      Value<bool> isAdult,
      Value<bool> isCached,
      Value<bool> isFavorite,
      Value<double> rating,
      Value<int> voteCount,
      Value<String> backdropPath,
      Value<String> originalLangauge,
      Value<String> originalTitle,
      Value<String> overview,
      Value<String> posterPath,
      Value<String> source,
      Value<String> sourceId,
    });

class $$DriftMovieModelTableFilterComposer
    extends Composer<_$AppDatabase, $DriftMovieModelTable> {
  $$DriftMovieModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAdult => $composableBuilder(
    column: $table.isAdult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCached => $composableBuilder(
    column: $table.isCached,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalLangauge => $composableBuilder(
    column: $table.originalLangauge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DriftMovieModelTableOrderingComposer
    extends Composer<_$AppDatabase, $DriftMovieModelTable> {
  $$DriftMovieModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAdult => $composableBuilder(
    column: $table.isAdult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCached => $composableBuilder(
    column: $table.isCached,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalLangauge => $composableBuilder(
    column: $table.originalLangauge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DriftMovieModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $DriftMovieModelTable> {
  $$DriftMovieModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isAdult =>
      $composableBuilder(column: $table.isAdult, builder: (column) => column);

  GeneratedColumn<bool> get isCached =>
      $composableBuilder(column: $table.isCached, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get voteCount =>
      $composableBuilder(column: $table.voteCount, builder: (column) => column);

  GeneratedColumn<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalLangauge => $composableBuilder(
    column: $table.originalLangauge,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);
}

class $$DriftMovieModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DriftMovieModelTable,
          DriftMovieModelData,
          $$DriftMovieModelTableFilterComposer,
          $$DriftMovieModelTableOrderingComposer,
          $$DriftMovieModelTableAnnotationComposer,
          $$DriftMovieModelTableCreateCompanionBuilder,
          $$DriftMovieModelTableUpdateCompanionBuilder,
          (
            DriftMovieModelData,
            BaseReferences<
              _$AppDatabase,
              $DriftMovieModelTable,
              DriftMovieModelData
            >,
          ),
          DriftMovieModelData,
          PrefetchHooks Function()
        > {
  $$DriftMovieModelTableTableManager(
    _$AppDatabase db,
    $DriftMovieModelTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$DriftMovieModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DriftMovieModelTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DriftMovieModelTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> isAdult = const Value.absent(),
                Value<bool> isCached = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<double> rating = const Value.absent(),
                Value<int> voteCount = const Value.absent(),
                Value<String> backdropPath = const Value.absent(),
                Value<String> originalLangauge = const Value.absent(),
                Value<String> originalTitle = const Value.absent(),
                Value<String> overview = const Value.absent(),
                Value<String> posterPath = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
              }) => DriftMovieModelCompanion(
                id: id,
                isAdult: isAdult,
                isCached: isCached,
                isFavorite: isFavorite,
                rating: rating,
                voteCount: voteCount,
                backdropPath: backdropPath,
                originalLangauge: originalLangauge,
                originalTitle: originalTitle,
                overview: overview,
                posterPath: posterPath,
                source: source,
                sourceId: sourceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required bool isAdult,
                required bool isCached,
                required bool isFavorite,
                required double rating,
                required int voteCount,
                required String backdropPath,
                required String originalLangauge,
                required String originalTitle,
                required String overview,
                required String posterPath,
                required String source,
                required String sourceId,
              }) => DriftMovieModelCompanion.insert(
                id: id,
                isAdult: isAdult,
                isCached: isCached,
                isFavorite: isFavorite,
                rating: rating,
                voteCount: voteCount,
                backdropPath: backdropPath,
                originalLangauge: originalLangauge,
                originalTitle: originalTitle,
                overview: overview,
                posterPath: posterPath,
                source: source,
                sourceId: sourceId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DriftMovieModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DriftMovieModelTable,
      DriftMovieModelData,
      $$DriftMovieModelTableFilterComposer,
      $$DriftMovieModelTableOrderingComposer,
      $$DriftMovieModelTableAnnotationComposer,
      $$DriftMovieModelTableCreateCompanionBuilder,
      $$DriftMovieModelTableUpdateCompanionBuilder,
      (
        DriftMovieModelData,
        BaseReferences<
          _$AppDatabase,
          $DriftMovieModelTable,
          DriftMovieModelData
        >,
      ),
      DriftMovieModelData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DriftMovieModelTableTableManager get driftMovieModel =>
      $$DriftMovieModelTableTableManager(_db, _db.driftMovieModel);
}
