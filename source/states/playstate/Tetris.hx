package states.playstate;

import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;

import states.playstate.Field;
import states.playstate.Tetromino;
import states.playstate.TetrominoFactory;

class Tetris extends FlxGroup {

    public var isGameOver = false;

    var field: Field;
    var currentLevel: Int;

    var tetromino: Tetromino;
    var nextTetromino: Tetromino;

    var timer: Float = 0.0;
    var fallTime: Float = 0.8;
    var basicFallTime = 0.8;
    var fastFallTime = 0.05;

    public function new(width: Int, height: Int) {
        super();

        currentLevel = 0;

        field = new Field(10, 20);
        add(field);

        tetromino = TetrominoFactory.createRandom();
        nextTetromino = TetrominoFactory.createRandom();
        add(tetromino);
    }

    override public function update(elapsed: Float): Void {
        super.update(elapsed);
        timer += elapsed;
        fallTime = basicFallTime;

        Util.checkQuitKey();
        updateInputs();

        if (!isGameOver) {
            updateTetromino(elapsed);
        }
    }

    private function updateKeyboardInput(): Void {
        if (FlxG.keys.justPressed.LEFT) {
            tetromino.move(0, -1);
            if (!isLegalState()) {
                tetromino.revertPosition();
            }
        }
        if (FlxG.keys.justPressed.RIGHT) {
            tetromino.move(0, 1);
            if (!isLegalState()) {
                tetromino.revertPosition();
            }
        }
        if (FlxG.keys.pressed.DOWN) {
            fallTime = fastFallTime;
        }
        if (FlxG.keys.justPressed.CONTROL) {
            tetromino.rotateLeft();
            if (!isLegalState()) {
                tetromino.revertRotation();
            };
        }
        if (FlxG.keys.justPressed.ALT) {
            tetromino.rotateRight();
            if (!isLegalState()) {
                tetromino.revertRotation();
            }
        }
        if (FlxG.keys.justPressed.SPACE ) {
            if (isGameOver) {
                FlxG.switchState(new GameOverState());
            }
        }
    }

    private function updateGamepadInput(gamepad: FlxGamepad): Void {
        if (gamepad.justPressed.DPAD_LEFT) {
            tetromino.move(0, -1);
            if (!isLegalState()) {
                tetromino.revertPosition();
            }
        }
        if (gamepad.justPressed.DPAD_RIGHT) {
            tetromino.move(0, 1);
            if (!isLegalState()) {
                tetromino.revertPosition();
            }
        }
        if (gamepad.pressed.DPAD_DOWN) {
            fallTime = fastFallTime;
        }
        if (gamepad.justPressed.A) {
            tetromino.rotateLeft();
            if (!isLegalState()) {
                tetromino.revertRotation();
            }
        }
        if (gamepad.justPressed.B) {
            tetromino.rotateRight();
            if (!isLegalState()) {
                tetromino.revertRotation();
            }
        }
    }

    private function updateInputs(): Void {
        #if (!mobile)
        updateKeyboardInput();
        var gamepad: FlxGamepad = FlxG.gamepads.lastActive;
        if (gamepad != null) {
            updateGamepadInput(gamepad);
        }
        #end
    }

    private function updateTetromino(elapsed: Float) {
        if (timer >= fallTime) {
            tetromino.move(1, 0);

            if (!isLegalState()) {
                tetromino.revertPosition();
                field.merge(tetromino);
                tetromino.kill();
                tetromino = nextTetromino;

                if (isLegalState()) {
                    nextTetromino = TetrominoFactory.createRandom();
                    add(tetromino);
                } else {
                    isGameOver = true;
                }
                trace(field.shape);
            }
            timer = 0.0;
        }
    }

    private function isLegalState(): Bool {
        for (squareInfo in tetromino.occupiedSquares) {
            var row = squareInfo.row;
            var col = squareInfo.column;

            if (row < 0 ||
                row >= field.height ||
                col < 0 ||
                col >= field.width ||
                field.shape[row][col] != 0) {

                return false;
            }
        }
        return true;
    }
}
