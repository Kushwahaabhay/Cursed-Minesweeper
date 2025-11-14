import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../game/game_state.dart';
import '../game/difficulty.dart';
import '../audio_manager.dart';
import '../widgets/tile_widget.dart';
import '../widgets/game_controls.dart';
import '../widgets/retro_background.dart';
import 'settings_screen.dart';

/// Main game screen with Minesweeper grid
class GameScreen extends StatefulWidget {
  final Difficulty difficulty;
  
  const GameScreen({super.key, required this.difficulty});
  
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late GameState _gameState;
  late Timer _timer;
  late AnimationController _shakeController;
  bool _flagMode = false; // Toggle between reveal and flag mode
  
  @override
  void initState() {
    super.initState();
    _gameState = GameState(initialDifficulty: widget.difficulty);
    
    // Timer for updating game time
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _gameState.updateTimer();
      }
    });
    
    // Animation controller for screen shake on explosion
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _timer.cancel();
    _shakeController.dispose();
    super.dispose();
  }
  
  /// Handle tile tap
  void _onTileTap(int row, int col) {
    if (_flagMode) {
      // Flag mode: tap to flag
      _gameState.toggleFlag(row, col);
      AudioManager.instance.playFlag();
    } else {
      // Reveal mode: tap to reveal
      final hitMine = _gameState.revealTile(row, col);
      
      if (hitMine) {
        // Play explosion and shake screen
        AudioManager.instance.playExplosion();
        _shakeController.forward(from: 0.0);
        _showGameOverDialog(won: false);
      } else if (_gameState.status == GameStatus.won) {
        // Player won!
        AudioManager.instance.playWin();
        _saveScore();
        _showGameOverDialog(won: true);
      } else {
        // Normal click
        AudioManager.instance.playClick();
      }
    }
  }
  
  /// Handle tile long press
  void _onTileLongPress(int row, int col) {
    if (_flagMode) {
      // Flag mode: long press to reveal
      final hitMine = _gameState.revealTile(row, col);
      
      if (hitMine) {
        AudioManager.instance.playExplosion();
        _shakeController.forward(from: 0.0);
        _showGameOverDialog(won: false);
      } else if (_gameState.status == GameStatus.won) {
        AudioManager.instance.playWin();
        _saveScore();
        _showGameOverDialog(won: true);
      } else {
        AudioManager.instance.playClick();
      }
    } else {
      // Reveal mode: long press to flag
      _gameState.toggleFlag(row, col);
      AudioManager.instance.playFlag();
    }
  }
  
  /// Save score if it's a new best time
  Future<void> _saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    final difficultyKey = widget.difficulty.name.toLowerCase();
    final bestTime = prefs.getInt('best_time_$difficultyKey') ?? 999;
    
    if (_gameState.elapsedSeconds < bestTime) {
      await prefs.setInt('best_time_$difficultyKey', _gameState.elapsedSeconds);
    }
  }
  
  /// Show game over dialog
  void _showGameOverDialog({required bool won}) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1a1a1a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(color: Color(0xFF00FF00), width: 2),
          ),
          title: Text(
            won ? 'YOU WIN! 🎉' : 'GAME OVER 💀',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: won ? const Color(0xFF00FF00) : const Color(0xFFFF0000),
              fontSize: 16,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                won ? 'Time: ${_gameState.formattedTime}' : 'You hit a mine!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF00FF00),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _gameState.resetGame();
                });
              },
              child: const Text('RETRY'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Return to home
              },
              child: const Text('MENU'),
            ),
          ],
        ),
      );
    });
  }
  
  /// Calculate tile size based on screen width
  double _calculateTileSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = 32.0; // Total horizontal padding
    final availableWidth = screenWidth - padding;
    final tileSize = availableWidth / widget.difficulty.cols;
    
    // Clamp tile size for readability
    return tileSize.clamp(20.0, 40.0);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      body: RetroBackground(
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _shakeController,
            builder: (context, child) {
              // Screen shake effect
              final offset = _shakeController.value * 10 * 
                  ((_shakeController.value * 4).floor() % 2 == 0 ? 1 : -1);
              
              return Transform.translate(
                offset: Offset(offset, 0),
                child: child,
              );
            },
            child: ListenableBuilder(
              listenable: _gameState,
              builder: (context, _) {
                final tileSize = _calculateTileSize(context);
                
                return Column(
                  children: [
                    // Game controls
                    GameControls(
                      timeText: _gameState.formattedTime,
                      remainingMines: _gameState.remainingMines,
                      onReset: () => setState(() => _gameState.resetGame()),
                      onSettings: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Flag mode toggle
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'TAP TO:',
                            style: TextStyle(
                              color: Color(0xFF00FF00),
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 16),
                          ChoiceChip(
                            label: const Text('REVEAL'),
                            selected: !_flagMode,
                            onSelected: (selected) {
                              setState(() => _flagMode = false);
                            },
                            selectedColor: const Color(0xFF00FF00).withOpacity(0.3),
                            labelStyle: TextStyle(
                              color: !_flagMode ? const Color(0xFF00FF00) : const Color(0xFF00FF00).withOpacity(0.5),
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ChoiceChip(
                            label: const Text('FLAG'),
                            selected: _flagMode,
                            onSelected: (selected) {
                              setState(() => _flagMode = true);
                            },
                            selectedColor: const Color(0xFFFF00FF).withOpacity(0.3),
                            labelStyle: TextStyle(
                              color: _flagMode ? const Color(0xFFFF00FF) : const Color(0xFF00FF00).withOpacity(0.5),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Minesweeper grid
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1a1a1a),
                                border: Border.all(
                                  color: const Color(0xFF00FF00),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  widget.difficulty.rows,
                                  (row) => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                      widget.difficulty.cols,
                                      (col) => TileWidget(
                                        tile: _gameState.grid[row][col],
                                        onTap: () => _onTileTap(row, col),
                                        onLongPress: () => _onTileLongPress(row, col),
                                        size: tileSize,
                                        isGameOver: _gameState.status == GameStatus.lost,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
