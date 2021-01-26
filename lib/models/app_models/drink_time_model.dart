class DrinkTime {
  final int time;
  final double value;

  DrinkTime({this.time, this.value});

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'value': value,
    };
  }

  static DrinkTime fromJson(final data) {
    return DrinkTime(
      time: data['time'],
      value: data['value'],
    );
  }
}
