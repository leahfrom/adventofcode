import Foundation

let testInput: [String] = [
    "kh-tc",
    "qp-kh",
    "de-cg",
    "ka-co",
    "yn-aq",
    "qp-ub",
    "cg-tb",
    "vc-aq",
    "tb-ka",
    "wh-tc",
    "yn-cg",
    "kh-ub",
    "ta-co",
    "de-co",
    "tc-td",
    "tb-wq",
    "wh-td",
    "ta-ka",
    "td-qp",
    "aq-cg",
    "wq-ub",
    "ub-vc",
    "de-ta",
    "wq-aq",
    "wq-vc",
    "wh-yn",
    "ka-de",
    "kh-ta",
    "co-tc",
    "wh-qp",
    "tb-vc",
    "td-yn",
]
let testSolution: String = "co,de,ka,ta"

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> String {
    var connections: [String: Set<String>] = [:]
    for connection in input {
        let nodes = connection.split(separator: "-").map { String($0) }
        guard nodes.count == 2 else { continue }
        connections[nodes[0], default: []].insert(nodes[1])
        connections[nodes[1], default: []].insert(nodes[0])
    }

    var largestGroup: Set<String> = []

    func findGroup(startNode: String, potentialNodes: Set<String>) {
        var group = Set([startNode])
        var candidates = potentialNodes

        for node in potentialNodes {
            if group.isSubset(of: connections[node] ?? []) {
                group.insert(node)
                candidates.remove(node)
            }
        }

        if group.count > largestGroup.count {
            largestGroup = group
        }
    }

    for node in connections.keys {
        let neighbors = connections[node] ?? []
        findGroup(startNode: node, potentialNodes: neighbors)
    }

    let password = largestGroup.sorted().joined(separator: ",")
    return password
}

print("AoC Day 23b")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
