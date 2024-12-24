import Foundation

let testInput: [String] = [
    "x00: 1",
    "x01: 1",
    "x02: 1",
    "y00: 0",
    "y01: 1",
    "y02: 0",
    "",
    "x00 AND y00 -> z00",
    "x01 XOR y01 -> z01",
    "x02 OR y02 -> z02",
]
let testSolution: Int = 4

struct Cable: Comparable {
    let name: String
    let value: Bool

    static func < (lhs: Cable, rhs: Cable) -> Bool {
        return lhs.name < rhs.name
    }
}

enum GateType {
    case AND, XOR, OR
}

struct Gate {
    let inputs: [String]
    let type: GateType
    let output: String

    func evaluate(inputs: [Cable]) -> Bool {
        let inputValues = inputs.map { $0.value }
        switch type {
        case .AND:
            return inputValues[0] && inputValues[1]
        case .XOR:
            return inputValues[0] != inputValues[1]
        case .OR:
            return inputValues[0] || inputValues[1]
        }
    }
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    let splitInput = input.split(separator: "")

    var cables = splitInput[0].map {
        let splitted = $0.split(separator: ": ")
        return Cable(name: String(splitted[0]), value: Int(splitted[1])! == 1)
    }

    var gates = splitInput[1].map {
        let splitted = $0.split(separator: " ")
        return Gate(
            inputs: [String(splitted[0]), String(splitted[2])],
            type: splitted[1] == "AND" ? .AND : splitted[1] == "XOR" ? .XOR : .OR,
            output: String(splitted[4]))
    }

    while gates.count > 0 {
        let gate = gates.removeFirst()

        let inputs = gate.inputs.compactMap { input in
            cables.first(where: { $0.name == input })
        }

        if inputs.count < gate.inputs.count {
            gates.append(gate)
        } else {
            let output = Cable(name: gate.output, value: gate.evaluate(inputs: inputs))
            if let index = cables.firstIndex(where: { $0.name == output.name }) {
                cables[index] = output
            } else {
                cables.append(output)
            }
        }

    }

    let bits: [String] = cables.filter({ $0.name.starts(with: "z") }).sorted(by: >).map({
        $0.value ? "1" : "0"
    })
    let output: Int = Int(bits.joined(), radix: 2)!
    return output
}

print("AoC Day 24a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
