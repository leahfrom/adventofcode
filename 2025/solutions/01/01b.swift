import Foundation

func solvePuzzle(input: [String]) -> Int {
    var numberStore: Int = 0
    var position: Int = 50

    for line in input {
        let direction = line.prefix(1)
        let steps = line.dropFirst()

        if direction == "R" {
            for _ in 0..<Int(steps)! {
                position += 1
                if position > 99 {
                    position = 0
                }
                if position == 0 {
                    numberStore += 1
                }
            }
        } else {
            for _ in 0..<Int(steps)! {
                position -= 1
                if position < 0 {
                    position = 99
                }
                if position == 0 {
                    numberStore += 1
                }
            }
        }
    }

    return numberStore
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 01b")
let testPassing: Bool = 6 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
