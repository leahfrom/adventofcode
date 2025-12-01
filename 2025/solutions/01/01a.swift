import Foundation

func solvePuzzle(input: [String]) -> Int {
    var solution: Int = 0
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
            }
        } else {
            for _ in 0..<Int(steps)! {
                position -= 1
                if position < 0 {
                    position = 99
                }
            }
        }

        if position == 0 {
            solution += 1
        }
    }

    return solution
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 01a")
let testPassing: Bool = 3 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
