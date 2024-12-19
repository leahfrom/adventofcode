import Foundation

let testInput: [String] = [
    "r, wr, b, g, bwu, rb, gb, br",
    "",
    "brwrr",
    "bggr",
    "gbbr",
    "rrbgbr",
    "ubwu",
    "bwurrg",
    "brgr",
    "bbrgwb",
]
let testSolution: Int = 16

enum TowelStripe {
    case white, blue, black, red, green
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var possibleTowels: Int = 0
    var availableTowels: [[TowelStripe]] = []
    var wantedTowels: [[TowelStripe]] = []

    let splitInput = input.split(separator: "")

    func getStripeColor(_ char: String) -> TowelStripe {
        switch char {
        case "w": return .white
        case "u": return .blue
        case "b": return .black
        case "r": return .red
        case "g": return .green
        default: fatalError("Invalid towel stripe: \(char)")
        }
    }

    for line in splitInput[0] {
        let towelLine = line.split(separator: ", ")
        for towel in towelLine {
            var towelRow: [TowelStripe] = []
            for char in towel {
                towelRow.append(getStripeColor(String(char)))
            }
            availableTowels.append(towelRow)
        }
    }

    for towel in splitInput[1] {
        var towelRow: [TowelStripe] = []
        for char in towel {
            towelRow.append(getStripeColor(String(char)))
        }
        wantedTowels.append(towelRow)
    }

    var memo: [String: Int] = [:]

    func countArrangements(_ wantedDesign: [TowelStripe]) -> Int {
        if wantedDesign.isEmpty { return 1 }

        let key = wantedDesign.map { "\($0)" }.joined()
        if let cachedResult = memo[key] {
            return cachedResult
        }

        var possible = 0

        for towel in availableTowels {
            if wantedDesign.starts(with: towel) {
                let remainingDesign = Array(wantedDesign.dropFirst(towel.count))
                possible += countArrangements(remainingDesign)
            }
        }

        memo[key] = possible
        return possible
    }

    for wantedTowel in wantedTowels {
        possibleTowels += countArrangements(wantedTowel)
    }

    return possibleTowels
}

print("AoC Day 19b")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
