import Foundation

let testInput: [String] = [
    "1",
    "2",
    "3",
    "2024",
]
let testSolution: Int = 23

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    let secretNumbers: [Int] = input.map { Int($0)! }
    var maxBananas = 0

    let possibleChanges = (-9...9).flatMap { a in
        (-9...9).flatMap { b in
            (-9...9).flatMap { c in
                (-9...9).map { d in
                    [a, b, c, d]
                }
            }
        }
    }

    for sequence in possibleChanges {
        var totalBananas = 0

        for secretNumber in secretNumbers {
            var prices: [Int] = []

            var currentSecret = secretNumber
            for _ in 0..<2000 {
                let step1 = currentSecret * 64
                currentSecret ^= step1
                currentSecret %= 16_777_216

                let step2 = currentSecret / 32
                currentSecret ^= step2
                currentSecret %= 16_777_216

                let step3 = currentSecret * 2048
                currentSecret ^= step3
                currentSecret %= 16_777_216
                prices.append(currentSecret % 10)
            }

            let changes = zip(prices.dropFirst(), prices).map(-)

            if let index = changes.indices.first(where: {
                $0 + 3 < changes.count && changes[$0] == sequence[0]
                    && changes[$0 + 1] == sequence[1] && changes[$0 + 2] == sequence[2]
                    && changes[$0 + 3] == sequence[3]
            }) {
                totalBananas += prices[index + 4]
            }
        }

        maxBananas = max(maxBananas, totalBananas)
    }

    return maxBananas
}

print("AoC Day 22b")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
