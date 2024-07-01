import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/utils/status.dart';

void main() {
  const statusUtils = StatusUtils();

  group('StatusUtils', () {
    test('getColorForStatus returns correct color', () {
      expect(statusUtils.getColorForStatus('UNKNOWN'), Colors.red);
      expect(statusUtils.getColorForStatus('NOT_APPLICABLE'), Colors.red);
      expect(statusUtils.getColorForStatus('MOWING'), Colors.green);
      expect(statusUtils.getColorForStatus('GOING_HOME'), Colors.blue);
      expect(statusUtils.getColorForStatus('CHARGING'), Colors.yellow);
      expect(statusUtils.getColorForStatus('LEAVING'), Colors.blue);
      expect(statusUtils.getColorForStatus('PARKED_IN_CS'), Colors.blue);
      expect(statusUtils.getColorForStatus('STOPPED_IN_GARDEN'), Colors.red);
      expect(statusUtils.getColorForStatus('UNKNOWN_STATUS'), Colors.red);
    });

    test('getTextForActivity returns correct text', () {
      expect(statusUtils.getTextForActivity('UNKNOWN'), 'Desconocido');
      expect(statusUtils.getTextForActivity('NOT_APPLICABLE'), 'No aplica');
      expect(statusUtils.getTextForActivity('MOWING'), 'Segando');
      expect(statusUtils.getTextForActivity('GOING_HOME'), 'Volviendo');
      expect(statusUtils.getTextForActivity('CHARGING'), 'Cargando');
      expect(statusUtils.getTextForActivity('LEAVING'), 'Arrancando');
      expect(statusUtils.getTextForActivity('PARKED_IN_CS'), 'Aparcado');
      expect(statusUtils.getTextForActivity('STOPPED_IN_GARDEN'), 'Parado');
      expect(statusUtils.getTextForActivity('UNKNOWN_ACTIVITY'), 'Desconocido');
    });

    test('getTextForMode returns correct text', () {
      expect(statusUtils.getTextForMode('MAIN_AREA'), 'Area principal');
      expect(statusUtils.getTextForMode('DEMO'), 'Demo');
      expect(statusUtils.getTextForMode('SECONDARY_AREA'), 'Area secundaria');
      expect(statusUtils.getTextForMode('Home'), 'Base de carga');
      expect(statusUtils.getTextForMode('UNKNOWN'), 'Desconocido');
      expect(statusUtils.getTextForMode('UNKNOWN_MODE'), 'Desconocido');
    });

    test('getTextForState returns correct text', () {
      expect(statusUtils.getTextForState('UNKNOWN'), 'Desconocido');
      expect(statusUtils.getTextForState('NOT_APPLICABLE'), 'Desconocido');
      expect(statusUtils.getTextForState('PAUSED'), 'Pausado');
      expect(statusUtils.getTextForState('IN_OPERATION'), 'En operación');
      expect(statusUtils.getTextForState('WAIT_UPDATING'), 'Actualizando');
      expect(statusUtils.getTextForState('WAIT_POWER_UP'), 'Encendiendo');
      expect(statusUtils.getTextForState('RESTRICTED'), 'Restringido');
      expect(statusUtils.getTextForState('OFF'), 'Apagado');
      expect(statusUtils.getTextForState('STOPPED'), 'Parado');
      expect(statusUtils.getTextForState('ERROR'), 'Error');
      expect(statusUtils.getTextForState('FATAL_ERROR'), 'Error');
      expect(statusUtils.getTextForState('ERROR_AT_POWER_APP'), 'Error');
      expect(statusUtils.getTextForState('UNKNOWN_STATE'), 'Desconocido');
    });

    test('getTextForActivityAndState returns correct text', () {
      expect(statusUtils.getTextForActivityAndState('UNKNOWN', 'ANY'), 'Desconocido');
      expect(statusUtils.getTextForActivityAndState('NOT_APPLICABLE', 'PAUSED'), 'Pausado');
      expect(statusUtils.getTextForActivityAndState('MOWING', 'ANY'), 'Segando');
      expect(statusUtils.getTextForActivityAndState('GOING_HOME', 'ANY'), 'Volviendo');
      expect(statusUtils.getTextForActivityAndState('CHARGING', 'ANY'), 'Cargando');
      expect(statusUtils.getTextForActivityAndState('LEAVING', 'ANY'), 'Arrancando');
      expect(statusUtils.getTextForActivityAndState('PARKED_IN_CS', 'ANY'), 'Aparcado');
      expect(statusUtils.getTextForActivityAndState('STOPPED_IN_GARDEN', 'ANY'), 'Parado');
      expect(statusUtils.getTextForActivityAndState('UNKNOWN_ACTIVITY', 'ANY'), 'Desconocido');
    });
  });
}
