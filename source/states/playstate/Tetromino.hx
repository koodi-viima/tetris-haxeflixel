package states.playstate;

typedef Shapes = Array<Array<Array<Int>>>;

class Tetromino extends TetrisGroup {

    public var previousTopLeft: Array<Int>; // TODO: why public?

    var shapes: Shapes;
    var shapeIndex = 0;
    var previousShapeIndex = 0;

    public function new(shapes: Shapes, topLeftRow: Int, topLeftCol: Int): Void {
        super(shapes[0], topLeftRow, topLeftCol);
        this.shapes = shapes;
        previousTopLeft = [topLeftRow, topLeftCol];
        updateBlocks();
    }

    public function move(dRow: Int, dCol: Int): Void {
        previousTopLeft[0] = topLeft[0];
        previousTopLeft[1] = topLeft[1];
        topLeft[0] += dRow;
        topLeft[1] += dCol;
        updateBlocks();
    }

    public function revertPosition(): Void {
        topLeft[0] = previousTopLeft[0];
        topLeft[1] = previousTopLeft[1];
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
