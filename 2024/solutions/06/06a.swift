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
let testSolution: Int = 41

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

func solvePuzzle(input: [String]) -> Int {
    var visitedPoints: Set<Point> = Set<Point>()
    var currentPosition: Point? = nil
    var facingDirection: Direction = .north
    var hitWall: Bool = false
    var turned: Bool = false

    let map: [[String]] = input.map { $0.map { return String($0) } }

    outerLoop: for y in 0..<map.count {
        for x in 0..<map[y].count {
            if map[y][x] == "^" {
                currentPosition = Point(x: x, y: y)
                break outerLoop
            }
        }
    }

    if currentPosition == nil {
        fatalError("No starting position found")
    }

    while !hitWall {
        turned = false
        visitedPoints.insert(currentPosition!)

        switch facingDirection {
        case .north:
            if currentPosition!.y > 0 {
                if map[currentPosition!.y - 1][currentPosition!.x] == "#" {
                    facingDirection = .east
                    turned = true
                }
            }
        case .east:
            if currentPosition!.x < map[0].count - 1 {
                if map[currentPosition!.y][currentPosition!.x + 1] == "#" {
                    facingDirection = .south
                    turned = true
                }
            }
        case .south:
            if currentPosition!.y < map.count - 1 {
                if map[currentPosition!.y + 1][currentPosition!.x] == "#" {
                    facingDirection = .west
                    turned = true
                }
            }
        case .west:
            if currentPosition!.x > 0 {
                if map[currentPosition!.y][currentPosition!.x - 1] == "#" {
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

        if currentPosition!.y < 0 || currentPosition!.y > map.count - 1
            || currentPosition!.x < 0 || currentPosition!.x > map[0].count - 1
        {
            hitWall = true
        }
    }

    return visitedPoints.count
}

print("AoC Day 06a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
