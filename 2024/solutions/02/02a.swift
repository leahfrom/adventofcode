import Foundation

let testInput: [String] = [
    "7 6 4 2 1",
    "1 2 7 8 9",
    "9 7 6 2 1",
    "1 3 2 4 5",
    "8 6 4 4 1",
    "1 3 6 7 9",
]
let testSolution: Int = 2

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []

    for line in input {
        let levels = line.split(separator: " ")
        var safe: Bool = true
        var state: String? = nil

        for i in 0..<levels.count - 1 {
            if state == nil {
                if Int(levels[i + 1])! - Int(levels[i])! > 0 {
                    state = "incr"
                } else if Int(levels[i + 1])! - Int(levels[i])! < 0 {
                    state = "decr"
                } else {
                    safe = false
                }
            }
            if state == "incr" {
                if Int(levels[i + 1])! - Int(levels[i])! > 3
                    || Int(levels[i + 1])! - Int(levels[i])! <= 0
                {
                    safe = false
                }
            } else {
                if Int(levels[i])! - Int(levels[i + 1])! > 3
                    || Int(levels[i])! - Int(levels[i + 1])! <= 0
                {
                    safe = false
                }
            }

        }

        if safe {
            numberStore.append(1)
        }
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

print("AoC Day 02a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
