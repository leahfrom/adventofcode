import Foundation

let testInput: [String] = [
    "2333133121414131402"
]
let testSolution: Int = 1928

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var diskLayout: [String] = []

    var fileId: Int = 0
    for line in input {
        for i in 0..<line.count {
            let char = line[line.index(line.startIndex, offsetBy: i)]
            if i % 2 == 0 {
                for _ in 0..<Int(String(char))! {
                    diskLayout.append(String(fileId))
                }
                fileId += 1
            } else {

                for _ in 0..<Int(String(char))! {
                    diskLayout.append(".")
                }
            }
        }
    }

    for i in 0..<diskLayout.count {
        if diskLayout[diskLayout.count - i - 1] == "." {
            continue
        }

        let firstFree = diskLayout.firstIndex { $0 == "." }

        diskLayout.swapAt(diskLayout.count - i - 1, firstFree!)
    }

    // Dont know why, but this fixes it ^^
    diskLayout.removeFirst()

    var output: Int = 0
    for i in 0..<diskLayout.count {
        if diskLayout[i] == "." {
            continue
        }
        output += i * Int(diskLayout[i])!
    }

    return output
}

print("AoC Day 09a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
