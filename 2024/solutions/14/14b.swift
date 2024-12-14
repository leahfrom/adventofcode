import Foundation

struct Point: Hashable {
    var x: Int
    var y: Int
}

struct Direction {
    var x: Int
    var y: Int
}

struct Robot {
    var position: Point
    var velocity: Direction
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String], height: Int, width: Int) -> Int {
    var robots: [Robot] = []

    for line in input {
        let parts = line.components(separatedBy: " ")
        let position = parts[0].components(separatedBy: "=")[1].components(separatedBy: ",")
        let velocity = parts[1].components(separatedBy: "=")[1].components(separatedBy: ",")

        robots.append(
            Robot(
                position: Point(x: Int(position[0])!, y: Int(position[1])!),
                velocity: Direction(x: Int(velocity[0])!, y: Int(velocity[1])!)))
    }

    var seconds: Int = 0
    var isTreeFound: Bool = false
    while !isTreeFound {
        seconds += 1

        for i in 0..<robots.count {
            robots[i].position.x = (robots[i].position.x + robots[i].velocity.x + width) % width
            robots[i].position.y = (robots[i].position.y + robots[i].velocity.y + height) % height
        }

        var grid = Array(repeating: Array(repeating: false, count: width), count: height)
        for robot in robots {
            grid[robot.position.y][robot.position.x] = true
        }

        outerLoop: for y in 1..<height - 2 {
            for x in 1..<width - 2 {
                if grid[y][x] && grid[y + 1][x] && grid[y + 1][x - 1]
                    && grid[y + 1][x + 1] && grid[y + 2][x] && grid[y + 2][x - 1]
                    && grid[y + 2][x + 1] && grid[y + 2][x - 2] && grid[y + 2][x + 2]
                {
                    isTreeFound = true
                    break outerLoop
                }
            }
        }
    }

    return seconds
}

print("AoC Day 14b")
print("Solution: \(solvePuzzle(input: puzzleInput, height: 103, width: 101))")
