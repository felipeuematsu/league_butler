import 'dart:convert';

import 'package:league_butler/utils/logger.dart';

class LCUWebSocketResponse {
  LCUWebSocketResponse(this.opcode, this.event, this.data);

  static LCUWebSocketResponse? fromEvent(event) {
    if (event is! String || event.isEmpty) return null;

    final List<dynamic> list = json.decode(event);
    logger.i('LCUWebSocketResponse: ${list[2]}');
    return LCUWebSocketResponse(list[0], list[1], LCUWebSocketResponseData.fromJson(list[2]));
  }

  int opcode;
  String event;
  LCUWebSocketResponseData data;
}

class LCUWebSocketResponseData {
  LCUWebSocketResponseData.fromJson(Map<String, dynamic> map)
      : data = map['data'] is Map ? map['data'] ?? {} : {'data': map['data']},
        uri = map['uri'],
        eventType = map['eventType'];

  Map<String, dynamic> data;
  String uri;
  String eventType;
}
