import 'dart:typed_data';

class Record {
  int id;
  double value;

  Record(this.id, this.value);
}

class QlwFile {
  int header;
  int numRecords;
  List<Record> records;

  QlwFile(this.header, this.numRecords, this.records);
}

Future<QlwFile> parseQlwFile(Uint8List bytes) async {
  // var file = File(filePath);
  // var bytes = await file.readAsBytes();
  var byteData = ByteData.sublistView(Uint8List.fromList(bytes));

  int offset = 0;
  int header = byteData.getInt32(offset, Endian.little);
  offset += 4;
  int numRecords = byteData.getInt32(offset, Endian.little);
  offset += 4;

  List<Record> records = [];
  for (int i = 0; i < numRecords; i++) {
    int id = byteData.getInt32(offset, Endian.little);
    offset += 4;
    double value = byteData.getFloat64(offset, Endian.little);
    offset += 8;
    records.add(Record(id, value));
  }

  return QlwFile(header, numRecords, records);
}
