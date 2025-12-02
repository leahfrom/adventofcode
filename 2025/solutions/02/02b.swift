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

            if length < 2 {
                continue
            }

            for subLength in 1...(length / 2) {
                if length % subLength == 0 {
                    let repeatCount: Int = length / subLength
                    let subIndex: String.Index = idString.index(
                        idString.startIndex, offsetBy: subLength)
                    let subString: String = String(idString[idString.startIndex..<subIndex])
                    let constructedString: String = String(repeating: subString, count: repeatCount)
                    if constructedString == idString {
                        solution += id
                        break
                    }
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

print("AoC Day 02b")
let testPassing: Bool = 4_174_379_265 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
