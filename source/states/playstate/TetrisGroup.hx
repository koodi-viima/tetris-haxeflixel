package states.playstate;

import flixel.group.FlxGroup;
import flixel.FlxSprite;

typedef SquareInfo = {row: Int, column: Int, value: Int};

class TetrisGroup extends FlxTypedGroup<FlxSprite> {

    public var shape: Shape;
    public var topLeft: Square;
    public var width: Int;
    public var height: Int;

    public var occupiedSquares = new Array<SquareInfo>();

    var blockSize = 32;

    public function new(shape: Shape, ?topLeft: Square): Void {
        super();
        this.shape = shape;
        height = shape.length;
        width = shape[0].length;
        if (topLeft != null) {
            this.topLeft = topLeft;
        } else {
            this.topLeft = {row: 0, column: 0};
        }
    }

    public function merge(tg: TetrisGroup) {
        for (s in tg.occupiedSquares) {
            shape[s.row][s.column] = s.value;
        }
        updateBlocks();
    }

    private function updateBlocks(): Void {
        forEach(function (block) { block.kill(); });
        occupiedSquares = new Array<SquareInfo>();

        for (row in 0...height) {
            for (col in 0...width) {
                var squareValue = shape[row][col];
                if (squareValue != 0) {
                    var block = recycle(FlxSprite);
                    block.x = (topLeft.column + col) * blockSize;
                    block.y = (topLeft.row    + row) * blockSize;
                    block.loadGraphic("assets/blocks/" + squareValue + ".png", false, 32, 32);
                    occupiedSquares.push({
                        row:    row + topLeft.row,
                        column: col + topLeft.column,
                        value:  squareValue
                    });
                }
            }
        }
    }
}