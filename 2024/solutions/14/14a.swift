import Foundation

let testInput: [String] = [
    "p=0,4 v=3,-3",
    "p=6,3 v=-1,-3",
    "p=10,3 v=-1,2",
    "p=2,0 v=2,-1",
    "p=0,0 v=1,3",
    "p=3,0 v=-2,-2",
    "p=7,6 v=-1,-3",
    "p=3,0 v=-1,-2",
    "p=9,3 v=2,3",
    "p=7,3 v=-1,2",
    "p=2,4 v=2,-3",
    "p=9,5 v=-3,-3",
]
let testSolution: Int = 12

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

    for _ in 0..<100 {
        for i in 0..<robots.count {
            robots[i].position.x = (robots[i].position.x + robots[i].velocity.x + width) % width
            robots[i].position.y = (robots[i].position.y + robots[i].velocity.y + height) % height
        }
    }

    let midX = width / 2
    let midY = height / 2
    var quadrantCounts = [0, 0, 0, 0]

    for robot in robots {
        if robot.position.x == midX || robot.position.y == midY {
            continue
        }

        if robot.position.x < midX {
            if robot.position.y < midY {
                quadrantCounts[0] += 1
            } else {
                quadrantCounts[2] += 1
            }
        } else {
            if robot.position.y < midY {
                quadrantCounts[1] += 1
            } else {
                quadrantCounts[3] += 1
            }
        }
    }

    let safetyFactor = quadrantCounts.reduce(1, *)
    return safetyFactor
}

print("AoC Day 14a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput, height: 7, width: 11)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput, height: 103, width: 101))")
}
