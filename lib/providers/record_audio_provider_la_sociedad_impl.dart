import 'dart:core';

import 'package:flutter/material.dart';
import 'package:proyectemos/services/permission_management.dart';
import '../services/storage_management.dart';
import 'package:record/record.dart';
import '../services/toast_services.dart';
import 'audio_provider_interface.dart';

class RecordAudioLaSociedadProviderImpl extends ChangeNotifier
    implements AudioProvider {
  final AudioRecorder _record = AudioRecorder();
  String _afterRecordingFilePath = '';
  static List<String> recordingsPaths = [];

  late bool isRecording = false;
  bool _recordsDeleted = false;

  bool get recordsDeleted => _recordsDeleted;
  String get recordedFilePath => _afterRecordingFilePath;

  @override
  List<dynamic> clearOldData() {
    _afterRecordingFilePath = '';
    if (recordingsPaths.length > 4) {
      return recordingsPaths = [];
    }
    notifyListeners();
    return recordingsPaths;
  }

  @override
  void clearAllData() {
    _afterRecordingFilePath = '';
    recordingsPaths = [];
    notifyListeners();
  }

  @override
  Future<void> recordVoice() async {
    final isPermitted = (await PermissionManagement.recordingPermission()) &&
        (await PermissionManagement.storagePermission());
    if (!isPermitted) return;
    if (!(await _record.hasPermission())) return;
    final voiceDirPath = await StorageManagement.getAudioDir;
    final voiceFilePath = StorageManagement.createRecordAudioPath(
      dirPath: voiceDirPath,
      fileName: 'audio_message',
    );
    await _record.start(const RecordConfig(), path: voiceFilePath);
    isRecording = true;
    notifyListeners();
    showToast('Comenzó la grabación');
  }

  @override
  Future<void> stopRecording() async {
    String? audioFilePath;

    if (await _record.isRecording()) {
      audioFilePath = await _record.stop();
      showToast('Grabación detenida');
    }
    isRecording = false;
    _afterRecordingFilePath = audioFilePath ?? '';
    notifyListeners();
  }

  @override
  void cancelRecording() {
    _recordsDeleted = true;
    clearOldData();
    notifyListeners();
  }

  @override
  void saveRecording() {
    recordingsPaths.add(_afterRecordingFilePath);
    clearOldData();
    showToast('Grabación guardada');
    notifyListeners();
  }
}
