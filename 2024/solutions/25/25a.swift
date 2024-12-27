import Foundation

func solvePuzzle(input: [String]) -> Int {
    var keysThatFit: Int = 0

    var locks: [[Int]] = []
    var keys: [[Int]] = []

    let splitInput = input.split(separator: "").map({ $0.map({ $0.map({ String($0) }) }) })

    func getConfig(_ object: [[String]]) -> [Int] {
        var config: [Int] = []

        for y in 0..<object.count {
            for x in 0..<object[y].count {
                if object[y][x] == "#" {
                    if config.count == x {
                        config.append(0)
                    } else {
                        config[x] += 1
                    }
                }
            }
        }

        return config
    }

    for object in splitInput {
        if object[0].filter({ $0 == "#" }).count == object[0].count {
            locks.append(getConfig(object))
        } else {
            keys.append(getConfig(object.reversed()))
        }
    }

    for lock in locks {
        for key in keys {
            var isFitting: Bool = true

            for i in 0..<lock.count {
                if lock[i] + key[i] > 5 {
                    isFitting = false
                    break
                }
            }

            if isFitting {
                keysThatFit += 1
            }

        }
    }

    return keysThatFit
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 25a")
let testPassing: Bool = 3 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
