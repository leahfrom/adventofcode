import Foundation

let testInput: [String] = [
    "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
]
let testSolution: Int = 48

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = [textFile.components(separatedBy: "\n").joined(separator: "")]

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []

    for line in input {

        let sublines = line.components(separatedBy: "do")

        for subline in sublines {
            if subline.contains("n't") { continue }

            let matches = subline.matches(of: try! Regex("mul\\((\\d+),(\\d+)\\)"))
            for match in matches {
                let numbers = match.0.matches(of: try! Regex("\\((\\d+),(\\d+)\\)"))
                numberStore.append(
                    Int(String(describing: numbers[0].output[1].value!))!
                        * Int(String(describing: numbers[0].output[2].value!))!)
            }

        }
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

print("AoC Day 03b")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
