import Foundation

let testInput: [String] = [
    "5,4",
    "4,2",
    "4,5",
    "3,0",
    "2,1",
    "6,3",
    "2,4",
    "1,5",
    "0,6",
    "3,3",
    "2,6",
    "5,1",
    "1,2",
    "5,5",
    "2,5",
    "6,5",
    "1,4",
    "0,4",
    "6,4",
    "1,1",
    "6,1",
    "1,0",
    "0,5",
    "1,6",
    "2,0",
]
let testSolution: String = "6,1"

struct Point: Hashable {
    var x: Int
    var y: Int
}

enum Direction {
    case up
    case down
    case left
    case right
}

struct Player: Hashable, Comparable {
    var position: Point
    var facing: Direction
    var stepsTaken: Int

    static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.stepsTaken < rhs.stepsTaken
    }
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String], gridSize: Int, simulateToByte: Int) -> String {
    var points: [Point] = []
    let endPosition: Point = Point(x: gridSize - 1, y: gridSize - 1)
    var stepsToCheck: [Player] = [
        Player(position: Point(x: 0, y: 0), facing: .right, stepsTaken: 0)
    ]
    var alreadyChecked: Set<Player> = Set<Player>()

    for line in input {
        points.append(
            Point(x: Int(line.split(separator: ",")[0])!, y: Int(line.split(separator: ",")[1])!))
    }

    var map: [[String]] = []
    for _ in 0..<gridSize {
        map.append(Array(repeating: ".", count: gridSize))
    }

    for i in 0..<simulateToByte {
        map[points[i].y][points[i].x] = "#"
    }

    func isMoveValid(_ position: Point, _ direction: Direction) -> Bool {
        switch direction {
        case .up: return position.y > 0 && map[position.y - 1][position.x] != "#"
        case .down: return position.y < map.count - 1 && map[position.y + 1][position.x] != "#"
        case .left: return position.x > 0 && map[position.y][position.x - 1] != "#"
        case .right: return position.x < map[0].count - 1 && map[position.y][position.x + 1] != "#"
        }
    }

    func move(_ position: Point, _ direction: Direction) -> Point {
        switch direction {
        case .up: return Point(x: position.x, y: position.y - 1)
        case .down: return Point(x: position.x, y: position.y + 1)
        case .left: return Point(x: position.x - 1, y: position.y)
        case .right: return Point(x: position.x + 1, y: position.y)
        }
    }

    func getNextFacingDirections(_ direction: Direction) -> [Direction] {
        switch direction {
        case .up: return [.left, .right]
        case .down: return [.left, .right]
        case .left: return [.up, .down]
        case .right: return [.up, .down]
        }
    }

    var lastPointAdded: Point = Point(x: 0, y: 0)
    var byteCounter: Int = simulateToByte - 1
    var pathStillValid: Bool = true

    while pathStillValid {
        pathStillValid = false
        stepsToCheck = [Player(position: Point(x: 0, y: 0), facing: .right, stepsTaken: 0)]
        alreadyChecked = []

        while stepsToCheck.count > 0 {
            let currentCheck = stepsToCheck.removeLast()

            if currentCheck.position == endPosition {
                byteCounter += 1
                lastPointAdded = Point(x: points[byteCounter].x, y: points[byteCounter].y)
                map[lastPointAdded.y][lastPointAdded.x] = "#"
                pathStillValid = true
                stepsToCheck = []
            }

            if alreadyChecked.contains(
                Player(position: currentCheck.position, facing: currentCheck.facing, stepsTaken: 0))
            {
                continue
            }

            alreadyChecked.insert(
                Player(position: currentCheck.position, facing: currentCheck.facing, stepsTaken: 0))

            if isMoveValid(currentCheck.position, currentCheck.facing) {
                stepsToCheck.append(
                    Player(
                        position: move(currentCheck.position, currentCheck.facing),
                        facing: currentCheck.facing,
                        stepsTaken: currentCheck.stepsTaken + 1))
            }

            for nextFacing in getNextFacingDirections(currentCheck.facing) {
                if isMoveValid(currentCheck.position, nextFacing) {
                    stepsToCheck.append(
                        Player(
                            position: currentCheck.position, facing: nextFacing,
                            stepsTaken: currentCheck.stepsTaken)
                    )
                }
            }
        }
    }

    return "\(lastPointAdded.x),\(lastPointAdded.y)"
}

print("AoC Day 18b")
let testPassing: Bool =
    testSolution == solvePuzzle(input: testInput, gridSize: 7, simulateToByte: 12)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput, gridSize: 71, simulateToByte: 1024))")
}
