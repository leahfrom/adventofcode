import Foundation

struct Machine: Hashable {
    var lightDiagram: [Bool]
    var buttons: [[Int]]
    var joltageRequirements: [Int]
}

func solvePuzzle(input: [String]) -> Int {
    var numberStore: [Int] = []

    var machines: [Machine] = []
    for line in input {
        let components = line.split(separator: " ")

        let lightDiagramString = components[0]
        var lightDiagram: [Bool] = []
        for char in lightDiagramString.trimmingCharacters(in: CharacterSet(charactersIn: "[]")) {
            if char == "#" {
                lightDiagram.append(true)
            } else {
                lightDiagram.append(false)
            }
        }

        var buttons: [[Int]] = []
        for i in 1..<components.count - 1 {
            let buttonString = components[i]
            let buttonNumbers =
                buttonString
                .trimmingCharacters(in: CharacterSet(charactersIn: "()"))
                .split(separator: ",")
                .compactMap { Int($0) }
            buttons.append(buttonNumbers)
        }

        let joltageString = components.last!
        let joltageRequirements: [Int] =
            joltageString
            .trimmingCharacters(in: CharacterSet(charactersIn: "{}"))
            .split(separator: ",").compactMap { Int($0) }

        machines.append(
            Machine(
                lightDiagram: lightDiagram, buttons: buttons,
                joltageRequirements: joltageRequirements))
    }

    for machine in machines {
        var minPresses: Int = Int.max
        let totalButtons = machine.buttons.count
        let totalCombinations = 1 << totalButtons

        for combination in 0..<totalCombinations {
            var currentLights: [Bool] = Array(repeating: false, count: machine.lightDiagram.count)
            var presses = 0

            for buttonIndex in 0..<totalButtons {
                if (combination & (1 << buttonIndex)) != 0 {
                    presses += 1
                    for lightIndex in machine.buttons[buttonIndex] {
                        if lightIndex < currentLights.count {
                            currentLights[lightIndex] = !currentLights[lightIndex]
                        }
                    }
                }
            }

            if currentLights == machine.lightDiagram {
                if presses < minPresses {
                    minPresses = presses
                }
            }
        }

        numberStore.append(minPresses)
    }

    let output: Int = numberStore.reduce(0, +)
    return output
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 10a")
let testPassing: Bool = 7 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
