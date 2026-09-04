// Abstract base class for defining loign-related events

abstract class SimListEvent {}

class GetSimList extends SimListEvent {
  final String agentId;
  GetSimList({required this.agentId});
}
