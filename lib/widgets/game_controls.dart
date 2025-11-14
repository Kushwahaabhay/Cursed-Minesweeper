import 'package:flutter/material.dart';

/// Game controls widget showing timer, mine counter, and reset button
class GameControls extends StatelessWidget {
  final String timeText;
  final int remainingMines;
  final VoidCallback onReset;
  final VoidCallback onSettings;
  
  const GameControls({
    super.key,
    required this.timeText,
    required this.remainingMines,
    required this.onReset,
    required this.onSettings,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        border: Border.all(color: const Color(0xFF00FF00), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Mine counter
          _buildCounter(
            icon: Icons.security,
            value: remainingMines.toString().padLeft(3, '0'),
          ),
          
          // Reset button
          IconButton(
            onPressed: onReset,
            icon: const Icon(Icons.refresh),
            color: const Color(0xFFFF00FF),
            iconSize: 32,
          ),
          
          // Timer
          _buildCounter(
            icon: Icons.timer,
            value: timeText,
          ),
          
          // Settings button
          IconButton(
            onPressed: onSettings,
            icon: const Icon(Icons.settings),
            color: const Color(0xFF00FF00),
            iconSize: 28,
          ),
        ],
      ),
    );
  }
  
  Widget _buildCounter({required IconData icon, required String value}) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF00FF00), size: 24),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF00FF00),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
