import 'package:flutter/material.dart';

class StatusUtils {
  const StatusUtils();

  Color getColorForStatus(String status) {
    switch (status) {
      case 'UNKNOWN':
        return Colors.red;
      case 'NOT_APPLICABLE':
        return Colors.red;
      case 'MOWING':
        return Colors.green;
      case 'GOING_HOME':
        return Colors.blue;
      case 'CHARGING':
        return Colors.yellow;
      case 'LEAVING':
        return Colors.blue;
      case 'PARKED_IN_CS':
        return Colors.blue;
      case 'STOPPED_IN_GARDEN':
        return Colors.red;
    }

    return Colors.red;
  }

  String getTextForStatus(String status) {
    switch (status) {
      case 'UNKNOWN':
        return 'Desconocido';
      case 'NOT_APPLICABLE':
        return 'Error';
      case 'MOWING':
        return 'Segando';
      case 'GOING_HOME':
        return 'Volviendo';
      case 'CHARGING':
        return 'Cargando';
      case 'LEAVING':
        return 'Arrancando';
      case 'PARKED_IN_CS':
        return 'Aparcado';
      case 'STOPPED_IN_GARDEN':
        return 'Parado';
    }

    return 'Desconocido';
  }
}
