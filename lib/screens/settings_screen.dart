import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../audio_manager.dart';
import 'sound_test_screen.dart';

/// Settings screen for audio and game preferences
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        title: const Text('SETTINGS'),
        backgroundColor: const Color(0xFF0a0a0a),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<AudioManager>(
        builder: (context, audioManager, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSection(
                title: 'AUDIO SETTINGS',
                children: [
                  // Master volume slider
                  ListTile(
                    title: const Text(
                      'VOLUME',
                      style: TextStyle(color: Color(0xFF00FF00), fontSize: 12),
                    ),
                    subtitle: Slider(
                      value: audioManager.volume,
                      onChanged: (value) {
                        audioManager.setVolume(value);
                      },
                      activeColor: const Color(0xFF00FF00),
                      inactiveColor: const Color(0xFF00FF00).withOpacity(0.3),
                    ),
                    trailing: Text(
                      '${(audioManager.volume * 100).round()}%',
                      style: const TextStyle(
                        color: Color(0xFF00FF00),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  
                  const Divider(color: Color(0xFF00FF00)),
                  
                  // Mute all toggle
                  SwitchListTile(
                    title: const Text(
                      'MUTE ALL',
                      style: TextStyle(color: Color(0xFF00FF00), fontSize: 12),
                    ),
                    value: audioManager.isMuted,
                    onChanged: (_) => audioManager.toggleMute(),
                    activeColor: const Color(0xFF00FF00),
                  ),
                  
                  const Divider(color: Color(0xFF00FF00)),
                  
                  // Explosion sounds toggle
                  SwitchListTile(
                    title: const Text(
                      'EXPLOSION SOUNDS',
                      style: TextStyle(color: Color(0xFF00FF00), fontSize: 12),
                    ),
                    subtitle: const Text(
                      'Mine hits, game over',
                      style: TextStyle(color: Color(0xFF00FF00), fontSize: 10),
                    ),
                    value: audioManager.explosionsEnabled,
                    onChanged: (_) => audioManager.toggleExplosions(),
                    activeColor: const Color(0xFF00FF00),
                  ),
                  
                  const Divider(color: Color(0xFF00FF00)),
                  
                  // Safe sounds toggle
                  SwitchListTile(
                    title: const Text(
                      'SAFE SOUNDS',
                      style: TextStyle(color: Color(0xFF00FF00), fontSize: 12),
                    ),
                    subtitle: const Text(
                      'Clicks, flags, win',
                      style: TextStyle(color: Color(0xFF00FF00), fontSize: 10),
                    ),
                    value: audioManager.safeSoundsEnabled,
                    onChanged: (_) => audioManager.toggleSafeSounds(),
                    activeColor: const Color(0xFF00FF00),
                  ),
                  
                  const Divider(color: Color(0xFF00FF00)),
                  
                  // Sound test button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SoundTestScreen(),
                          ),
                        );
                      },
                      child: const Text('TEST SOUNDS'),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              _buildSection(
                title: 'ABOUT',
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cursed Minesweeper v1.0',
                          style: TextStyle(
                            color: Color(0xFF00FF00),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'A retro Minesweeper with meme audio.',
                          style: TextStyle(
                            color: Color(0xFF00FF00),
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Made with 💀 by Abhay',
                          style: TextStyle(
                            color: Color(0xFF00FF00),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildSection({required String title, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        border: Border.all(color: const Color(0xFF00FF00), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF00FF00),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
