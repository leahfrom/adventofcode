import Foundation

let testInput: [String] = [
    "###############",
    "#...#...#.....#",
    "#.#.#.#.#.###.#",
    "#S#...#.#.#...#",
    "#######.#.#.###",
    "#######.#.#...#",
    "#######.#.###.#",
    "###..E#...#...#",
    "###.#######.###",
    "#...###...#...#",
    "#.#####.#.###.#",
    "#.#...#.#.#...#",
    "#.#.#.#.#.#.###",
    "#...#...#...###",
    "###############",
]
let testSolution: Int = 1

struct Point: Hashable {
    var x: Int
    var y: Int

    func move(_ direction: Direction) -> Point {
        switch direction {
        case .up: return Point(x: x, y: y - 1)
        case .down: return Point(x: x, y: y + 1)
        case .left: return Point(x: x - 1, y: y)
        case .right: return Point(x: x + 1, y: y)
        }
    }
}

enum Direction {
    case up
    case down
    case left
    case right
}

struct Player: Hashable {
    var position: Point
    var steps: Int
    var lastDirection: Direction?
    var cheatedPoints: [Point]
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String], saves: Int) -> Int {
    var map = input.map { $0.map { String($0) } }
    var startPoint: Point = Point(x: 0, y: 0)
    var endPoint: Point = Point(x: 0, y: 0)

    for y in 0..<map.count {
        for x in 0..<map[y].count {
            if map[y][x] == "S" {
                startPoint = Point(x: x, y: y)
                map[y][x] = "."
            }
            if map[y][x] == "E" {
                endPoint = Point(x: x, y: y)
                map[y][x] = "."
            }
        }
    }

    func isValidMove(point: Point) -> Bool {
        return point.y >= 0 && point.y < map.count && point.x >= 0 && point.x < map[0].count
            && map[point.y][point.x] != "#"
    }

    func getNextDirection(_ direction: Direction?) -> [Direction] {
        switch direction {
        case .up: return [.left, .up, .right]
        case .down: return [.right, .down, .left]
        case .left: return [.down, .left, .up]
        case .right: return [.up, .right, .down]
        default: return [.up, .down, .left, .right]
        }
    }

    func findWays() -> [Player] {
        var queue: [Player] = [Player(position: startPoint, steps: 0, cheatedPoints: [])]

        struct Key: Hashable {
            var point: Point
            var goingTo: Point
            var cheatedPoints: [Point]
        }

        var foundMain: Bool = false
        var mainSteps: Int = 0
        var visited: Set<Key> = []
        var finished: [Player] = []

        while queue.count > 0 {
            if !foundMain {
                queue.sort { $0.cheatedPoints.isEmpty || $0.steps < $1.steps }
            }

            let currentCheck = queue.removeFirst()

            if currentCheck.position == endPoint {
                if currentCheck.cheatedPoints.isEmpty {
                    foundMain = true
                    mainSteps = currentCheck.steps
                }
                finished.append(currentCheck)
                continue
            }

            if foundMain {
                if mainSteps - currentCheck.steps <= saves {
                    continue
                }
            }

            for direction in getNextDirection(currentCheck.lastDirection) {
                let next = currentCheck.position.move(direction)
                let cheatedNext = next.move(direction)

                if isValidMove(point: next) {
                    if !visited.contains(
                        Key(
                            point: currentCheck.position, goingTo: next,
                            cheatedPoints: currentCheck.cheatedPoints))
                    {
                        visited.insert(
                            Key(
                                point: currentCheck.position, goingTo: next,
                                cheatedPoints: currentCheck.cheatedPoints))
                        queue.append(
                            Player(
                                position: next, steps: currentCheck.steps + 1,
                                lastDirection: direction,
                                cheatedPoints: currentCheck.cheatedPoints))
                    }
                } else if currentCheck.cheatedPoints.isEmpty && isValidMove(point: cheatedNext) {
                    if !visited.contains(
                        Key(
                            point: currentCheck.position, goingTo: cheatedNext,
                            cheatedPoints: [next, cheatedNext]))
                    {
                        visited.insert(
                            Key(
                                point: currentCheck.position, goingTo: cheatedNext,
                                cheatedPoints: [next, cheatedNext]))
                        queue.append(
                            Player(
                                position: cheatedNext,
                                steps: currentCheck.steps + 2, lastDirection: direction,
                                cheatedPoints: [next, cheatedNext]
                            ))
                    }
                }
            }
        }

        return finished
    }

    let finished = findWays()
    let longestRun = finished.filter({ $0.cheatedPoints.isEmpty })[0]
    let savings: [Int] = finished.filter({ !$0.cheatedPoints.isEmpty }).map {
        longestRun.steps - $0.steps
    }
    return savings.filter({ $0 >= saves }).count
}

print("AoC Day 20a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput, saves: 60)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput, saves: 100))")
}
