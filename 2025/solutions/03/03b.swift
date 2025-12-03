import Foundation

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []
    var highJoltages: [String] = []
    let runs: Int = 12
    var lastHighJoltageIndex: Int = 0

    for line in input {
        for run in 1...runs {
            var highJoltage: String = "0"
            let remainingRuns = runs - run + 1
            let endIndex = line.count - remainingRuns + 1

            let searchLength = max(0, endIndex - lastHighJoltageIndex)

            var bestIndex = lastHighJoltageIndex
            for (index, char) in line.dropFirst(lastHighJoltageIndex).prefix(
                searchLength
            ).enumerated() {
                if Int(String(char))! > Int(highJoltage)! {
                    highJoltage = String(char)
                    bestIndex = index + lastHighJoltageIndex
                }
            }
            lastHighJoltageIndex = bestIndex + 1

            highJoltages.append(highJoltage)
        }

        numberStore.append(Int(highJoltages.joined())!)
        highJoltages = []
        lastHighJoltageIndex = 0
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 03b")

let testPassing: Bool = 3_121_910_778_619 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
