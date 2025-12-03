import 'package:flutter/foundation.dart';
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
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    
    // If tile is already revealed on init, set animation to complete
    if (widget.tile.isRevealed) {
      _controller.value = 1.0;
    }
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
  
  /// Get color for number based on adjacent mine count (enhanced for dark theme)
  Color _getNumberColor(int adjacentMines) {
    switch (adjacentMines) {
      case 1:
        return const Color(0xFF00BFFF); // Bright Blue
      case 2:
        return const Color(0xFF00FF00); // Bright Green
      case 3:
        return const Color(0xFFFF0000); // Red
      case 4:
        return const Color(0xFF9370DB); // Medium Purple
      case 5:
        return const Color(0xFFFF6347); // Tomato Red
      case 6:
        return const Color(0xFF00CED1); // Dark Turquoise
      case 7:
        return const Color(0xFFFFFFFF); // White
      case 8:
        return const Color(0xFFFF1493); // Deep Pink
      default:
        return const Color(0xFF00FF00); // Green
    }
  }
  
  /// Build revealed tile content
  Widget _buildRevealedContent() {
    if (widget.tile.isMine) {
      // Show mine icon - scale based on tile size
      final iconSize = (widget.size * 0.6).clamp(8.0, 24.0);
      return Icon(
        Icons.close, // X for mine
        color: const Color(0xFFFF0000),
        size: iconSize,
      );
    } else if (widget.tile.adjacentMines > 0) {
      // Show number of adjacent mines - scale font based on tile size
      // Ensure minimum readable size
      final fontSize = (widget.size * 0.5).clamp(14.0, 28.0);
      
      return Text(
        widget.tile.adjacentMines.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _getNumberColor(widget.tile.adjacentMines),
          fontSize: fontSize,
          fontWeight: FontWeight.w900, // Extra bold
          height: 1.2,
          letterSpacing: 0,
          shadows: [
            // Add shadow for better visibility
            Shadow(
              color: Colors.black.withOpacity(0.8),
              offset: const Offset(1, 1),
              blurRadius: 3,
            ),
          ],
        ),
      );
    }
    // Empty tile (no adjacent mines) - show nothing
    return const SizedBox.shrink();
  }
  
  /// Build unrevealed tile content
  Widget _buildUnrevealedContent() {
    if (widget.tile.isFlagged) {
      final flagSize = (widget.size * 0.5).clamp(8.0, 20.0);
      return Icon(
        Icons.flag,
        color: const Color(0xFFFF00FF), // Magenta flag
        size: flagSize,
      );
    }
    return const SizedBox.shrink();
  }
  
  @override
  Widget build(BuildContext context) {
    final isRevealed = widget.tile.isRevealed;
    
    // Build the tile content
    Widget tileContent = Container(
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
    
    // Wrap with animation only if just revealed
    Widget animatedContent = isRevealed
        ? AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: tileContent,
          )
        : tileContent;
    
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: animatedContent,
    );
  }
}
