import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

class MineSweeperGame {
  static int row = 6;
  static int column = 6;
  static int cells = row * column;

  bool gameOver = false;

  List<Cell> gameMap = [];

  static List<List<dynamic>> map = List.generate(
    row,
    (x) => List.generate(
      column,
      (y) => Cell(
        x,
        y,
        '',
        false,
      ),
    ),
  );

  void generateMap() {
    placeMines(10);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < column; j++) {
        gameMap.add(map[i][j]);
      }
    }
  }

  void resetGame() {
    map = List.generate(
      row,
      (x) => List.generate(
        column,
        (y) => Cell(
          x,
          y,
          '',
          false,
        ),
      ),
    );
    gameMap.clear();
    generateMap();
  }

  static void placeMines(int minesNumber) {
    Random random = Random();
    for (int i = 0; i < minesNumber; i++) {
      int minesRow = random.nextInt(row);
      int minesColumn = random.nextInt(column);
      map[minesRow][minesColumn] = Cell(
        minesRow,
        minesColumn,
        'X',
        false,
      );
    }
  }

  void showMines() {
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < column; j++) {
        if (map[i][j].content == 'X') {
          map[i][j].reveal = true;
        }
      }
    }
  }

  void getClickedCell(Cell cell) {
    if (cell.content == 'X') {
      showMines();
      gameOver = true;
    } else {
      int mineCount = 0;
      int cellRow = cell.row;
      int cellColumn = cell.column;

      for (int i = max(cellRow - 1, 0); i <= min(cellRow + 1, row - 1); i++) {
        for (var j = max(cellColumn - 1, 0);
            j <= min(cellColumn + 1, column - 1);
            j++) {
          if (map[i][j].content == 'X') {
            mineCount++;
          }
        }
      }

      cell.content = mineCount;
      cell.reveal = true;
      if (mineCount == 0) {
        for (int i = max(cellRow - 1, 0); i <= min(cellRow + 1, row - 1); i++) {
          for (var j = max(cellColumn - 1, 0);
              j <= min(cellColumn + 1, column - 1);
              j++) {
            if (map[i][j].content == '') {
              getClickedCell(map[i][j]);
            }
          }
        }
      }
    }
  }
}

class Cell {
  int row;
  int column;
  dynamic content;
  bool reveal = false;

  Cell(
    this.row,
    this.column,
    this.content,
    this.reveal,
  );
}
