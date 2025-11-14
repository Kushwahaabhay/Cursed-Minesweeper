import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

/// Singleton audio manager for playing meme sounds on game events.
/// Supports volume control, mute toggle, and category-based sound filtering.
/// 
/// Usage:
///   AudioManager.instance.playExplosion();
///   AudioManager.instance.setVolume(0.5);
///   AudioManager.instance.toggleMute();
class AudioManager extends ChangeNotifier {
  static final AudioManager _instance = AudioManager._internal();
  static AudioManager get instance => _instance;
  
  AudioManager._internal();
  
  // Audio file paths - CHANGE THESE if you use different filenames
  static const String _explosionSound = 'sounds/explosion.ogg';
  static const String _bachGayaSound = 'sounds/bach_gaya.ogg';
  static const String _flagSound = 'sounds/flag.ogg';
  static const String _clickSound = 'sounds/click.ogg';
  static const String _winSound = 'sounds/win.ogg';
  static const String _loseSound = 'sounds/lose.ogg';
  
  // Multiple players to allow overlapping sounds
  final List<AudioPlayer> _players = [];
  final int _maxPlayers = 5;
  int _currentPlayerIndex = 0;
  
  // Settings
  double _volume = 0.7; // 0.0 to 1.0
  bool _isMuted = false;
  bool _explosionsEnabled = true;
  bool _safeSoundsEnabled = true;
  
  // Getters
  double get volume => _volume;
  bool get isMuted => _isMuted;
  bool get explosionsEnabled => _explosionsEnabled;
  bool get safeSoundsEnabled => _safeSoundsEnabled;
  
  /// Initialize audio players
  Future<void> initialize() async {
    // Create multiple audio players for overlapping sounds
    for (int i = 0; i < _maxPlayers; i++) {
      _players.add(AudioPlayer());
    }
    
    // Load saved settings
    await _loadSettings();
  }
  
  /// Load settings from shared preferences
  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _volume = prefs.getDouble('audio_volume') ?? 0.7;
      _isMuted = prefs.getBool('audio_muted') ?? false;
      _explosionsEnabled = prefs.getBool('explosions_enabled') ?? true;
      _safeSoundsEnabled = prefs.getBool('safe_sounds_enabled') ?? true;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading audio settings: $e');
      }
    }
  }
  
  /// Save settings to shared preferences
  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('audio_volume', _volume);
      await prefs.setBool('audio_muted', _isMuted);
      await prefs.setBool('explosions_enabled', _explosionsEnabled);
      await prefs.setBool('safe_sounds_enabled', _safeSoundsEnabled);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving audio settings: $e');
      }
    }
  }
  
  /// Get next available player (round-robin for overlapping sounds)
  AudioPlayer _getNextPlayer() {
    final player = _players[_currentPlayerIndex];
    _currentPlayerIndex = (_currentPlayerIndex + 1) % _maxPlayers;
    return player;
  }
  
  /// Play a sound file
  Future<void> _playSound(String assetPath) async {
    if (_isMuted) return;
    
    try {
      final player = _getNextPlayer();
      await player.stop(); // Stop any previous sound on this player
      await player.setVolume(_volume);
      await player.play(AssetSource(assetPath));
    } catch (e) {
      if (kDebugMode) {
        print('Error playing sound $assetPath: $e');
      }
    }
  }
  
  /// Play explosion sound (when mine is hit)
  Future<void> playExplosion() async {
    if (!_explosionsEnabled) return;
    
    // Randomly choose between explosion and bach_gaya for variety
    final random = Random();
    final soundFile = random.nextBool() ? _explosionSound : _bachGayaSound;
    await _playSound(soundFile);
  }
  
  /// Play bach gaya sound (alternative explosion)
  Future<void> playBachGaya() async {
    if (!_explosionsEnabled) return;
    await _playSound(_bachGayaSound);
  }
  
  /// Play flag sound (placing/removing flag)
  Future<void> playFlag() async {
    if (!_safeSoundsEnabled) return;
    await _playSound(_flagSound);
  }
  
  /// Play click sound (revealing safe tile)
  Future<void> playClick() async {
    if (!_safeSoundsEnabled) return;
    await _playSound(_clickSound);
  }
  
  /// Play win sound (game completed successfully)
  Future<void> playWin() async {
    if (!_safeSoundsEnabled) return;
    await _playSound(_winSound);
  }
  
  /// Play lose sound (game over)
  Future<void> playLose() async {
    if (!_explosionsEnabled) return;
    await _playSound(_loseSound);
  }
  
  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    notifyListeners();
    await _saveSettings();
  }
  
  /// Toggle mute on/off
  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    notifyListeners();
    await _saveSettings();
  }
  
  /// Toggle explosion sounds
  Future<void> toggleExplosions() async {
    _explosionsEnabled = !_explosionsEnabled;
    notifyListeners();
    await _saveSettings();
  }
  
  /// Toggle safe sounds (click, flag, win)
  Future<void> toggleSafeSounds() async {
    _safeSoundsEnabled = !_safeSoundsEnabled;
    notifyListeners();
    await _saveSettings();
  }
  
  /// Dispose all players
  @override
  void dispose() {
    for (final player in _players) {
      player.dispose();
    }
    super.dispose();
  }
}
