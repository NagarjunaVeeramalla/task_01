import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnableBlueToothScreen extends StatefulWidget {
  static String routeName = '/blueToothScreen';

  const EnableBlueToothScreen({Key? key}) : super(key: key);

  @override
  State<EnableBlueToothScreen> createState() => _EnableBlueToothScreenState();
}

class _EnableBlueToothScreenState extends State<EnableBlueToothScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final Future<void> result =
        _channel.invokeMethod(getStartingState).then((value) {
      if (value == methodBlueToothOn) {
        bluetoothStatus = 'STATUS : $value';
        _bluetoothValue = true;
      } else {
        bluetoothStatus = 'STATUS : $value';
        _bluetoothValue = false;
      }
      setState(() {});
    });
  }

  static const _channel = MethodChannel('com.example.channel/bluetooth');
  static const methodBlueToothOn = 'BluetoothStateOn';
  static const methodBlueToothOff = 'BluetoothStateOff';
  static const getStartingState = 'startingState';

  bool _bluetoothValue = false;
  String bluetoothStatus = methodBlueToothOff;

  Future<void> _turnOnOrOffBluetooth() async {
    try {
      if (_bluetoothValue) {
        final String result = await _channel.invokeMethod(methodBlueToothOn);
        bluetoothStatus = 'STATUS : $result';
        _bluetoothValue = true;
        setState(() {});
      } else {
        final String result = await _channel.invokeMethod(methodBlueToothOff);
        bluetoothStatus = 'STATUS : $result';
        _bluetoothValue = false;
        setState(() {});
      }
    } on PlatformException catch (e) {
      _bluetoothValue = false;
      bluetoothStatus = "Failed to get bluetooth status '${e.message}'.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Native'),
      ),
      body: SwitchListTile(
        value: _bluetoothValue,
        onChanged: (bool value) {
          setState(() {
            _bluetoothValue = value;
            _turnOnOrOffBluetooth();
          });
        },
        title: Text(bluetoothStatus),
      ),
    );
  }
}
