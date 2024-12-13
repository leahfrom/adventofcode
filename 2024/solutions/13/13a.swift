import Foundation

let testInput: [String] = [
    "Button A: X+94, Y+34",
    "Button B: X+22, Y+67",
    "Prize: X=8400, Y=5400",
    "",
    "Button A: X+26, Y+66",
    "Button B: X+67, Y+21",
    "Prize: X=12748, Y=12176",
    "",
    "Button A: X+17, Y+86",
    "Button B: X+84, Y+37",
    "Prize: X=7870, Y=6450",
    "",
    "Button A: X+69, Y+23",
    "Button B: X+27, Y+71",
    "Prize: X=18641, Y=10279",
]
let testSolution: Int = 480

struct Point: Hashable {
    var x: Int
    var y: Int
}

struct Machine {
    var buttonAX: Int
    var buttonAY: Int
    var buttonBX: Int
    var buttonBY: Int
    var prizePosition: Point
}

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var totalTokens = 0
    var machines: [Machine] = []

    let splitInput = input.split(separator: "").map { Array($0) }

    for block in splitInput {
        var buttonAX: Int = 0
        var buttonAY: Int = 0
        var buttonBX: Int = 0
        var buttonBY: Int = 0
        var prizePosition: Point = Point(x: 0, y: 0)

        for line in block {
            if line.starts(with: "Button A") {
                buttonAX = Int(
                    line.components(separatedBy: ", ")[0].components(separatedBy: "+")[1])!
                buttonAY = Int(
                    line.components(separatedBy: ", ")[1].components(separatedBy: "+")[1])!
            }
            if line.starts(with: "Button B") {
                buttonBX = Int(
                    line.components(separatedBy: ", ")[0].components(separatedBy: "+")[1])!
                buttonBY = Int(
                    line.components(separatedBy: ", ")[1].components(separatedBy: "+")[1])!
            }
            if line.starts(with: "Prize") {
                prizePosition = Point(
                    x: Int(line.components(separatedBy: ", ")[0].components(separatedBy: "=")[1])!,
                    y: Int(line.components(separatedBy: ", ")[1].components(separatedBy: "=")[1])!
                )
            }
        }
        machines.append(
            Machine(
                buttonAX: buttonAX,
                buttonAY: buttonAY,
                buttonBX: buttonBX,
                buttonBY: buttonBY,
                prizePosition: prizePosition
            ))
    }

    for machine in machines {
        let maxPresses = 100
        var minTokens: Int? = nil

        for a in 0...maxPresses {
            for b in 0...maxPresses {
                let x = a * machine.buttonAX + b * machine.buttonBX
                let y = a * machine.buttonAY + b * machine.buttonBY
                if x == machine.prizePosition.x && y == machine.prizePosition.y {
                    let cost = a * 3 + b * 1
                    if minTokens == nil || cost < minTokens! {
                        minTokens = cost
                    }
                }
            }
        }

        if let tokens = minTokens {
            totalTokens += tokens
        }
    }

    return totalTokens
}

print("AoC Day 13a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
