import Foundation

let testInput: [String] = [
    "3   4",
    "4   3",
    "2   5",
    "1   3",
    "3   9",
    "3   3",
]
let testSolution: Int = 31

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []

    var arrayOne: [Int] = []
    var arrayTwo: [Int] = []

    for row in input {
        let numbers = row.split(separator: "   ")
        if numbers.count == 2 {
            arrayOne.append(Int(numbers[0])!)
            arrayTwo.append(Int(numbers[1])!)
        }
    }

    let mappedArrayTwo = arrayTwo.map { ($0, 1) }
    let counts = Dictionary(mappedArrayTwo, uniquingKeysWith: +)

    for i in 0..<arrayOne.count {
        if counts[arrayOne[i]] != nil {
            numberStore.append(arrayOne[i] * counts[arrayOne[i]]!)
        }
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

print("AoC Day 01b")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
