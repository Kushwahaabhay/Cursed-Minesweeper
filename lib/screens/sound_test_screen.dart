import 'package:flutter/material.dart';
import '../audio_manager.dart';

/// Screen to test all audio files
class SoundTestScreen extends StatelessWidget {
  const SoundTestScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        title: const Text('SOUND TEST'),
        backgroundColor: const Color(0xFF0a0a0a),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Test each sound by tapping the buttons below.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF00FF00),
                fontSize: 10,
              ),
            ),
            
            const SizedBox(height: 24),
            
            _buildSoundButton(
              context,
              label: 'EXPLOSION',
              description: 'Plays when you hit a mine',
              onPressed: () => AudioManager.instance.playExplosion(),
            ),
            
            const SizedBox(height: 12),
            
            _buildSoundButton(
              context,
              label: 'BACH GAYA',
              description: 'Alternative explosion sound',
              onPressed: () => AudioManager.instance.playBachGaya(),
            ),
            
            const SizedBox(height: 12),
            
            _buildSoundButton(
              context,
              label: 'FLAG',
              description: 'Placing or removing a flag',
              onPressed: () => AudioManager.instance.playFlag(),
            ),
            
            const SizedBox(height: 12),
            
            _buildSoundButton(
              context,
              label: 'CLICK',
              description: 'Revealing a safe tile',
              onPressed: () => AudioManager.instance.playClick(),
            ),
            
            const SizedBox(height: 12),
            
            _buildSoundButton(
              context,
              label: 'WIN',
              description: 'Game completed successfully',
              onPressed: () => AudioManager.instance.playWin(),
            ),
            
            const SizedBox(height: 12),
            
            _buildSoundButton(
              context,
              label: 'LOSE',
              description: 'Game over',
              onPressed: () => AudioManager.instance.playLose(),
            ),
            
            const Spacer(),
            
            const Text(
              'Make sure volume is up and audio is unmuted in settings!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFF00FF),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSoundButton(
    BuildContext context, {
    required String label,
    required String description,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        border: Border.all(color: const Color(0xFF00FF00), width: 2),
      ),
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF00FF00),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            color: Color(0xFF00FF00),
            fontSize: 10,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.play_arrow),
          color: const Color(0xFFFF00FF),
          onPressed: onPressed,
        ),
        onTap: onPressed,
      ),
    );
  }
}
