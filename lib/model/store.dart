class Store {
  final double lat;
  final double lng;
  final String name;
  final String address;
  final String remainStat;

  Store(
      {required this.lat,
      required this.lng,
      required this.name,
      required this.address,
      required this.remainStat});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      name: json['name'] as String,
      address: json["addr"] as String,
      remainStat: json['remain_stat'] as String,
    );
  }
}
