import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../game/difficulty.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

/// Home screen with difficulty selection and high scores
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Difficulty _selectedDifficulty = Difficulty.beginner; // Default difficulty
  Map<String, int> _bestTimes = {};
  
  @override
  void initState() {
    super.initState();
    _loadBestTimes();
  }
  
  /// Load best times from shared preferences
  Future<void> _loadBestTimes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _bestTimes = {
        'Beginner': prefs.getInt('best_time_beginner') ?? 999,
        'Intermediate': prefs.getInt('best_time_intermediate') ?? 999,
        'Expert': prefs.getInt('best_time_expert') ?? 999,
      };
    });
  }
  
  /// Format time as MM:SS
  String _formatTime(int seconds) {
    if (seconds == 999) return '--:--';
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
  
  void _startGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(difficulty: _selectedDifficulty),
      ),
    ).then((_) => _loadBestTimes()); // Reload times when returning
  }
  
  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                
                // Title
                Text(
                  'CURSED\nMINESWEEPER',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF00FF00),
                    fontSize: 24,
                    shadows: [
                      Shadow(
                        color: const Color(0xFF00FF00).withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 10),
                
                // Subtitle
                const Text(
                  '💀 WITH AUDIO 💀',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFF00FF),
                    fontSize: 12,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Difficulty selection
                _buildSection(
                  title: 'SELECT DIFFICULTY',
                  child: Column(
                    children: Difficulty.presets.map((difficulty) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: _buildDifficultyButton(difficulty),
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Best times
                _buildSection(
                  title: 'BEST TIMES',
                  child: Column(
                    children: [
                      _buildBestTime('Beginner', _bestTimes['Beginner'] ?? 999),
                      const SizedBox(height: 8),
                      _buildBestTime('Intermediate', _bestTimes['Intermediate'] ?? 999),
                      const SizedBox(height: 8),
                      _buildBestTime('Expert', _bestTimes['Expert'] ?? 999),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Play button
                ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: const Color(0xFF00FF00),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    'START GAME',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Settings button
                OutlinedButton(
                  onPressed: _openSettings,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFF00FF00), width: 2),
                  ),
                  child: const Text('SETTINGS'),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        border: Border.all(color: const Color(0xFF00FF00), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF00FF00),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
  
  Widget _buildDifficultyButton(Difficulty difficulty) {
    final isSelected = _selectedDifficulty == difficulty;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedDifficulty = difficulty),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00FF00).withOpacity(0.2) : Colors.transparent,
          border: Border.all(
            color: isSelected ? const Color(0xFF00FF00) : const Color(0xFF00FF00).withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              difficulty.name.toUpperCase(),
              style: TextStyle(
                color: isSelected ? const Color(0xFF00FF00) : const Color(0xFF00FF00).withOpacity(0.6),
                fontSize: 10,
              ),
            ),
            Text(
              '${difficulty.rows}×${difficulty.cols} · ${difficulty.mines} mines',
              style: TextStyle(
                color: isSelected ? const Color(0xFF00FF00) : const Color(0xFF00FF00).withOpacity(0.6),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBestTime(String difficultyName, int seconds) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          difficultyName,
          style: const TextStyle(
            color: Color(0xFF00FF00),
            fontSize: 10,
          ),
        ),
        Text(
          _formatTime(seconds),
          style: const TextStyle(
            color: Color(0xFFFF00FF),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
