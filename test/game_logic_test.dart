import 'package:flutter_test/flutter_test.dart';
import 'package:cursed_minesweeper/game/game_state.dart';
import 'package:cursed_minesweeper/game/difficulty.dart';
import 'package:cursed_minesweeper/game/tile.dart';

void main() {
  group('GameState Tests', () {
    test('Game initializes with correct grid size', () {
      final gameState = GameState(initialDifficulty: Difficulty.beginner);
      
      expect(gameState.grid.length, equals(9)); // 9 rows
      expect(gameState.grid[0].length, equals(9)); // 9 cols
      expect(gameState.status, equals(GameStatus.playing));
    });
    
    test('Correct number of mines are placed after first click', () {
      final gameState = GameState(initialDifficulty: Difficulty.beginner);
      
      // Mines should be 0 before first click
      int mineCount = 0;
      for (final row in gameState.grid) {
        for (final tile in row) {
          if (tile.isMine) mineCount++;
        }
      }
      expect(mineCount, equals(0)); // No mines before first click
      
      // Make first click
      gameState.revealTile(0, 0);
      
      // Now count mines
      mineCount = 0;
      for (final row in gameState.grid) {
        for (final tile in row) {
          if (tile.isMine) mineCount++;
        }
      }
      
      expect(mineCount, equals(10)); // Beginner has 10 mines after first click
    });
    
    test('Adjacent mine counts are calculated correctly', () {
      final gameState = GameState(initialDifficulty: Difficulty.beginner);
      
      // Make first click to place mines
      gameState.revealTile(4, 4); // Click center
      
      for (int row = 0; row < gameState.difficulty.rows; row++) {
        for (int col = 0; col < gameState.difficulty.cols; col++) {
          final tile = gameState.grid[row][col];
          
          if (!tile.isMine) {
            // Manually count adjacent mines
            int expectedCount = 0;
            for (int dr = -1; dr <= 1; dr++) {
              for (int dc = -1; dc <= 1; dc++) {
                if (dr == 0 && dc == 0) continue;
                
                final newRow = row + dr;
                final newCol = col + dc;
                
                if (newRow >= 0 && newRow < 9 && newCol >= 0 && newCol < 9) {
                  if (gameState.grid[newRow][newCol].isMine) {
                    expectedCount++;
                  }
                }
              }
            }
            
            expect(tile.adjacentMines, equals(expectedCount),
                reason: 'Tile at ($row, $col) should have $expectedCount adjacent mines');
          }
        }
      }
    });
    
    test('Revealing a safe tile works', () {
      final gameState = GameState(initialDifficulty: Difficulty.beginner);
      
      // First click is always safe now
      final hitMine = gameState.revealTile(0, 0);
      
      expect(hitMine, isFalse);
      expect(gameState.grid[0][0].isRevealed, isTrue);
      expect(gameState.status, equals(GameStatus.playing));
    });
    
    test('First click is always safe (no mine on clicked tile or neighbors)', () {
      final gameState = GameState(initialDifficulty: Difficulty.beginner);
      
      // Click center tile
      final clickRow = 4;
      final clickCol = 4;
      gameState.revealTile(clickRow, clickCol);
      
      // Check that clicked tile and all 8 neighbors have no mines
      for (int dr = -1; dr <= 1; dr++) {
        for (int dc = -1; dc <= 1; dc++) {
          final row = clickRow + dr;
          final col = clickCol + dc;
          
          if (row >= 0 && row < 9 && col >= 0 && col < 9) {
            expect(gameState.grid[row][col].isMine, isFalse,
                reason: 'Tile at ($row, $col) should not be a mine (neighbor of first click)');
          }
        }
      }
    });
    
    test('Flagging a tile works', () {
      final gameState = GameState(initialDifficulty: Difficulty.beginner);
      final tile = gameState.grid[0][0];
      
      expect(tile.isFlagged, isFalse);
      expect(gameState.flagCount, equals(0));
      
      gameState.toggleFlag(0, 0);
      
      expect(tile.isFlagged, isTrue);
      expect(gameState.flagCount, equals(1));
      
      gameState.toggleFlag(0, 0);
      
      expect(tile.isFlagged, isFalse);
      expect(gameState.flagCount, equals(0));
    });
    
    test('Cannot reveal flagged tile', () {
      final gameState = GameState(initialDifficulty: Difficulty.beginner);
      final tile = gameState.grid[0][0];
      
      gameState.toggleFlag(0, 0);
      expect(tile.isFlagged, isTrue);
      
      gameState.revealTile(0, 0);
      expect(tile.isRevealed, isFalse); // Should not be revealed
    });
    
    test('Remaining mines count is correct', () {
      final gameState = GameState(initialDifficulty: Difficulty.beginner);
      
      expect(gameState.remainingMines, equals(10));
      
      gameState.toggleFlag(0, 0);
      expect(gameState.remainingMines, equals(9));
      
      gameState.toggleFlag(0, 1);
      expect(gameState.remainingMines, equals(8));
      
      gameState.toggleFlag(0, 0); // Remove flag
      expect(gameState.remainingMines, equals(9));
    });
  });
  
  group('Difficulty Tests', () {
    test('Preset difficulties have correct values', () {
      expect(Difficulty.beginner.rows, equals(9));
      expect(Difficulty.beginner.cols, equals(9));
      expect(Difficulty.beginner.mines, equals(10));
      
      expect(Difficulty.intermediate.rows, equals(16));
      expect(Difficulty.intermediate.cols, equals(16));
      expect(Difficulty.intermediate.mines, equals(40));
      
      expect(Difficulty.expert.rows, equals(16));
      expect(Difficulty.expert.cols, equals(30));
      expect(Difficulty.expert.mines, equals(99));
    });
    
    test('Custom difficulty validates constraints', () {
      final custom = Difficulty.custom(rows: 10, cols: 10, mines: 150);
      
      // Should clamp mines to max 80% of tiles
      expect(custom.mines, lessThanOrEqualTo(80));
    });
  });
  
  group('Tile Tests', () {
    test('Tile initializes with correct default values', () {
      final tile = Tile(row: 0, col: 0);
      
      expect(tile.row, equals(0));
      expect(tile.col, equals(0));
      expect(tile.isMine, isFalse);
      expect(tile.isRevealed, isFalse);
      expect(tile.isFlagged, isFalse);
      expect(tile.adjacentMines, equals(0));
    });
    
    test('Tile copyWith works correctly', () {
      final tile = Tile(row: 1, col: 2, isMine: true);
      final copy = tile.copyWith(isRevealed: true, isFlagged: true);
      
      expect(copy.row, equals(1));
      expect(copy.col, equals(2));
      expect(copy.isMine, isTrue);
      expect(copy.isRevealed, isTrue);
      expect(copy.isFlagged, isTrue);
    });
  });
}
