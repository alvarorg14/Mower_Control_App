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

  String getTextForActivity(String activity, String state) {
    switch (activity) {
      case 'UNKNOWN':
        return 'Desconocido';
      case 'NOT_APPLICABLE':
        return getTextForState(state);
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

  String getTextForMode(String mode) {
    switch (mode) {
      case 'MAIN_AREA':
        return 'Area principal';
      case 'DEMO':
        return 'Demo';
      case 'SECONDARY_AREA':
        return 'Area secundaria';
      case 'Home':
        return 'Base de carga';
      case 'UNKNOWN':
        return 'Desconocido';
    }

    return 'Desconocido';
  }

  String getTextForState(String state) {
    switch (state) {
      case 'UNKNOWN':
        return 'Desconocido';
      case 'NOT_APPLICABLE':
        return 'Desconocido';
      case 'PAUSED':
        return 'Pausado';
      case 'IN_OPERATION':
        return 'En operación';
      case 'WAIT_UPDATING':
        return 'Actualizando';
      case 'WAIT_POWER_UP':
        return 'Encendiendo';
      case 'RESTRICTED':
        return 'Restringido';
      case 'OFF':
        return 'Apagado';
      case 'STOPPED':
        return 'Parado';
      case 'ERROR':
        return 'Error';
      case 'FATAL_ERROR':
        return 'Error';
      case 'ERROR_AT_POWER_APP':
        return 'Error';
    }

    return 'Desconocido';
  }
}
