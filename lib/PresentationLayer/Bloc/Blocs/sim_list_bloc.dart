// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/DomainLayer/Entities/sim_list_entity.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/sim_list_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/sim_list_STATE.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:logging/logging.dart';

import '../../Components/constant.dart';

// Importing custom event and state classes for the SimListBloc

// BLoC class for handling state management related to fetching and displaying SimLists
class SimListBloc extends Bloc<SimListEvent, SimListState> with PrintMixin {
  // SimListBloc(super.initialState);

  //Constructor initializes the SimListBloc with the initial state and sets up event handling
  SimListBloc() : super(InitialSimListState()) {
    on<GetSimList>(_doSimList);
  }

  // Private method for handling the FetchSimList event and updating the state accordingly
  _doSimList(GetSimList event, Emitter<SimListState> emit) async {
    // Checking if the event is of type FetchSimList
    // Emitting a loading state to indicate that the SimList is being fetched
    emit(SimListLoading());
    try {
      p("called api");
      Logger("GetSimList id is ${event.agentId} ");
      // Making an HTTP POST request to the quotable.io API to fetch a random SimList
      final ioc = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      final httpClient = IOClient(ioc);
      final String url =
          "$infoInstallProductionURL$spareSimList"; //${event.agentId}
      logHttpRequest('GET', url);
      final response = await httpClient.get(
        Uri.parse(url), //${event.agentId}
        headers: {
          'Content-Type': 'application/json', // Specify the content type here
        },
      );
      logHttpResponse(response.statusCode, url, body: response.body);
      // Checking if the response status code is OK (200)

      if (response.statusCode == 200) {
        // Body already logged above
        // Decoding the JSON response and creating a SimListLoaded state with the retrieved data
        final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

        SimList simLists = SimList.fromJson(decodedResponse);
        List<String> simNumbers = [];

        p('Simlist getting from simlists');
        p('Simlist length: ${simLists.data.length}');

        for (int i = 0; i < simLists.data.length; i++) {
          simNumbers.add(simLists.data[i].MobileNo);
        }
        // p("*** Response SIM length: ${simLists.data[0]}");
        p("Sim Number == ${simNumbers.length}");
        // final simListLoaded = GetSimLoaded(
        //   stauts: simLists.status,
        //   simData: simLists.data,
        //   simNumbers: simNumbers,
        // );
        p(simLists.status.toString());
        if (simLists.status == 400) {
          emit(SimListError('Error: ${simLists.status.toString()} '));
        } else {
          p("*** Response Emit SIM");
          // Emitting the SimListLoaded state to update the UI with the fetched SimList
          // emit(simListLoaded);
          emit(GetSimLoaded(
            status: simLists.status,
            simData: simLists.data,
            // simNumbers: simNumbers,
            simNumbers: simNumbers.isEmpty ? [] : List.from(simNumbers), //
          ));
          p("Sim bloc state ===${state.runtimeType}");
        }
      } else if (response.statusCode == 400) {
        // Emitting the SimListLoaded state to update the UI with the fetched SimList
      } else {
        // Emitting an error state if the response status code is not OK
        emit(SimListError('Failed to load SimList'));
      }
    } catch (e) {
      Logger("Catch Exception in parsing $e");
      // Emitting an error state if an exception occurs during the fetching process
      emit(SimListError('Catch: $e'));
    }
  }
}
