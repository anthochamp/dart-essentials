import 'package:anthochamp_dart_essentials/src/types/json.dart';

class JsonUtil {
  static JsonCollection castAsCollection(JsonValue value) {
    // pass through an json array to help dart cast mechanism
    return (value as JsonArray)
        .map<JsonObject>((e) => e as JsonObject)
        .toList();
  }

  // ignore: no-object-declaration
  static JsonValue get(JsonObject object, dynamic path) {
    Iterable<dynamic> list;
    if (path is String || path is int) {
      list = [path];
    } else {
      list = path;
    }

    JsonValue result = object;
    for (final segment in list) {
      if (segment is int) {
        result = (result as JsonArray).elementAt(segment);
      } else {
        result = (result as JsonObject)[segment.toString()];
      }
    }

    return result;
  }
}
