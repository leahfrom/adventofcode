import Foundation

func solvePuzzle(input: [String]) -> Int {
    var solution: Int = 0

    let splitInput = input.split(separator: "").map { Array($0) }

    let ranges = splitInput[0].map { line -> ClosedRange<Int> in
        let parts = line.split(separator: "-").map { Int($0)! }
        return parts[0]...parts[1]
    }

    for ingredient in splitInput[1] {
        for range in ranges {
            if range.contains(Int(ingredient)!) {
                solution += 1
                break
            }
        }
    }

    return solution
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 05a")
let testPassing: Bool = 3 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
