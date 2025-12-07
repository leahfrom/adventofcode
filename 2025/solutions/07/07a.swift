import Foundation

struct Point: Hashable {
    var x: Int
    var y: Int
}

struct Beam: Hashable {
    var position: Point
}

struct Splitter: Hashable {
    var position: Point
}

func solvePuzzle(input: [String]) -> Int {
    var numberOfSplits: Int = 0

    var beams: Set<Beam> = []
    var splitters: Set<Splitter> = []

    for (y, row) in input.enumerated() {
        for (x, char) in row.enumerated() {
            if char == "S" {
                beams.insert(Beam(position: Point(x: x, y: y)))
            }
            if char == "^" {
                splitters.insert(Splitter(position: Point(x: x, y: y)))
            }
        }
    }

    let gridWidth = input[0].count

    var movedBeam: Bool = true
    while movedBeam {
        movedBeam = false

        var splittersToRemove: Set<Splitter> = []

        let lowestY = beams.map { $0.position.y }.min() ?? 0
        var newBeams: Set<Beam> = beams.filter({ $0.position.y != lowestY })

        for beam in beams.filter({ $0.position.y == lowestY }) {
            var beamSplit: Bool = false
            for splitter in splitters {
                if beam.position == splitter.position {
                    let leftX = beam.position.x - 1
                    let rightX = beam.position.x + 1

                    if leftX >= 0 {
                        let leftBeam = Beam(position: Point(x: leftX, y: beam.position.y))
                        newBeams.insert(leftBeam)
                    }

                    if rightX < gridWidth {
                        let rightBeam = Beam(position: Point(x: rightX, y: beam.position.y))
                        newBeams.insert(rightBeam)
                    }

                    numberOfSplits += 1
                    beamSplit = true
                    movedBeam = true
                    splittersToRemove.insert(splitter)
                }
            }
            if !beamSplit && beam.position.y + 1 < input.count {
                let newBeam = Beam(position: Point(x: beam.position.x, y: beam.position.y + 1))
                newBeams.insert(newBeam)
                movedBeam = true
            }
        }

        for splitter in splittersToRemove {
            splitters.remove(splitter)
        }

        beams = newBeams
    }

    return numberOfSplits
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 07a")
let testPassing: Bool = 21 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
