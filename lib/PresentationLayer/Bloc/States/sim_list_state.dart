// // Abstract base class for defining SimList-related states
// import 'package:infoinstall/DataLayer/Model/get_sim_list_model.dart';

// abstract class SimListState {}

// // Subclass representing the initial state.
// class InitialSimListState extends SimListState {}

// // State class indicating that a SimList is currently being fetched
// class SimListLoading extends SimListState {}

// // State class representing a successfully loaded SimList with content, author, tags, and date added
// class GetSimLoaded extends SimListState {
//   final int? stauts;
//   final List<SimData?> simData;
//   final List<String> simNumbers;

//   // Constructor for creating a SimListLoaded instance with required data
//   GetSimLoaded({
//     required this.stauts,
//     required this.simData,
//     required this.simNumbers,
//   });
// }

// // State class representing an error in the SimList fetching process with an error message
// class SimListError extends SimListState {
//   final String errorMessage;

//   // Constructor for creating a SimListError instance with the provided error message
//   SimListError(this.errorMessage);
// }
import 'package:equatable/equatable.dart';
import 'package:infoinstall/DataLayer/Model/get_sim_list_model.dart';

abstract class SimListState {}

// Subclass representing the initial state.
class InitialSimListState extends SimListState {}

// State class indicating that a SimList is currently being fetched
class SimListLoading extends SimListState {}

// State class representing a successfully loaded SimList with content, author, tags, and date added
class GetSimLoaded extends SimListState with EquatableMixin {
  final int? status;
  final List<SimData?> simData;
  final List<String> simNumbers;

  // Constructor for creating a SimListLoaded instance with required data
  GetSimLoaded({
    required this.status,
    required this.simData,
    required this.simNumbers,
  });

  @override
  List<Object?> get props => [status, simData, simNumbers];
}

// State class representing an error in the SimList fetching process with an error message
class SimListError extends SimListState {
  final String errorMessage;

  // Constructor for creating a SimListError instance with the provided error message
  SimListError(this.errorMessage);
}
