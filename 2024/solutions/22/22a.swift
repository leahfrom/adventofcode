import Foundation

let testInput: [String] = [
    "1",
    "10",
    "100",
    "2024",
]
let testSolution: Int = 37_327_623

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var secretNumbers: [Int] = input.map { Int($0)! }

    for i in 0..<secretNumbers.count {
        var secretNumber = secretNumbers[i]
        for _ in 0..<2000 {
            let step1 = secretNumber * 64
            secretNumber ^= step1
            secretNumber %= 16_777_216

            let step2 = secretNumber / 32
            secretNumber ^= step2
            secretNumber %= 16_777_216

            let step3 = secretNumber * 2048
            secretNumber ^= step3
            secretNumber %= 16_777_216
        }
        secretNumbers[i] = secretNumber
    }

    let output: Int = secretNumbers.reduce(0, +)
    return output
}

print("AoC Day 22a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
