package states.playstate;

import flixel.group.FlxGroup;
import flixel.FlxSprite;

class TetrisGroup extends FlxTypedGroup<FlxSprite> {

    public var shape: Shape;
    public var topLeft: Array<Int>;
    public var width: Int;
    public var height: Int;

    public var occupiedSquares = new Array<Array<Int>>();

    var blockSize = 32;

    public function new(shape: Shape, ?topLeftRow = 0, ?topLeftCol = 0): Void {
        super();
        this.shape = shape;
        height = shape.length;
        width = shape[0].length;
        topLeft = [topLeftRow, topLeftCol];
    }

    public function merge(tg: TetrisGroup) {
        for (s in tg.occupiedSquares) {
            shape[s[0]][s[1]] = s[2];
        }
        updateBlocks();
    }

    private function updateBlocks(): Void {
        forEach(function (block) { block.kill(); });
        occupiedSquares = new Array<Array<Int>>();

        for (row in 0...height) {
            for (col in 0...width) {
                var squareValue = shape[row][col];
                if (squareValue != 0) {
                    var block = recycle(FlxSprite);
                    block.x = (topLeft[1] + col) * blockSize;
                    block.y = (topLeft[0] + row) * blockSize;
                    block.loadGraphic("assets/blocks/" + squareValue + ".png", false, 32, 32);
                    occupiedSquares.push([row + topLeft[0], col + topLeft[1], squareValue]);
                }
            }
        }
    }
}