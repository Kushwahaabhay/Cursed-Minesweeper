import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cursed_minesweeper/game/tile.dart';
import 'package:cursed_minesweeper/widgets/tile_widget.dart';

void main() {
  group('TileWidget Display Tests', () {
    testWidgets('Shows number when tile has adjacent mines', (WidgetTester tester) async {
      // Create a tile with 3 adjacent mines
      final tile = Tile(row: 0, col: 0, adjacentMines: 3, isRevealed: true);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TileWidget(
              tile: tile,
              onTap: () {},
              onLongPress: () {},
              size: 40.0,
            ),
          ),
        ),
      );
      
      // Should find the number "3"
      expect(find.text('3'), findsOneWidget);
    });
    
    testWidgets('Shows mine icon when tile is a mine', (WidgetTester tester) async {
      final tile = Tile(row: 0, col: 0, isMine: true, isRevealed: true);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TileWidget(
              tile: tile,
              onTap: () {},
              onLongPress: () {},
              size: 40.0,
              isGameOver: true,
            ),
          ),
        ),
      );
      
      // Should find the close icon (mine)
      expect(find.byIcon(Icons.close), findsOneWidget);
    });
    
    testWidgets('Shows nothing when tile has no adjacent mines', (WidgetTester tester) async {
      final tile = Tile(row: 0, col: 0, adjacentMines: 0, isRevealed: true);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TileWidget(
              tile: tile,
              onTap: () {},
              onLongPress: () {},
              size: 40.0,
            ),
          ),
        ),
      );
      
      // Should not find any text
      expect(find.byType(Text), findsNothing);
    });
    
    testWidgets('Shows flag when tile is flagged', (WidgetTester tester) async {
      final tile = Tile(row: 0, col: 0, isFlagged: true, isRevealed: false);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TileWidget(
              tile: tile,
              onTap: () {},
              onLongPress: () {},
              size: 40.0,
            ),
          ),
        ),
      );
      
      // Should find the flag icon
      expect(find.byIcon(Icons.flag), findsOneWidget);
    });
    
    testWidgets('All numbers 1-8 display correctly', (WidgetTester tester) async {
      for (int i = 1; i <= 8; i++) {
        final tile = Tile(row: 0, col: 0, adjacentMines: i, isRevealed: true);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TileWidget(
                tile: tile,
                onTap: () {},
                onLongPress: () {},
                size: 40.0,
              ),
            ),
          ),
        );
        
        // Should find the number
        expect(find.text(i.toString()), findsOneWidget, 
            reason: 'Number $i should be displayed');
      }
    });
  });
}
