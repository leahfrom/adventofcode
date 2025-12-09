import Foundation

struct Point: Hashable {
    var x: Int
    var y: Int
}

struct Tile: Hashable {
    var position: Point
}

func solvePuzzle(input: [String]) -> Int {
    var tiles: [Tile] = []
    for line in input {
        let numbers = line.split(separator: ",").compactMap { Int($0) }
        tiles.append(Tile(position: Point(x: numbers[0], y: numbers[1])))
    }

    var maxArea: Int = 0

    for tile in tiles {
        for otherTile in tiles {
            if tile != otherTile {
                let area =
                    (abs(tile.position.x - otherTile.position.x) + 1)
                    * (abs(tile.position.y - otherTile.position.y) + 1)
                if area > maxArea {
                    maxArea = area
                }
            }
        }
    }

    return maxArea
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 09a")
let testPassing: Bool = 50 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
