package states.playstate;

import flixel.math.FlxRandom;

class TetrominoFactory {

    public static function create(type: TetrominoType, ?colorValue = 1): Tetromino {
        var c = colorValue;

        switch(type) {

            case TetrominoType.O:
                return new Tetromino([
                    [[c, c], [c, c]]], 
                    {row: 0, column: 5});

            case TetrominoType.I:
                return new Tetromino([
                    [[0, 0, 0, 0], [0, 0, 0, 0], [c, c, c, c], [0, 0, 0, 0]],
                    [[0, 0, c, 0], [0, 0, c, 0], [0, 0, c, 0], [0, 0, c, 0]],
                    [[0, 0, 0, 0], [0, 0, 0, 0], [c, c, c, c], [0, 0, 0, 0]],
                    [[0, c, 0, 0], [0, c, 0, 0], [0, c, 0, 0], [0, c, 0, 0]]],
                    {row: -2, column: 3});

            case TetrominoType.J:
                return new Tetromino([
                    [[0, 0, 0], [c, c, c], [0, 0, c]],
                    [[0, c, 0], [0, c, 0], [c, c, 0]],
                    [[c, 0, 0], [c, c, c], [0, 0, 0]],
                    [[0, c, c], [0, c, 0], [0, c, 0]]],
                    {row: -1, column: 4});

            case TetrominoType.L:
                return new Tetromino([
                    [[0, 0, 0], [c, c, c], [c, 0, 0]],
                    [[c, c, 0], [0, c, 0], [0, c, 0]],
                    [[0, 0, c], [c, c, c], [0, 0, 0]],
                    [[0, c, 0], [0, c, 0], [0, c, c]]],
                    {row: -1, column: 4});

            case TetrominoType.S:
                return new Tetromino([
                    [[0, 0, 0], [0, c, c], [c, c, 0]],
                    [[0, c, 0], [0, c, c], [0, 0, c]],
                    [[0, 0, 0], [0, c, c], [c, c, 0]],
                    [[c, 0, 0], [c, c, 0], [0, c, 0]]],
                    {row: -1, column: 4});

            case TetrominoType.Z:
                return new Tetromino([
                    [[0, 0, 0], [c, c, 0], [0, c, c]],
                    [[0, 0, c], [0, c, c], [0, c, 0]],
                    [[0, 0, 0], [c, c, 0], [0, c, c]],
                    [[0, c, 0], [c, c, 0], [c, 0, 0]]],
                    {row: -1, column: 4});
        }
    }

    public static function createRandom(): Tetromino {
        var randomNumber = new FlxRandom().int(1, 6);
        switch (randomNumber) {
            case 1:  return TetrominoFactory.create(TetrominoType.O, 1);
            case 2:  return TetrominoFactory.create(TetrominoType.J, 1);
            case 3:  return TetrominoFactory.create(TetrominoType.L, 1);
            case 4:  return TetrominoFactory.create(TetrominoType.S, 1);
            case 5:  return TetrominoFactory.create(TetrominoType.Z, 1);
            case 6:  return TetrominoFactory.create(TetrominoType.I, 1);
            default: return null;
        }
    }
}