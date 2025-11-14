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
  
  // List of all preset difficulties
  static const List<Difficulty> presets = [
    beginner,
    intermediate,
    expert,
  ];
  
  /// Create custom difficulty with validation
  factory Difficulty.custom({
    required int rows,
    required int cols,
    required int mines,
  }) {
    // Validate constraints
    final maxMines = (rows * cols * 0.8).floor(); // Max 80% of tiles
    final validMines = mines.clamp(1, maxMines);
    
    return Difficulty(
      name: 'Custom ${rows}x$cols',
      rows: rows.clamp(5, 50),
      cols: cols.clamp(5, 50),
      mines: validMines,
    );
  }
  
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
