// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/covtest_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 5325008264426582982),
      name: 'Covtestmodel',
      lastPropertyId: const IdUid(4, 2109705743754327563),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 252172355194515734),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(2, 3022021716563544394),
            name: 'qrcode',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3528211961274018108),
            name: 'dateTime',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2109705743754327563),
            name: 'id',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 5325008264426582982),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Covtestmodel: EntityDefinition<Covtestmodel>(
        model: _entities[0],
        toOneRelations: (Covtestmodel object) => [],
        toManyRelations: (Covtestmodel object) => {},
        getId: (Covtestmodel object) => object.id,
        setId: (Covtestmodel object, int id) {
          object.id = id;
        },
        objectToFB: (Covtestmodel object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final qrcodeOffset =
              object.qrcode == null ? null : fbb.writeString(object.qrcode!);
          final dateTimeOffset = object.dateTime == null
              ? null
              : fbb.writeString(object.dateTime!);
          fbb.startTable(5);
          fbb.addOffset(0, nameOffset);
          fbb.addOffset(1, qrcodeOffset);
          fbb.addOffset(2, dateTimeOffset);
          fbb.addInt64(3, object.id);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Covtestmodel(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0),
              name: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              qrcode: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              dateTime: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Covtestmodel] entity fields to define ObjectBox queries.
class Covtestmodel_ {
  /// see [Covtestmodel.name]
  static final name =
      QueryStringProperty<Covtestmodel>(_entities[0].properties[0]);

  /// see [Covtestmodel.qrcode]
  static final qrcode =
      QueryStringProperty<Covtestmodel>(_entities[0].properties[1]);

  /// see [Covtestmodel.dateTime]
  static final dateTime =
      QueryStringProperty<Covtestmodel>(_entities[0].properties[2]);

  /// see [Covtestmodel.id]
  static final id =
      QueryIntegerProperty<Covtestmodel>(_entities[0].properties[3]);
}
