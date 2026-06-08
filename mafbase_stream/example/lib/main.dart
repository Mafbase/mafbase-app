import 'dart:async';
import 'dart:developer' as developer;

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
  // Если оба поля пустые — стрим идёт без overlay'я, иначе включается
  // plashki-mafbase с подпиской на seatingContent по этим параметрам.
  final _tournamentIdController = TextEditingController(text: '553');
  final _tableController = TextEditingController(text: '1');
  // Пусто → brand-слой не подключается.
  final _brandImageUrlController = TextEditingController(
    text: 'https://mafbase.ru/images/brand_overlay_1920x1080.png',
  );
  String _status = 'Нажми «Открыть стрим», чтобы запустить нативный экран';
  String _lastEvent = '—';
  StreamSubscription<StreamEvent>? _eventsSub;

  @override
  void initState() {
    super.initState();
    // Лог-подписка на события стрим-сессии. Live-канал, события приходят
    // только пока native-экран стрима открыт; в idle тут пусто.
    _eventsSub = _mafbaseStreamPlugin.events.listen(
      (event) {
        developer.log(event.toString(), name: 'mafbase_stream');
        if (mounted) setState(() => _lastEvent = event.toString());
      },
      onError: (Object e) {
        developer.log('events error: $e', name: 'mafbase_stream', error: e);
      },
    );
  }

  @override
  void dispose() {
    _eventsSub?.cancel();
    _rtmpUrlController.dispose();
    _streamKeyController.dispose();
    _tournamentIdController.dispose();
    _tableController.dispose();
    _brandImageUrlController.dispose();
    super.dispose();
  }

  Future<void> _openStreamScreen() async {
    final tournamentId = int.tryParse(_tournamentIdController.text.trim());
    final table = int.tryParse(_tableController.text.trim());
    final hasOverlay = tournamentId != null && table != null;
    final brand = _brandImageUrlController.text.trim();
    final brandImageUrl = brand.isEmpty ? null : brand;

    setState(() => _status = hasOverlay ? 'Открываю стрим с плашкой…' : 'Открываю стрим без overlay…');
    try {
      await _mafbaseStreamPlugin.openStreamScreen(
        rtmpUrl: _rtmpUrlController.text.trim(),
        streamKey: _streamKeyController.text.trim(),
        overlay: hasOverlay ? MafbaseOverlay.plashkiMafbase : null,
        tournamentId: tournamentId,
        table: table,
        brandImageUrl: brandImageUrl,
      );
      if (!mounted) return;
      setState(() => _status = 'Stream screen closed');
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() => _status = 'Stream screen error: ${e.code} ${e.message ?? ''}');
    }
  }

  Future<void> _openOverlayPreview() async {
    final tournamentId = int.tryParse(_tournamentIdController.text.trim());
    final table = int.tryParse(_tableController.text.trim());
    setState(() => _status = 'Opening overlay preview…');
    try {
      await _mafbaseStreamPlugin.openOverlayPreview(
        overlay: MafbaseOverlay.plashkiMafbase,
        tournamentId: tournamentId,
        table: table,
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
                const SizedBox(height: 8),
                Text(
                  'Last event: $_lastEvent',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _tournamentIdController,
                        decoration: const InputDecoration(
                          labelText: 'Tournament ID',
                          helperText: 'Пусто → без overlay',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _tableController,
                        decoration: const InputDecoration(
                          labelText: 'Table',
                          helperText: 'Пусто → без overlay',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _brandImageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Brand image URL',
                    helperText: 'PNG с прозрачным фоном · пусто → без брендирования',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: _openStreamScreen, child: const Text('Открыть стрим')),
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
