import 'package:flutter/material.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/widgets/basic_info_card.dart';
import 'package:mower_control_app/widgets/client_details_card.dart';
import 'package:mower_control_app/widgets/detail_status_card.dart';
import 'package:mower_control_app/widgets/employee_details_card.dart';
import 'package:mower_control_app/widgets/remote_control_card.dart';

class MowerDetailsScreen extends StatelessWidget {
  const MowerDetailsScreen({super.key, required this.mower});

  final Mower mower;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información detallada"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BasicInformation(
              mowerName: mower.name,
              serialNumber: mower.serialNumber,
              modelName: mower.model.name,
            ),
            MowerDetailStatus(
              battery: mower.battery,
              mode: mower.mode,
              activity: mower.activity,
              state: mower.state,
              modelName: mower.model.name,
            ),
            ClientDetails(
              name: mower.client!.name,
              address: mower.client!.address,
              phoneNumber: mower.client!.phoneNumber,
            ),
            EmployeeDetails(
              name: mower.employee!.name,
              surname1: mower.employee!.surname1,
              surname2: mower.employee!.surname2,
              username: mower.employee!.username,
            ),
            RemoteControl(
              mowerId: mower.id,
            ),
          ],
        ),
      ),
    );
  }
}
