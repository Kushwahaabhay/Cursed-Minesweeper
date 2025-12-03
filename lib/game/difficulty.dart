/// Represents the difficulty level of the game
class Difficulty {
  final String name;
  final int rows;
  final int cols;
  final int mines;
  
  const Difficulty({
    required this.name,
    required this.rows,
    required this.cols,
    required this.mines,
  });
  
  // Preset difficulties
  static const beginner = Difficulty(
    name: 'Beginner',
    rows: 9,
    cols: 9,
    mines: 10,
  );
  
  static const intermediate = Difficulty(
    name: 'Intermediate',
    rows: 16,
    cols: 16,
    mines: 40,
  );
  
  static const expert = Difficulty(
    name: 'Expert',
    rows: 16,
    cols: 30,
    mines: 99,
  );
  
  static const master = Difficulty(
    name: 'Master',
    rows: 30,
    cols: 30,
    mines: 200,
  );
  
  static const insane = Difficulty(
    name: 'Insane',
    rows: 40,
    cols: 40,
    mines: 400,
  );
  
  static const nightmare = Difficulty(
    name: 'Nightmare',
    rows: 50,
    cols: 50,
    mines: 625,
  );
  
  static const cursed = Difficulty(
    name: 'Cursed',
    rows: 64,
    cols: 64,
    mines: 1024,
  );
  
  // List of all preset difficulties
  static const List<Difficulty> presets = [
    beginner,
    intermediate,
    expert,
    master,
    insane,
    nightmare,
    cursed,
  ];
  
  /// Create custom difficulty with validation
  factory Difficulty.custom({
    required int rows,
    required int cols,
    required int mines,
  }) {
    // Validate constraints - support up to 100x100 grids
    final validRows = rows.clamp(5, 100);
    final validCols = cols.clamp(5, 100);
    
    // Max 80% of tiles can be mines, min 1 mine
    final maxMines = (validRows * validCols * 0.8).floor();
    final validMines = mines.clamp(1, maxMines);
    
    return Difficulty(
      name: 'Custom ${validRows}x$validCols',
      rows: validRows,
      cols: validCols,
      mines: validMines,
    );
  }
  
  /// Get mine density percentage
  double get density => (mines / (rows * cols)) * 100;
  
  /// Get total tiles
  int get totalTiles => rows * cols;
  
  /// Check if this is a large grid (requires special handling)
  bool get isLargeGrid => rows > 30 || cols > 30;
  
  /// Check if this is an extreme grid (very large)
  bool get isExtremeGrid => rows > 50 || cols > 50;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Difficulty &&
          runtimeType == other.runtimeType &&
          rows == other.rows &&
          cols == other.cols &&
          mines == other.mines;
  
  @override
  int get hashCode => rows.hashCode ^ cols.hashCode ^ mines.hashCode;
  
  @override
  String toString() => '$name ($rows×$cols, $mines mines)';
}
