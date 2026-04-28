import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mafbase_stream/mafbase_stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _mafbaseStreamPlugin = MafbaseStream();
  final _rtmpUrlController = TextEditingController(text: 'rtmp://192.168.0.179/live');
  final _streamKeyController = TextEditingController(text: 'test');
  String _status = 'Press the button to ping native';

  @override
  void dispose() {
    _rtmpUrlController.dispose();
    _streamKeyController.dispose();
    super.dispose();
  }

  Future<void> _pingNative() async {
    String platformVersion;
    try {
      platformVersion = await _mafbaseStreamPlugin.getPlatformVersion();
    } on PlatformException catch (e) {
      platformVersion = 'Failed to get platform version: ${e.message}';
    }

    if (!mounted) return;

    setState(() {
      _status = platformVersion;
    });
  }

  Future<void> _openStreamScreen({MafbaseOverlay? overlay}) async {
    setState(() => _status = 'Opening stream screen…');
    try {
      await _mafbaseStreamPlugin.openStreamScreen(
        rtmpUrl: _rtmpUrlController.text.trim(),
        streamKey: _streamKeyController.text.trim(),
        overlay: overlay,
        tournamentId: 517,
        table: 1,
      );
      if (!mounted) return;
      setState(() => _status = 'Stream screen closed');
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() => _status = 'Stream screen error: ${e.code} ${e.message ?? ''}');
    }
  }

  Future<void> _openOverlayPreview() async {
    setState(() => _status = 'Opening overlay preview…');
    try {
      await _mafbaseStreamPlugin.openOverlayPreview(
        overlay: MafbaseOverlay.plashkiMafbase,
        tournamentId: 517,
        table: 1,
      );
      if (!mounted) return;
      setState(() => _status = 'Overlay preview closed');
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() => _status = 'Overlay preview error: ${e.code} ${e.message ?? ''}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('mafbase_stream example')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(_status, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                TextField(
                  controller: _rtmpUrlController,
                  decoration: const InputDecoration(
                    labelText: 'RTMP URL',
                    helperText: 'Эмулятор: rtmp://10.0.2.2/live · реальное устройство: rtmp://<host-ip>/live',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _streamKeyController,
                  decoration: const InputDecoration(labelText: 'Stream key', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: _pingNative, child: const Text('Ping native')),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: () => _openStreamScreen(), child: const Text('Открыть стрим')),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _openStreamScreen(overlay: MafbaseOverlay.plashkiMafbase),
                  child: const Text('Стрим с плашкой Mafbase'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: _openOverlayPreview, child: const Text('Превью плашки')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
