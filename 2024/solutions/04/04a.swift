import Foundation

let testInput: [String] = [
    "MMMSXXMASM",
    "MSAMXMSMSA",
    "AMXSXMAAMM",
    "MSAMASMSMX",
    "XMASAMXAMM",
    "XXAMMXXAMA",
    "SMSMSASXSS",
    "SAXAMASAAA",
    "MAMMMXMMMM",
]
let testSolution: Int = 10  // 18? Maybe bug?

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []

    let map: [[String]] = input.map { $0.map { return String($0) } }

    for y in 0..<map.count {
        for x in 0..<map[y].count {
            if x < map[y].count - 3 {
                // Vertical
                if map[y][x...x + 3].joined(separator: "") == "XMAS"
                    || map[y][x...x + 3].joined(separator: "") == "SAMX"
                {
                    numberStore.append(1)
                }
            }
            if y < map.count - 3 {
                // Horizontal
                if map[y][x] + map[y + 1][x] + map[y + 2][x] + map[y + 3][x] == "XMAS"
                    || map[y][x] + map[y + 1][x] + map[y + 2][x] + map[y + 3][x] == "SAMX"
                {
                    numberStore.append(1)
                }
            }
            if x < map[y].count - 3 && y < map.count - 3 {
                // TL to BR and back
                if map[y][x] + map[y + 1][x + 1] + map[y + 2][x + 2] + map[y + 3][x + 3] == "XMAS"
                    || map[y][x] + map[y + 1][x + 1] + map[y + 2][x + 2] + map[y + 3][x + 3]
                        == "SAMX"
                {
                    numberStore.append(1)
                }
                // BL to TR and back
                if map[y + 3][x] + map[y + 2][x + 1] + map[y + 1][x + 2] + map[y][x + 3] == "XMAS"
                    || map[y + 3][x] + map[y + 2][x + 1] + map[y + 1][x + 2] + map[y][x + 3]
                        == "SAMX"
                {
                    numberStore.append(1)
                }
            }
        }
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

print("AoC Day 04a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
