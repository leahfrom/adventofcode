import Foundation

struct Point: Hashable {
    var x: Int
    var y: Int
}

struct PaperRoll: Hashable {
    var position: Point
}

func solvePuzzle(input: [String]) -> Int {
    var rollsRemoved: Int = 0

    var map: [[String]] = input.map { $0.map { return String($0) } }

    var removedInThisIteration: Bool = true
    while removedInThisIteration {
        removedInThisIteration = false

        var paperRolls: [PaperRoll] = []
        for y in 0..<map.count {
            for x in 0..<map[y].count {
                if map[y][x] == "@" {
                    paperRolls.append(PaperRoll(position: Point(x: x, y: y)))
                }
            }
        }

        outerLoop: for roll in paperRolls {
            var adjacentCount: Int = 0
            let directions: [Point] = [
                Point(x: -1, y: -1), Point(x: 0, y: -1), Point(x: 1, y: -1),
                Point(x: -1, y: 0), Point(x: 1, y: 0),
                Point(x: -1, y: 1), Point(x: 0, y: 1), Point(x: 1, y: 1),
            ]

            for dir in directions {
                let newX = roll.position.x + dir.x
                let newY = roll.position.y + dir.y
                if newX >= 0 && newX < map[0].count && newY >= 0 && newY < map.count {
                    if map[newY][newX] == "@" {
                        adjacentCount += 1

                        if adjacentCount >= 4 {
                            continue outerLoop
                        }
                    }
                }
            }

            if adjacentCount < 4 {
                rollsRemoved += 1
                map[roll.position.y][roll.position.x] = "."
                removedInThisIteration = true
            }
        }
    }

    return rollsRemoved
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 04b")
let testPassing: Bool = 43 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
