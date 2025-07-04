// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductCartModelAdapter extends TypeAdapter<ProductCartModel> {
  @override
  final int typeId = 0;

  @override
  ProductCartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCartModel(
      id: fields[0] as int,
      product: fields[1] as ProductCModel,
      count: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProductCartModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.product)
      ..writeByte(2)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
