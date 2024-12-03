

// Define States
abstract class SortState {
  final String sortBy;

  const SortState(this.sortBy);

  Map<String, dynamic> toJson();
}

class InitialSortState extends SortState {
  const InitialSortState(super.sortBy);

  @override
  Map<String, dynamic> toJson() => {'sortBy': sortBy};

  factory InitialSortState.fromJson(Map<String, dynamic> json) {
    return InitialSortState(json['sortBy'] as String);
  }
}

class SortWayChangedState extends SortState {
  const SortWayChangedState(super.sortBy);

  @override
  Map<String, dynamic> toJson() => {'sortBy': sortBy};

  factory SortWayChangedState.fromJson(Map<String, dynamic> json) {
    return SortWayChangedState(json['sortBy'] as String);
  }
}


