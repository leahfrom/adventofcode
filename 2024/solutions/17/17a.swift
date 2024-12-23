import Foundation

let testInput: [String] = [
    "Register A: 729",
    "Register B: 0",
    "Register C: 0",
    "",
    "Program: 0,1,5,4,3,0",
]
let testSolution: String = "4,6,3,5,6,3,5,2,1,0"

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func getComboOperandValue(_ operand: Int, _ registers: [Int]) -> Int {
    switch operand {
    case 0...3: return operand
    case 4: return registers[0]
    case 5: return registers[1]
    case 6: return registers[2]
    default: fatalError("Invalid combo operand: \(operand)")
    }
}

func solvePuzzle(input: [String]) -> String {
    var numberStore: [Int] = []

    var registers: [Int] = []
    var program: [Int] = []

    let splitInput = input.split(separator: "")
    for line in splitInput[0] {
        let register = line.split(separator: " ")
        registers.append(Int(register[2])!)
    }

    for line in splitInput[1] {
        let programLine = line.split(separator: " ")[1].split(separator: ",")
        for instruction in programLine {
            program.append(Int(instruction)!)
        }
    }

    var instructionPointer = 0

    while instructionPointer < program.count {
        let operation = program[instructionPointer]
        let operand = program[instructionPointer + 1]

        switch operation {
        case 0:  // adv - divide A by 2^operand (combo operand)
            let denominator = Int(pow(2.0, Double(getComboOperandValue(operand, registers))))
            registers[0] /= denominator
        case 1:  // bxl - B XOR literal operand
            registers[1] ^= operand
        case 2:  // bst - B = operand % 8
            registers[1] = getComboOperandValue(operand, registers) % 8
        case 3:  // jnz - jump to operand if A != 0
            if registers[0] != 0 {
                instructionPointer = operand
                continue
            }
        case 4:  // bxc - B XOR C
            registers[1] ^= registers[2]
        case 5:  // out - output combo operand % 8
            numberStore.append(getComboOperandValue(operand, registers) % 8)
        case 6:  // bdv - B = A / 2^operand (combo operand)
            let denominator = Int(pow(2.0, Double(getComboOperandValue(operand, registers))))
            registers[1] = registers[0] / denominator
        case 7:  // cdv - C = A / 2^operand (combo operand)
            let denominator = Int(pow(2.0, Double(getComboOperandValue(operand, registers))))
            registers[2] = registers[0] / denominator
        default: fatalError("Invalid operation: \(operation)")
        }

        instructionPointer += 2
    }

    let output: String = numberStore.map { String($0) }.joined(separator: ",")
    return output
}

print("AoC Day 17a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}