import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoinstall/DataLayer/Model/device_gps_detail_model.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/device_gps_detail_bloc.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/device_gps_detail_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/device_gps_detail_state.dart';
import 'package:infoinstall/PresentationLayer/Components/color_plattes.dart';

class DeviceGpsScreen extends StatefulWidget {
  final String unitNo;
  final String simNo;

  const DeviceGpsScreen({Key? key, required this.unitNo, required this.simNo})
      : super(key: key);

  @override
  State<DeviceGpsScreen> createState() => _DeviceGpsScreenState();
}

class _DeviceGpsScreenState extends State<DeviceGpsScreen> {
  late DeviceGpsDetailBloc _deviceGpsDetailBloc;

  @override
  void initState() {
    super.initState();
    _deviceGpsDetailBloc = DeviceGpsDetailBloc();
    _deviceGpsDetailBloc
        .add(FetchDeviceGpsDetail(unitno: widget.unitNo, simNo: widget.simNo));
  }

  @override
  void dispose() {
    _deviceGpsDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("DEVICE DETAILS", style: TextStyle(color: Colors.white)),
        backgroundColor: ColorsPlatte.accentColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<DeviceGpsDetailBloc, DeviceGpsDetailState>(
            bloc: _deviceGpsDetailBloc,
            builder: (context, state) {
              if (state is DeviceGpsDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DeviceGpsDetailLoaded) {
                return Column(
                  children: state.deviceGpsDetailModel
                      .map((model) => _buildDetailCard(model))
                      .toList(),
                );
              } else if (state is DeviceGpsDetailError) {
                return Center(child: Text(state.errorMessage));
              }
              return const Center(child: Text('Please wait'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(DeviceGpsDetailModel model) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Unit No', model.unitNo),
            _buildDetailRow('Sim No', model.simNo),
            _buildDetailRow('Vehicle Number', model.vehicleNo),
            _buildDetailRow('Tracktime', model.tracktime),
            _buildDetailRow('Battery Level', '${model.batteryLevel} %'),
            _buildDetailRow('Speed', '${model.speed} km/hr'),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Main Power Status: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: model.mainpower == 1 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Panic Status: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: model.panic == 1 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ignition Status: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: model.ignition == 1 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'GPS Status: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: model.gpsstatus == 1 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Immobalizer Status: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: model.immobalizer == 1 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Location:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(model.location ?? 'N/A',
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.visible),
                    ),
                  ),
                ],
              ),
            ),
            // _buildDetailRow('Location', model.location),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label:", style: const TextStyle(fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(value ?? 'N/A',
                textAlign: TextAlign.right, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
