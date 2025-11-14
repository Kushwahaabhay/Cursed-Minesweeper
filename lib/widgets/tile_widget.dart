import 'package:flutter/material.dart';
import '../game/tile.dart';

/// Widget for displaying a single Minesweeper tile
/// Shows different states: hidden, revealed, flagged, mine
class TileWidget extends StatefulWidget {
  final Tile tile;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final double size;
  final bool isGameOver;
  
  const TileWidget({
    super.key,
    required this.tile,
    required this.onTap,
    required this.onLongPress,
    required this.size,
    this.isGameOver = false,
  });
  
  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }
  
  @override
  void didUpdateWidget(TileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger animation when tile is revealed
    if (!oldWidget.tile.isRevealed && widget.tile.isRevealed) {
      _controller.forward(from: 0.0);
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  /// Get color for number based on adjacent mine count (classic Minesweeper colors)
  Color _getNumberColor(int adjacentMines) {
    switch (adjacentMines) {
      case 1:
        return const Color(0xFF0000FF); // Blue
      case 2:
        return const Color(0xFF008000); // Green
      case 3:
        return const Color(0xFFFF0000); // Red
      case 4:
        return const Color(0xFF000080); // Dark Blue
      case 5:
        return const Color(0xFF800000); // Maroon
      case 6:
        return const Color(0xFF008080); // Cyan
      case 7:
        return const Color(0xFF000000); // Black
      case 8:
        return const Color(0xFF808080); // Gray
      default:
        return Colors.white;
    }
  }
  
  /// Build revealed tile content
  Widget _buildRevealedContent() {
    if (widget.tile.isMine) {
      // Show mine icon
      return const Icon(
        Icons.close, // X for mine
        color: Color(0xFFFF0000),
        size: 20,
      );
    } else if (widget.tile.adjacentMines > 0) {
      // Show number
      return Text(
        widget.tile.adjacentMines.toString(),
        style: TextStyle(
          color: _getNumberColor(widget.tile.adjacentMines),
          fontSize: widget.size * 0.4,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    // Empty tile (no adjacent mines)
    return const SizedBox.shrink();
  }
  
  /// Build unrevealed tile content
  Widget _buildUnrevealedContent() {
    if (widget.tile.isFlagged) {
      return Icon(
        Icons.flag,
        color: const Color(0xFFFF00FF), // Magenta flag
        size: widget.size * 0.5,
      );
    }
    return const SizedBox.shrink();
  }
  
  @override
  Widget build(BuildContext context) {
    final isRevealed = widget.tile.isRevealed;
    
    Widget content = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: isRevealed 
            ? (widget.tile.isMine && widget.isGameOver
                ? const Color(0xFF330000) // Dark red for mine
                : const Color(0xFF1a1a1a)) // Dark gray for revealed
            : const Color(0xFF2a2a2a), // Lighter gray for unrevealed
        border: Border.all(
          color: const Color(0xFF00FF00),
          width: 1,
        ),
        boxShadow: isRevealed
            ? null
            : [
                const BoxShadow(
                  color: Color(0xFF00FF00),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ],
      ),
      child: Center(
        child: isRevealed ? _buildRevealedContent() : _buildUnrevealedContent(),
      ),
    );
    
    // Add reveal animation
    if (isRevealed) {
      content = ScaleTransition(
        scale: _scaleAnimation,
        child: content,
      );
    }
    
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: content,
    );
  }
}
