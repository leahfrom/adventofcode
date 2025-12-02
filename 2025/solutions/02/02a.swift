import Foundation

func solvePuzzle(input: [String]) -> Int {
    var solution: Int = 0

    let ranges: [[Int]] = input[0].components(separatedBy: ",").map { range in
        range.components(separatedBy: "-").map { Int($0)! }
    }

    for range in ranges {
        let start: Int = range[0]
        let end: Int = range[1]

        for id in start...end {
            let idString: String = String(id)
            let length: Int = idString.count

            if length % 2 == 0 {
                let midIndex: String.Index = idString.index(
                    idString.startIndex, offsetBy: length / 2)
                let firstHalf: String = String(idString[idString.startIndex..<midIndex])
                let secondHalf: String = String(idString[midIndex..<idString.endIndex])
                if firstHalf == secondHalf {
                    solution += id
                }
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

print("AoC Day 02a")
let testPassing: Bool = 1_227_775_554 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
