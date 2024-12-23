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
let testSolution: Int = 7

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

func solvePuzzle(input: [String]) -> Int {
    var connections: [String: Set<String>] = [:]
    for connection in input {
        let nodes = connection.split(separator: "-").map { String($0) }
        guard nodes.count == 2 else { continue }
        connections[nodes[0], default: []].insert(nodes[1])
        connections[nodes[1], default: []].insert(nodes[0])
    }

    var triangles: Set<Set<String>> = []

    for (node, neighbors) in connections {
        for neighbor in neighbors {
            let commonNeighbors = neighbors.intersection(connections[neighbor] ?? [])
            for common in commonNeighbors {
                let triangle: Set<String> = [node, neighbor, common]
                triangles.insert(triangle)
            }
        }
    }

    let filteredTriangles = triangles.filter { triangle in
        triangle.contains { $0.hasPrefix("t") }
    }

    return filteredTriangles.count
}

print("AoC Day 23a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
