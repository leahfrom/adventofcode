import Foundation

let testInput: [String] = [
    "3   4",
    "4   3",
    "2   5",
    "1   3",
    "3   9",
    "3   3",
]
let testSolution: Int = 11

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

    arrayOne.sort()
    arrayTwo.sort()

    for i in 0..<arrayOne.count {
        if arrayOne[i] <= arrayTwo[i] {
            numberStore.append(arrayTwo[i] - arrayOne[i])
        } else {
            numberStore.append(arrayOne[i] - arrayTwo[i])
        }
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

print("AoC Day 01a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
