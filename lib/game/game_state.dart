import 'dart:math';
import 'package:flutter/foundation.dart';
import 'tile.dart';
import 'difficulty.dart';

/// Represents the game state (win, lose, playing)
enum GameStatus { playing, won, lost }

/// Core Minesweeper game logic
/// Handles mine placement, tile revealing, flood fill, win/lose detection
class GameState extends ChangeNotifier {
  late Difficulty difficulty;
  late List<List<Tile>> grid;
  late GameStatus status;
  late int flagCount;
  late DateTime? startTime;
  late int elapsedSeconds;
  
  // For timer updates
  bool _timerActive = false;
  
  GameState({required Difficulty initialDifficulty}) {
    difficulty = initialDifficulty;
    _initializeGame();
  }
  
  /// Initialize a new game
  void _initializeGame() {
    status = GameStatus.playing;
    flagCount = 0;
    startTime = null;
    elapsedSeconds = 0;
    _timerActive = false;
    
    // Create empty grid
    grid = List.generate(
      difficulty.rows,
      (row) => List.generate(
        difficulty.cols,
        (col) => Tile(row: row, col: col),
      ),
    );
    
    // Place mines randomly
    _placeMines();
    
    // Calculate adjacent mine counts
    _calculateAdjacentMines();
    
    notifyListeners();
  }
  
  /// Place mines randomly on the grid
  void _placeMines() {
    final random = Random();
    int minesPlaced = 0;
    
    while (minesPlaced < difficulty.mines) {
      final row = random.nextInt(difficulty.rows);
      final col = random.nextInt(difficulty.cols);
      
      if (!grid[row][col].isMine) {
        grid[row][col].isMine = true;
        minesPlaced++;
      }
    }
  }
  
  /// Calculate adjacent mine counts for all tiles
  void _calculateAdjacentMines() {
    for (int row = 0; row < difficulty.rows; row++) {
      for (int col = 0; col < difficulty.cols; col++) {
        if (!grid[row][col].isMine) {
          grid[row][col].adjacentMines = _countAdjacentMines(row, col);
        }
      }
    }
  }
  
  /// Count mines in the 8 adjacent tiles
  int _countAdjacentMines(int row, int col) {
    int count = 0;
    
    for (int dr = -1; dr <= 1; dr++) {
      for (int dc = -1; dc <= 1; dc++) {
        if (dr == 0 && dc == 0) continue; // Skip self
        
        final newRow = row + dr;
        final newCol = col + dc;
        
        if (_isValidPosition(newRow, newCol) && grid[newRow][newCol].isMine) {
          count++;
        }
      }
    }
    
    return count;
  }
  
  /// Check if position is within grid bounds
  bool _isValidPosition(int row, int col) {
    return row >= 0 && row < difficulty.rows && col >= 0 && col < difficulty.cols;
  }
  
  /// Reveal a tile (main game action)
  /// Returns true if explosion occurred
  bool revealTile(int row, int col) {
    if (status != GameStatus.playing) return false;
    if (!_isValidPosition(row, col)) return false;
    
    final tile = grid[row][col];
    
    // Can't reveal flagged tiles
    if (tile.isFlagged) return false;
    
    // Already revealed
    if (tile.isRevealed) return false;
    
    // Start timer on first reveal
    if (startTime == null) {
      startTime = DateTime.now();
      _timerActive = true;
    }
    
    // Reveal the tile
    tile.isRevealed = true;
    
    // Hit a mine - game over
    if (tile.isMine) {
      status = GameStatus.lost;
      _timerActive = false;
      _revealAllMines();
      notifyListeners();
      return true; // Explosion!
    }
    
    // If tile has no adjacent mines, reveal neighbors (flood fill)
    if (tile.adjacentMines == 0) {
      _floodFillReveal(row, col);
    }
    
    // Check for win condition
    _checkWinCondition();
    
    notifyListeners();
    return false;
  }
  
  /// Flood fill algorithm to reveal empty tiles and their neighbors
  void _floodFillReveal(int row, int col) {
    // Use a queue for iterative flood fill (avoid stack overflow on large grids)
    final queue = <List<int>>[[row, col]];
    final visited = <String>{};
    
    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      final r = current[0];
      final c = current[1];
      
      final key = '$r,$c';
      if (visited.contains(key)) continue;
      visited.add(key);
      
      // Check all 8 adjacent tiles
      for (int dr = -1; dr <= 1; dr++) {
        for (int dc = -1; dc <= 1; dc++) {
          if (dr == 0 && dc == 0) continue;
          
          final newRow = r + dr;
          final newCol = c + dc;
          
          if (!_isValidPosition(newRow, newCol)) continue;
          
          final neighbor = grid[newRow][newCol];
          
          if (!neighbor.isRevealed && !neighbor.isFlagged && !neighbor.isMine) {
            neighbor.isRevealed = true;
            
            // If neighbor also has no adjacent mines, add to queue
            if (neighbor.adjacentMines == 0) {
              queue.add([newRow, newCol]);
            }
          }
        }
      }
    }
  }
  
  /// Toggle flag on a tile
  void toggleFlag(int row, int col) {
    if (status != GameStatus.playing) return;
    if (!_isValidPosition(row, col)) return;
    
    final tile = grid[row][col];
    
    // Can't flag revealed tiles
    if (tile.isRevealed) return;
    
    if (tile.isFlagged) {
      tile.isFlagged = false;
      flagCount--;
    } else {
      // Only allow flagging if we haven't exceeded mine count
      if (flagCount < difficulty.mines) {
        tile.isFlagged = true;
        flagCount++;
      }
    }
    
    notifyListeners();
  }
  
  /// Reveal all mines (called when game is lost)
  void _revealAllMines() {
    for (final row in grid) {
      for (final tile in row) {
        if (tile.isMine) {
          tile.isRevealed = true;
        }
      }
    }
  }
  
  /// Check if player has won
  void _checkWinCondition() {
    // Win condition: all non-mine tiles are revealed
    for (final row in grid) {
      for (final tile in row) {
        if (!tile.isMine && !tile.isRevealed) {
          return; // Still have unrevealed safe tiles
        }
      }
    }
    
    // All safe tiles revealed - player wins!
    status = GameStatus.won;
    _timerActive = false;
    
    // Auto-flag remaining mines
    for (final row in grid) {
      for (final tile in row) {
        if (tile.isMine && !tile.isFlagged) {
          tile.isFlagged = true;
          flagCount++;
        }
      }
    }
  }
  
  /// Reset game with same difficulty
  void resetGame() {
    _initializeGame();
  }
  
  /// Start new game with different difficulty
  void newGame(Difficulty newDifficulty) {
    difficulty = newDifficulty;
    _initializeGame();
  }
  
  /// Get remaining mine count (total mines - flags placed)
  int get remainingMines => difficulty.mines - flagCount;
  
  /// Update elapsed time (call this from a timer in UI)
  void updateTimer() {
    if (_timerActive && startTime != null) {
      elapsedSeconds = DateTime.now().difference(startTime!).inSeconds;
      notifyListeners();
    }
  }
  
  /// Format elapsed time as MM:SS
  String get formattedTime {
    final minutes = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
