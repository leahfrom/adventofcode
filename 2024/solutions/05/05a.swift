import Foundation

let testInput: [String] = [
    "47|53",
    "97|13",
    "97|61",
    "97|47",
    "75|29",
    "61|13",
    "75|53",
    "29|13",
    "97|29",
    "53|29",
    "61|53",
    "97|53",
    "61|29",
    "47|13",
    "75|47",
    "97|75",
    "47|61",
    "75|61",
    "47|29",
    "75|13",
    "53|13",
    "",
    "75,47,61,53,29",
    "97,61,53,29,13",
    "75,29,13",
    "75,97,47,61,53",
    "61,13,29",
    "97,13,75,29,47",
]
let testSolution: Int = 143

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []

    let split: Int = input.firstIndex(of: "")!
    let rules: [String] = input[0..<split].map { return String($0) }
    let updates: [String] = input[split + 1...input.count - 1].map { return $0 }

    for update in updates {
        let pages = update.components(separatedBy: ",")
        var orderedRight: Bool = true

        outerLoop: for i in 0..<pages.count {
            for rule in rules {
                if pages[i] == String(rule.components(separatedBy: "|")[0])
                    && pages.contains(String(rule.components(separatedBy: "|")[1]))
                {
                    if !pages[i...pages.count - 1].joined(separator: ",").contains(
                        String(rule.components(separatedBy: "|")[1]))
                    {
                        orderedRight = false
                        break outerLoop
                    }
                }
            }
        }

        if orderedRight {
            numberStore.append(Int(pages[pages.count / 2])!)
        }
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

print("AoC Day 05a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
