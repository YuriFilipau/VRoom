dynamic unwrapData(dynamic raw) {
  if (raw is Map<String, dynamic> && raw['data'] != null) {
    return raw['data'];
  }
  return raw;
}

Map<String, dynamic> asMap(dynamic raw) {
  final value = unwrapData(raw);
  if (value is Map<String, dynamic>) {
    return value;
  }
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  return <String, dynamic>{};
}

List<dynamic> asList(dynamic raw) {
  final value = unwrapData(raw);
  if (value is List<dynamic>) {
    return value;
  }
  if (value is List) {
    return List<dynamic>.from(value);
  }
  return const <dynamic>[];
}

String? readString(dynamic raw) {
  if (raw == null) {
    return null;
  }
  if (raw is String) {
    final trimmed = raw.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
  return raw.toString();
}

int? readInt(dynamic raw) {
  if (raw == null) {
    return null;
  }
  if (raw is int) {
    return raw;
  }
  if (raw is num) {
    return raw.toInt();
  }
  return int.tryParse(raw.toString());
}

double? readDouble(dynamic raw) {
  if (raw == null) {
    return null;
  }
  if (raw is double) {
    return raw;
  }
  if (raw is num) {
    return raw.toDouble();
  }
  return double.tryParse(raw.toString());
}

bool? readBool(dynamic raw) {
  if (raw == null) {
    return null;
  }
  if (raw is bool) {
    return raw;
  }
  if (raw is num) {
    return raw != 0;
  }
  final normalized = raw.toString().trim().toLowerCase();
  if (normalized == 'true' || normalized == '1') {
    return true;
  }
  if (normalized == 'false' || normalized == '0') {
    return false;
  }
  return null;
}

List<double>? readDoubleList(dynamic raw) {
  if (raw is! List) {
    return null;
  }
  final values = raw.map(readDouble).whereType<double>().toList();
  return values.isEmpty ? null : values;
}
