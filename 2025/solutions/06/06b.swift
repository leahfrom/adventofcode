import Foundation

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []

    let sheet: [[String]] = input.map { $0.map { return String($0) } }

    var currentOperation: [Int] = []
    outerloop: for x in stride(from: sheet[0].count - 1, through: 0, by: -1) {
        var numberString: String = ""
        for y in 0..<sheet.count {
            if x >= sheet[y].count {
                continue
            }

            let value: String = sheet[y][x]

            if value == " " {
                continue
            }

            if value == "+" {
                currentOperation.append(Int(numberString)!)
                numberStore.append(currentOperation.reduce(0, +))
                currentOperation = []
                continue outerloop
            } else if value == "*" {
                currentOperation.append(Int(numberString)!)
                numberStore.append(currentOperation.reduce(1, *))
                currentOperation = []
                continue outerloop
            } else {
                numberString += value
            }
        }

        if numberString.isEmpty {
            continue
        }

        currentOperation.append(Int(numberString)!)
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 06b")
let testPassing: Bool = 3_263_827 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
