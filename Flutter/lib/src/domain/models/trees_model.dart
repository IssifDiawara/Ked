import 'package:json_annotation/json_annotation.dart';

part 'trees_model.g.dart';

@JsonSerializable()
class DataSet {
  @JsonKey(name: 'nhits')
  int? nHits;
  List<Record>? records;

  DataSet(this.nHits, this.records);

  factory DataSet.fromJson(Map<String, dynamic> json) => _$DataSetFromJson(json);

  Map<String, dynamic> toJson() => _$DataSetToJson(this);
}

@JsonSerializable()
class Record {
  Field? fields;
  Geometry? geometry;

  Record(this.fields, this.geometry);

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}

@JsonSerializable()
class Field {
  @JsonKey(name: 'genre')
  String? type;

  @JsonKey(name: 'espece')
  String? species;

  @JsonKey(name: 'domanialite')
  String? domination;

  @JsonKey(name: 'adresse')
  String? address;

  @JsonKey(name: 'libellefrancais')
  String? frenchLabel;

  @JsonKey(name: ' hauteur_en_m')
  String? height;

  Field(
    this.type,
    this.species,
    this.domination,
    this.address,
    this.frenchLabel,
    this.height,
  );

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

@JsonSerializable()
class Geometry {
  List<double>? coordinates;

  Geometry(this.coordinates);

  factory Geometry.fromJson(Map<String, dynamic> json) => _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}
