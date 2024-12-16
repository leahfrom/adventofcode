import Foundation

let testInput: [String] = [
    "###############",
    "#.......#....E#",
    "#.#.###.#.###.#",
    "#.....#.#...#.#",
    "#.###.#####.#.#",
    "#.#.#.......#.#",
    "#.#.#####.###.#",
    "#...........#.#",
    "###.#.#####.#.#",
    "#...#.....#.#.#",
    "#.#.#.###.#.#.#",
    "#.....#...#.#.#",
    "#.###.#.#.#.#.#",
    "#S..#.....#...#",
    "###############",
]
let testSolution: Int = 7036
let testTwoInput: [String] = [
    "#################",
    "#...#...#...#..E#",
    "#.#.#.#.#.#.#.#.#",
    "#.#.#.#...#...#.#",
    "#.#.#.#.###.#.#.#",
    "#...#.#.#.....#.#",
    "#.#.#.#.#.#####.#",
    "#.#...#.#.#.....#",
    "#.#.#####.#.###.#",
    "#.#.#.......#...#",
    "#.#.###.#####.###",
    "#.#.#...#.....#.#",
    "#.#.#.#####.###.#",
    "#.#.#.........#.#",
    "#.#.#.#########.#",
    "#S#.............#",
    "#################",
]
let testTwoSolution: Int = 11048

struct Point: Hashable {
    let x: Int
    let y: Int
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
    var score: Int

    static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.score < rhs.score
    }
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var score: Int = 0

    var map = input.map { $0.map { String($0) } }
    var endPosition: Point = Point(x: 0, y: 0)
    var stepsToCheck: [Player] = []
    var alreadyChecked: Set<Player> = Set<Player>()

    for y in 0..<map.count {
        for x in 0..<map[y].count {
            if map[y][x] == "S" {
                stepsToCheck.append(Player(position: Point(x: x, y: y), facing: .right, score: 0))
                map[y][x] = "."
            }
            if map[y][x] == "E" {
                endPosition = Point(x: x, y: y)
                map[y][x] = "."
            }
        }
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

    while stepsToCheck.count > 0 {
        stepsToCheck.sort()
        let currentCheck = stepsToCheck.removeFirst()

        if currentCheck.position == endPosition {
            score = currentCheck.score
            break
        }

        if alreadyChecked.contains(
            Player(position: currentCheck.position, facing: currentCheck.facing, score: 0))
        {
            continue
        }

        alreadyChecked.insert(
            Player(position: currentCheck.position, facing: currentCheck.facing, score: 0))

        if isMoveValid(currentCheck.position, currentCheck.facing) {
            stepsToCheck.append(
                Player(
                    position: move(currentCheck.position, currentCheck.facing),
                    facing: currentCheck.facing,
                    score: currentCheck.score + 1))
        }

        for nextFacing in getNextFacingDirections(currentCheck.facing) {
            if isMoveValid(currentCheck.position, nextFacing) {
                stepsToCheck.append(
                    Player(
                        position: currentCheck.position, facing: nextFacing,
                        score: currentCheck.score + 1000)
                )
            }
        }
    }

    return score
}

print("AoC Day 16a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
let testTwoPassing: Bool = testTwoSolution == solvePuzzle(input: testTwoInput)
print("Test two passing? \(testTwoPassing)")
if testPassing && testTwoPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
