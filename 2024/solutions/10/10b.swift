import Foundation

let testInput: [String] = [
    "89010123",
    "78121874",
    "87430965",
    "96549874",
    "45678903",
    "32019012",
    "01329801",
    "10456732",
]
let testSolution: Int = 81

struct Point: Hashable {
    var x: Int
    var y: Int
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []
    var trailheads: [Point] = []

    let map = input.map { $0.map { Int(String($0)) ?? -1 } }

    for y in 0..<map.count {
        for x in 0..<map[y].count {
            if map[y][x] == 0 {
                trailheads.append(Point(x: x, y: y))
            }
        }
    }

    for startPoint in trailheads {
        var pointsToFollow: [Point] = [startPoint]
        var reachableEnds: [Point] = []

        while pointsToFollow.count > 0 {
            let currentPoint = pointsToFollow.removeFirst()
            let x = currentPoint.x
            let y = currentPoint.y
            let nextValue = map[y][x] + 1

            if map[y][x] == 9 {
                reachableEnds.append(currentPoint)
                continue
            }

            if x > 0 && map[y][x - 1] == nextValue {
                pointsToFollow.append(Point(x: x - 1, y: y))
            }
            if x < map[y].count - 1 && map[y][x + 1] == nextValue {
                pointsToFollow.append(Point(x: x + 1, y: y))
            }
            if y > 0 && map[y - 1][x] == nextValue {
                pointsToFollow.append(Point(x: x, y: y - 1))
            }
            if y < map.count - 1 && map[y + 1][x] == nextValue {
                pointsToFollow.append(Point(x: x, y: y + 1))
            }
        }

        numberStore.append(reachableEnds.count)
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

print("AoC Day 10b")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
