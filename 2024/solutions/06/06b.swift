import Foundation

let testInput: [String] = [
    "....#.....",
    ".........#",
    "..........",
    "..#.......",
    ".......#..",
    "..........",
    ".#..^.....",
    "........#.",
    "#.........",
    "......#...",
]
let testSolution: Int = 6

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

struct Point: Hashable {
    var x: Int
    var y: Int
}

enum Direction {
    case north
    case east
    case south
    case west
}

struct VisitedPoint: Hashable {
    var point: Point
    var direction: Direction
}

func solvePuzzle(input: [String]) -> Int {
    var visitedPoints: Set<VisitedPoint> = Set<VisitedPoint>()
    var startingPosition: Point? = nil
    var currentPosition: Point? = nil
    var facingDirection: Direction = .north
    var hitWall: Bool = false
    var possiblePoints: Int = 0

    let map: [[String]] = input.map { $0.map { return String($0) } }

    outerLoop: for y in 0..<map.count {
        for x in 0..<map[y].count {
            if map[y][x] == "^" {
                startingPosition = Point(x: x, y: y)
                break outerLoop
            }
        }
    }

    if startingPosition == nil {
        fatalError("No starting position found")
    }

    for y in 0..<map.count {
        for x in 0..<map[y].count {
            if map[y][x] == "#" || (startingPosition!.y == y && startingPosition!.x == x) {
                continue
            }

            var tmpMap = map.map { $0.map { return String($0) } }
            tmpMap[y][x] = "#"

            currentPosition = startingPosition
            facingDirection = .north
            visitedPoints = Set<VisitedPoint>()
            hitWall = false
            var turned: Bool = false

            while !hitWall {
                turned = false

                if visitedPoints.contains(
                    VisitedPoint(point: currentPosition!, direction: facingDirection))
                {
                    possiblePoints += 1
                    hitWall = true
                }

                visitedPoints.insert(
                    VisitedPoint(point: currentPosition!, direction: facingDirection))

                switch facingDirection {
                case .north:
                    if currentPosition!.y > 0 {
                        if tmpMap[currentPosition!.y - 1][currentPosition!.x] == "#" {
                            facingDirection = .east
                            turned = true
                        }
                    }
                case .east:
                    if currentPosition!.x < tmpMap[0].count - 1 {
                        if tmpMap[currentPosition!.y][currentPosition!.x + 1] == "#" {
                            facingDirection = .south
                            turned = true
                        }
                    }
                case .south:
                    if currentPosition!.y < tmpMap.count - 1 {
                        if tmpMap[currentPosition!.y + 1][currentPosition!.x] == "#" {
                            facingDirection = .west
                            turned = true
                        }
                    }
                case .west:
                    if currentPosition!.x > 0 {
                        if tmpMap[currentPosition!.y][currentPosition!.x - 1] == "#" {
                            facingDirection = .north
                            turned = true
                        }
                    }
                }

                if !turned {
                    switch facingDirection {
                    case .north:
                        currentPosition!.y -= 1
                    case .east:
                        currentPosition!.x += 1
                    case .south:
                        currentPosition!.y += 1
                    case .west:
                        currentPosition!.x -= 1
                    }
                }

                if currentPosition!.y < 0 || currentPosition!.y > tmpMap.count - 1
                    || currentPosition!.x < 0 || currentPosition!.x > tmpMap[0].count - 1
                {
                    hitWall = true
                }
            }
        }
    }

    return possiblePoints
}

print("AoC Day 06b")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
