import Foundation

let testInput: [String] = [
    "#####",
    ".####",
    ".####",
    ".####",
    ".#.#.",
    ".#...",
    ".....",
    "",
    "#####",
    "##.##",
    ".#.##",
    "...##",
    "...#.",
    "...#.",
    ".....",
    "",
    ".....",
    "#....",
    "#....",
    "#...#",
    "#.#.#",
    "#.###",
    "#####",
    "",
    ".....",
    ".....",
    "#.#..",
    "###..",
    "###.#",
    "###.#",
    "#####",
    "",
    ".....",
    ".....",
    ".....",
    "#....",
    "#.#..",
    "#.#.#",
    "#####",
]
let testSolution: Int = 3

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var keysThatFit: Int = 0

    var locks: [[Int]] = []
    var keys: [[Int]] = []

    let splitInput = input.split(separator: "")

    for splitted in splitInput {
        let object = Array(splitted.map({ $0.map { String($0) } }))

        if object[0].filter({ $0 == "#" }).count == object[0].count {
            var lock: [Int] = []

            for y in 0..<object.count {
                for x in 0..<object[y].count {
                    if object[y][x] == "#" {
                        if lock.count == x {
                            lock.append(0)
                        } else {
                            lock[x] += 1
                        }
                    }
                }
            }

            locks.append(lock)
        } else {
            var key: [Int] = []

            for y in 0..<object.count {
                for x in 0..<object[y].count {
                    if object.reversed()[y][x] == "#" {
                        if key.count == x {
                            key.append(0)
                        } else {
                            key[x] += 1
                        }
                    }
                }
            }

            keys.append(key)
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

print("AoC Day 25a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
