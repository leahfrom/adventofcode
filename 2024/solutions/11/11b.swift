import Foundation

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

struct Key: Hashable {
    let stone: Int
    let remainingBlinks: Int
}

var cache = [Key: Int]()

func blinkAtStone(value: Int, remainingBlinks: Int) -> Int {
    if remainingBlinks == 0 {
        return 1
    }

    let key = Key(stone: value, remainingBlinks: remainingBlinks)
    if cache[key] != nil {
        return cache[key]!
    }

    var result: Int = 0
    if value == 0 {
        result = blinkAtStone(value: 1, remainingBlinks: remainingBlinks - 1)
    } else if String(value).count % 2 == 0 {
        let numberString = String(value)
        let midIndex = numberString.index(
            numberString.startIndex, offsetBy: numberString.count / 2)

        let firstNumber = Int(String(numberString[numberString.startIndex..<midIndex])) ?? 0
        let secondNumber = Int(String(numberString[midIndex...])) ?? 0
        result =
            blinkAtStone(value: firstNumber, remainingBlinks: remainingBlinks - 1)
            + blinkAtStone(value: secondNumber, remainingBlinks: remainingBlinks - 1)
    } else {
        result = blinkAtStone(value: 2024 * value, remainingBlinks: remainingBlinks - 1)
    }

    cache[key] = result
    return result
}

func solvePuzzle(input: [String]) -> Int {
    let blinking: Int = 75
    var stones: [Int] = []

    for line in input {
        let tmpStones: [Int] = line.components(separatedBy: " ").map { Int($0)! }
        for stone in tmpStones {
            stones.append(stone)
        }
    }

    var numberStones: Int = 0
    for stone in stones {
        numberStones += blinkAtStone(value: stone, remainingBlinks: blinking)
    }

    return numberStones
}

print("AoC Day 11b")
print("Solution: \(solvePuzzle(input: puzzleInput))")
