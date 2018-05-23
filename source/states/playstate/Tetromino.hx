package states.playstate;

typedef Shapes = Array<Array<Array<Int>>>;

class Tetromino extends TetrisGroup {

    var shapes: Shapes;
    var shapeIndex = 0;
    var previousTopLeft: Square;
    var previousShapeIndex = 0;

    public function new(shapes: Shapes, topLeft: Square): Void {
        super(shapes[0], topLeft);
        this.shapes = shapes;
        previousTopLeft = {row: topLeft.row, column: topLeft.column};
        updateBlocks();
    }

    public function move(dRow: Int, dCol: Int): Void {
        previousTopLeft.row = topLeft.row;
        previousTopLeft.column = topLeft.column;
        topLeft.row += dRow;
        topLeft.column += dCol;
        updateBlocks();
    }

    public function revertPosition(): Void {
        topLeft.row = previousTopLeft.row;
        topLeft.column = previousTopLeft.column;
        updateBlocks();
    }

    public function rotateRight(): Void {
        rotate(1);
    }

    public function rotateLeft(): Void {
        rotate(-1);
    }

    public function revertRotation(): Void {
        shapeIndex = previousShapeIndex;
        shape = shapes[shapeIndex];
        updateBlocks();
    }

    private function rotate(direction: Int): Void {
        previousShapeIndex = shapeIndex;
        if (direction == 1 && shapeIndex + 1 >= shapes.length) {
            shapeIndex = 0;
        }
        else if (direction == -1 && shapeIndex - 1 < 0) {
            shapeIndex = shapes.length - 1;
        } else {
            shapeIndex += direction;
        }
        shape = shapes[shapeIndex];
        updateBlocks();
    }
}
