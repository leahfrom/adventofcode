import Foundation

let testInput: [String] = [
    "125 17"
]
let testSolution: Int = 55312

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    let blinking: Int = 25
    var stones: [Int] = []

    for line in input {
        let tmpStones: [Int] = line.components(separatedBy: " ").map { Int($0)! }
        for stone in tmpStones {
            stones.append(stone)
        }
    }

    for _ in 0..<blinking {
        var newStones: [Int] = []
        for stone in stones {
            if stone == 0 {
                newStones.append(1)
            } else if String(stone).count % 2 == 0 {
                let numberString = String(stone)
                let midIndex = numberString.index(
                    numberString.startIndex, offsetBy: numberString.count / 2)

                let firstNumber = Int(String(numberString[numberString.startIndex..<midIndex])) ?? 0
                let secondNumber = Int(String(numberString[midIndex...])) ?? 0

                newStones.append(firstNumber)
                newStones.append(secondNumber)
            } else {
                newStones.append(stone * 2024)
            }

            stones = newStones
        }
    }

    let output: Int = stones.count
    return output
}

print("AoC Day 11a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
