/// Represents a single tile in the Minesweeper grid
class Tile {
  final int row;
  final int col;
  
  bool isMine;
  bool isRevealed;
  bool isFlagged;
  int adjacentMines;
  
  Tile({
    required this.row,
    required this.col,
    this.isMine = false,
    this.isRevealed = false,
    this.isFlagged = false,
    this.adjacentMines = 0,
  });
  
  /// Create a copy of this tile with modified properties
  Tile copyWith({
    bool? isMine,
    bool? isRevealed,
    bool? isFlagged,
    int? adjacentMines,
  }) {
    return Tile(
      row: row,
      col: col,
      isMine: isMine ?? this.isMine,
      isRevealed: isRevealed ?? this.isRevealed,
      isFlagged: isFlagged ?? this.isFlagged,
      adjacentMines: adjacentMines ?? this.adjacentMines,
    );
  }
  
  @override
  String toString() {
    return 'Tile($row,$col: mine=$isMine, revealed=$isRevealed, flagged=$isFlagged, adjacent=$adjacentMines)';
  }
}
