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
let testSolution: Int = 6

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

    func canConstruct(_ wantedDesign: [TowelStripe], _ currentIndex: Int) -> Bool {
        if wantedDesign.isEmpty { return true }

        for (index, towel) in availableTowels.enumerated() {
            if wantedDesign.starts(with: towel) {
                let remainingDesign = Array(wantedDesign.dropFirst(towel.count))
                if canConstruct(remainingDesign, index) {
                    return true
                }
            }
        }

        return false
    }

    for wantedTowel in wantedTowels {
        if canConstruct(wantedTowel, 0) {
            possibleTowels += 1
        }
    }

    return possibleTowels
}

print("AoC Day 19a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
