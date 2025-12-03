import Foundation

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []

    for line in input {
        var highJoltage: String = "0"
        var highJoltageIndex: Int = 0

        for (index, char) in line.dropLast().enumerated() {
            if Int(String(char))! > Int(highJoltage)! {
                highJoltage = String(char)
                highJoltageIndex = index + 1
            }
        }

        var secondHighJoltage: String = "0"
        for char in line.dropFirst(highJoltageIndex) {
            if Int(String(char))! > Int(secondHighJoltage)! {
                secondHighJoltage = String(char)
            }
        }

        numberStore.append(Int(highJoltage + secondHighJoltage)!)
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 03a")
let testPassing: Bool = 357 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
