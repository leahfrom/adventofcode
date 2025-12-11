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

    var memo: [String: Int] = [:]

    func findPaths(from deviceId: String, to: String, visited: Set<String>) -> Int {
        let memoKey = "\(deviceId)->\(to)"
        if let cachedResult = memo[memoKey] {
            return cachedResult
        }

        var possiblePaths: Int = 0
        if deviceId == to {
            possiblePaths += 1
            memo[memoKey] = possiblePaths
            return possiblePaths
        }
        guard let device = devices.first(where: { $0.id == deviceId }) else {
            memo[memoKey] = possiblePaths
            return possiblePaths
        }
        for output in device.outputs {
            if !visited.contains(output) {
                var newVisited = visited
                newVisited.insert(output)
                possiblePaths += findPaths(from: output, to: to, visited: newVisited)
            }
        }
        memo[memoKey] = possiblePaths
        return possiblePaths
    }

    let svr_dac = findPaths(from: "svr", to: "dac", visited: Set(["svr"]))
    let dac_fft = findPaths(from: "dac", to: "fft", visited: Set(["dac"]))
    let fft_out = findPaths(from: "fft", to: "out", visited: Set(["fft"]))

    let svr_fft = findPaths(from: "svr", to: "fft", visited: Set(["svr"]))
    let fft_dac = findPaths(from: "fft", to: "dac", visited: Set(["fft"]))
    let dac_out = findPaths(from: "dac", to: "out", visited: Set(["dac"]))

    return (svr_dac * dac_fft * fft_out) + (svr_fft * fft_dac * dac_out)
}

func loadFileContent(_ path: String) -> [String] {
    return try! String(contentsOfFile: path, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines).components(
            separatedBy: "\n")
}

print("AoC Day 11b")
let testPassing: Bool = 2 == solvePuzzle(input: loadFileContent("./testInput.txt"))
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: loadFileContent("./puzzleInput.txt")))")
}
