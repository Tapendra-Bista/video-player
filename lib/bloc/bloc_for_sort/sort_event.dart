

// Define Events
abstract class SortEvent {}

class SortWayChangedEvent extends SortEvent {
  final String sortBy;
  SortWayChangedEvent(this.sortBy);
}


