import Foundation

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []

    let sheet: [[String]] = input.map { $0.split(separator: " ").map { return String($0) } }

    for row in sheet.dropLast() {
        for (index, value) in row.enumerated() {
            let intValue: Int = Int(value)!

            if (sheet.last![index]) == "+" {
                if numberStore.count <= index {
                    numberStore.append(intValue)
                } else {
                    numberStore[index] += intValue
                }
            } else if (sheet.last![index]) == "*" {
                if numberStore.count <= index {
                    numberStore.append(intValue)
                } else {
                    numberStore[index] *= intValue
                }
            }

        }
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 06a")
let testPassing: Bool = 4_277_556 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
