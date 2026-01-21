// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedbackItemAdapter extends TypeAdapter<FeedbackItem> {
  @override
  final int typeId = 3;

  @override
  FeedbackItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedbackItem(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      featureSuggestion: fields[2] as String,
      bugReport: fields[3] as String,
      satisfactionLevel: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FeedbackItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.featureSuggestion)
      ..writeByte(3)
      ..write(obj.bugReport)
      ..writeByte(4)
      ..write(obj.satisfactionLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
