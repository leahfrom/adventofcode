import Foundation

let testInput: [String] = [
    "............",
    "........0...",
    ".....0......",
    ".......0....",
    "....0.......",
    "......A.....",
    "............",
    "............",
    "........A...",
    ".........A..",
    "............",
    "............",
]
let testSolution: Int = 34

struct Antenna: Equatable {
    var x: Int
    var y: Int
    var frequency: String

    static func == (lhs: Antenna, rhs: Antenna) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.frequency == rhs.frequency
    }
}

struct Antinode: Hashable {
    var x: Int
    var y: Int
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var antennas: [Antenna] = []
    var antinodes: Set<Antinode> = Set<Antinode>()

    let map = input.map { $0.map { String($0) } }

    for y in 0..<map.count {
        for x in 0..<map[y].count {
            if map[y][x] != "." {
                antennas.append(Antenna(x: x, y: y, frequency: map[y][x]))
            }
        }
    }

    for antenna in antennas {
        let antennaOne = antenna

        for antennaTwo in antennas {
            if antennaOne == antennaTwo {
                continue
            }

            if antennaOne.frequency != antennaTwo.frequency {
                continue
            }

            antinodes.insert(Antinode(x: antennaOne.x, y: antennaOne.y))
            antinodes.insert(Antinode(x: antennaTwo.x, y: antennaTwo.y))

            let xDiff: Int = antennaTwo.x - antennaOne.x
            let yDiff: Int = antennaTwo.y - antennaOne.y

            for i in 1... {
                let xForward = antennaOne.x + i * xDiff
                let yForward = antennaOne.y + i * yDiff
                if 0..<map[0].count ~= xForward && 0..<map.count ~= yForward {
                    antinodes.insert(Antinode(x: xForward, y: yForward))
                } else {
                    break
                }
            }

            for i in 1... {
                let xBackward = antennaOne.x - i * xDiff
                let yBackward = antennaOne.y - i * yDiff
                if 0..<map[0].count ~= xBackward && 0..<map.count ~= yBackward {
                    antinodes.insert(Antinode(x: xBackward, y: yBackward))
                } else {
                    break
                }
            }
        }
    }

    let output: Int = antinodes.filter { 0..<map.count ~= $0.y && 0..<map[0].count ~= $0.x }
        .count
    return output
}

print("AoC Day 08b")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
