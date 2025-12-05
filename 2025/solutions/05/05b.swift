import Foundation

func solvePuzzle(input: [String]) -> Int {
    let splitInput = input.split(separator: "").map { Array($0) }

    var ranges = splitInput[0].map { line -> (start: Int, end: Int) in
        let parts = line.split(separator: "-").map { Int($0)! }
        return (start: parts[0], end: parts[1])
    }
    ranges.sort { $0.start < $1.start }

    var mergedRanges: [(start: Int, end: Int)] = []

    for range in ranges {
        if mergedRanges.isEmpty || mergedRanges.last!.end < range.start - 1 {
            mergedRanges.append(range)
        } else {
            mergedRanges[mergedRanges.count - 1].end = max(
                mergedRanges.last!.end, range.end)
        }
    }

    return mergedRanges.reduce(0) { total, range in
        total + (range.end - range.start + 1)
    }
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 05b")
let testPassing: Bool = 14 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
