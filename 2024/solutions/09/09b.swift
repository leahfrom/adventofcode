import Foundation

let testInput: [String] = [
    "2333133121414131402"
]
let testSolution: Int = 2858

struct File {
    var startIndex: Int
    var lenght: Int
    var content: Int
    var touched: Bool = false
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var rawDiskLayout: [String] = []
    var diskLayout: [File] = []

    var fileId: Int = 0
    for line in input {
        for i in 0..<line.count {
            let char = line[line.index(line.startIndex, offsetBy: i)]
            if i % 2 == 0 {
                for _ in 0..<Int(String(char))! {
                    rawDiskLayout.append(String(fileId))
                }
                fileId += 1
            } else {
                for _ in 0..<Int(String(char))! {
                    rawDiskLayout.append(".")
                }
            }
        }
    }

    var lastFilePart: String = ""
    for i in 0..<rawDiskLayout.count {
        if rawDiskLayout[i] == "." {
            continue
        }

        if lastFilePart == rawDiskLayout[i] {
            continue
        } else {
            lastFilePart = rawDiskLayout[i]
        }

        var lenght: Int = 0
        for j in i..<rawDiskLayout.count {
            if rawDiskLayout[j] != rawDiskLayout[i] {
                break
            }
            lenght += 1
        }

        diskLayout.append(File(startIndex: i, lenght: lenght, content: Int(rawDiskLayout[i])!))
    }

    var sorted: Bool = false
    while !sorted {
        sorted = true
        outerLoop: for (index, file) in diskLayout.reversed().enumerated() {
            if file.touched {
                continue
            }

            for i in 0..<diskLayout.count - index - 1 {
                let freeSpace =
                    diskLayout[i + 1].startIndex
                    - (diskLayout[i].startIndex + diskLayout[i].lenght)

                if file.lenght <= freeSpace {
                    diskLayout[diskLayout.count - index - 1].startIndex =
                        diskLayout[i].startIndex + diskLayout[i].lenght
                    diskLayout.sort { $0.startIndex < $1.startIndex }
                    sorted = false
                    break outerLoop
                }
            }
            diskLayout[diskLayout.count - index - 1].touched = true
        }
    }

    var tmpLayout: [String] = []
    var skip: Int = 0
    for i in 0..<diskLayout.last!.startIndex + diskLayout.last!.lenght {
        if skip > 0 {
            skip -= 1
            continue
        }
        if diskLayout.first(where: { $0.startIndex == i }) != nil {
            for _ in 0..<diskLayout.first(where: { $0.startIndex == i })!.lenght {
                tmpLayout.append(String(diskLayout.first(where: { $0.startIndex == i })!.content))
            }
            skip = diskLayout.first(where: { $0.startIndex == i })!.lenght - 1
        } else {
            tmpLayout.append(".")
        }
    }

    var output: Int = 0
    for i in 0..<tmpLayout.count {
        if tmpLayout[i] == "." {
            continue
        }
        output += i * Int(tmpLayout[i])!
    }

    return output
}

print("AoC Day 09b")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
