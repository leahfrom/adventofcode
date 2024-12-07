import Foundation

let testInput: [String] = [
    "190: 10 19",
    "3267: 81 40 27",
    "83: 17 5",
    "156: 15 6",
    "7290: 6 8 6 15",
    "161011: 16 10 13",
    "192: 17 8 14",
    "21037: 9 7 18 13",
    "292: 11 6 16 20",
]
let testSolution: Int = 3749

struct Equation {
    var result: Int
    var numbers: [Int]
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []
    var equations: [Equation] = []

    for line in input {
        let parts: [String] = line.components(separatedBy: ": ")
        let result: Int = Int(parts[0])!
        let numbers: [Int] = parts[1].components(separatedBy: " ").map { Int($0)! }
        equations.append(Equation(result: result, numbers: numbers))
    }

    for equation in equations {
        let operatorCount = equation.numbers.count - 1
        let possibilities = Int(pow(2.0, Double(operatorCount)))

        for i in 0..<possibilities {
            var result = equation.numbers[0]
            var index = 1

            for j in 0..<operatorCount {
                let operatorType = (i / Int(pow(2.0, Double(j)))) % 2
                let nextNumber = equation.numbers[index]

                if operatorType == 0 {
                    result += nextNumber
                } else {
                    result *= nextNumber
                }

                index += 1
            }

            if result == equation.result {
                numberStore.append(equation.result)
                break
            }
        }
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

print("AoC Day 07a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
