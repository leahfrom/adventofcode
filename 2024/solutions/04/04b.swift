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
let testSolution: Int = 9

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []

    let map: [[String]] = input.map { $0.map { return String($0) } }

    for y in 0..<map.count {
        for x in 0..<map[y].count {
            if x < map[y].count - 2 && y < map.count - 2 {
                // TL & TR
                if map[y][x] + map[y + 1][x + 1] + map[y + 2][x + 2] == "MAS"
                    && map[y][x + 2] + map[y + 1][x + 1] + map[y + 2][x] == "MAS"
                {
                    numberStore.append(1)
                }

                // TR & BR
                if map[y][x + 2] + map[y + 1][x + 1] + map[y + 2][x] == "MAS"
                    && map[y + 2][x + 2] + map[y + 1][x + 1] + map[y][x] == "MAS"
                {
                    numberStore.append(1)
                }

                // BR & BL
                if map[y + 2][x + 2] + map[y + 1][x + 1] + map[y][x] == "MAS"
                    && map[y + 2][x] + map[y + 1][x + 1] + map[y][x + 2] == "MAS"
                {
                    numberStore.append(1)
                }

                // BL & TL
                if map[y + 2][x] + map[y + 1][x + 1] + map[y][x + 2] == "MAS"
                    && map[y][x] + map[y + 1][x + 1] + map[y + 2][x + 2] == "MAS"
                {
                    numberStore.append(1)
                }
            }
        }
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

print("AoC Day 04b")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
