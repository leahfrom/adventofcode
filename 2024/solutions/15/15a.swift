import Foundation

let testInput: [String] = [
    "##########",
    "#..O..O.O#",
    "#......O.#",
    "#.OO..O.O#",
    "#..O@..O.#",
    "#O#..O...#",
    "#O..O..O.#",
    "#.OO.O.OO#",
    "#....O...#",
    "##########",
    "",
    "<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^",
    "vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v",
    "><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<",
    "<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^",
    "^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><",
    "^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^",
    ">^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^",
    "<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>",
    "^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>",
    "v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^",
]
let testSolution: Int = 10092

enum Direction {
    case up
    case down
    case left
    case right
}

struct Point: Hashable {
    var x: Int
    var y: Int
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var moves: [Direction] = []

    let splitInput = input.split(separator: "").map { Array($0) }

    var map = splitInput[0].map { $0.map { String($0) } }

    for line in splitInput[1] {
        for char in line {
            switch char {
            case "^":
                moves.append(.up)
            case "v":
                moves.append(.down)
            case "<":
                moves.append(.left)
            case ">":
                moves.append(.right)
            default:
                break
            }
        }
    }

    var robotPosition: Point!
    var boxPositions: Set<Point> = Set<Point>()

    for y in 0..<map.count {
        for x in 0..<map[y].count {
            if map[y][x] == "@" {
                robotPosition = Point(x: x, y: y)
                map[y][x] = "."
            } else if map[y][x] == "O" {
                boxPositions.insert(Point(x: x, y: y))
                map[y][x] = "."
            }
        }
    }

    func move(_ pos: Point, _ dir: Direction) -> Point {
        switch dir {
        case .up: return Point(x: pos.x, y: pos.y - 1)
        case .down: return Point(x: pos.x, y: pos.y + 1)
        case .left: return Point(x: pos.x - 1, y: pos.y)
        case .right: return Point(x: pos.x + 1, y: pos.y)
        }
    }

    for moveDirection in moves {
        var nextPos = move(robotPosition, moveDirection)
        var boxesToMove: [Point] = []

        while boxPositions.contains(nextPos) {
            boxesToMove.append(nextPos)
            nextPos = move(nextPos, moveDirection)
        }

        if map[nextPos.y][nextPos.x] == "#" || boxPositions.contains(nextPos) {
            continue
        }

        for box in boxesToMove.reversed() {
            boxPositions.remove(box)
            let newBoxPos = move(box, moveDirection)
            boxPositions.insert(newBoxPos)
        }

        robotPosition = move(robotPosition, moveDirection)
    }

    let output = boxPositions.reduce(0) { $0 + (100 * $1.y + $1.x) }
    return output
}

print("AoC Day 15a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
