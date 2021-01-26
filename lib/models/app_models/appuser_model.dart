class AppUser {
  final String name;
  final int height;
  final int weight;
  final int exercise;
  final int targetWater;
  AppUser({
    this.name,
    this.height,
    this.weight,
    this.exercise,
    this.targetWater,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'height': height,
      'weight': weight,
      'exercise': exercise,
      'target_water': targetWater,
    };
  }

  static AppUser fromJson(final data) {
    return AppUser(
      name: data['name'],
      height: data['height'],
      weight: data['weight'],
      exercise: data['exercise'],
      targetWater: data['target_water']
    );
  }
}
