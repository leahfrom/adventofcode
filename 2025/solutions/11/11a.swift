import Foundation

struct Device: Hashable {
    var id: String
    var outputs: [String]
}

func solvePuzzle(input: [String]) -> Int {
    var devices: [Device] = []
    for line in input {
        let components = line.components(separatedBy: ": ")
        let deviceId = components[0]
        let outputs = components[1].components(separatedBy: " ")
        devices.append(Device(id: deviceId, outputs: outputs))
    }

    var possiblePaths: Int = 0

    func findPaths(from deviceId: String, visited: Set<String>) {
        if deviceId == "out" {
            possiblePaths += 1
            return
        }
        guard let device = devices.first(where: { $0.id == deviceId }) else {
            return
        }
        for output in device.outputs {
            if !visited.contains(output) {
                var newVisited = visited
                newVisited.insert(output)
                findPaths(from: output, visited: newVisited)
            }
        }
    }
    findPaths(from: "you", visited: Set(["you"]))

    return possiblePaths
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 11a")
let testPassing: Bool = 5 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
