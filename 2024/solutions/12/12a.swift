import Foundation

let testInput: [String] = [
    "RRRRIICCFF",
    "RRRRIICCCF",
    "VVRRRCCFFF",
    "VVRCCCJFFF",
    "VVVVCJJCFE",
    "VVIVCCJJEE",
    "VVIIICJJEE",
    "MIIIIIJJEE",
    "MIIISIJEEE",
    "MMMISSJEEE",
]
let testSolution: Int = 1930

let textFile: String = try String(contentsOfFile: "./puzzleInput.txt", encoding: .utf8)
let puzzleInput: [String] = textFile.components(separatedBy: "\n")

struct Point: Hashable {
    let x: Int
    let y: Int
}

struct Region {
    let type: String
    var area: Int = 0
    var perimeter: Int = 0
}

func solvePuzzle(input: [String]) -> Int {
    var visited: Set<Point> = Set<Point>()

    let map = input.map { $0.map { String($0) } }

    func calculateRegion(startX: Int, startY: Int, type: String) -> Region {
        var pointsToFollow = [Point(x: startX, y: startY)]
        var region = Region(type: type)
        visited.insert(Point(x: startX, y: startY))

        while pointsToFollow.count > 0 {
            let point = pointsToFollow.removeFirst()
            region.area += 1

            let x = point.x
            let y = point.y

            if x > 0 {
                let neighborType = map[x - 1][y]
                let neighbor = Point(x: x - 1, y: y)
                if neighborType == type {
                    if !visited.contains(neighbor) {
                        visited.insert(neighbor)
                        pointsToFollow.append(neighbor)
                    }
                } else {
                    region.perimeter += 1
                }
            } else {
                region.perimeter += 1
            }

            if x < map.count - 1 {
                let neighborType = map[x + 1][y]
                let neighbor = Point(x: x + 1, y: y)
                if neighborType == type {
                    if !visited.contains(neighbor) {
                        visited.insert(neighbor)
                        pointsToFollow.append(neighbor)
                    }
                } else {
                    region.perimeter += 1
                }
            } else {
                region.perimeter += 1
            }

            if y > 0 {
                let neighborType = map[x][y - 1]
                let neighbor = Point(x: x, y: y - 1)
                if neighborType == type {
                    if !visited.contains(neighbor) {
                        visited.insert(neighbor)
                        pointsToFollow.append(neighbor)
                    }
                } else {
                    region.perimeter += 1
                }
            } else {
                region.perimeter += 1
            }

            if y < map[0].count - 1 {
                let neighborType = map[x][y + 1]
                let neighbor = Point(x: x, y: y + 1)
                if neighborType == type {
                    if !visited.contains(neighbor) {
                        visited.insert(neighbor)
                        pointsToFollow.append(neighbor)
                    }
                } else {
                    region.perimeter += 1
                }
            } else {
                region.perimeter += 1
            }
        }

        return region
    }

    var totalPrice: Int = 0

    for x in 0..<map.count {
        for y in 0..<map[x].count {
            let point = Point(x: x, y: y)
            if !visited.contains(point) {
                let type = map[x][y]
                let region = calculateRegion(startX: x, startY: y, type: type)
                totalPrice += region.area * region.perimeter
            }
        }
    }

    return totalPrice
}

print("AoC Day 12a")
let testPassing: Bool = testSolution == solvePuzzle(input: testInput)
print("Test passing? \(testPassing)")
if testPassing {
    print("Solution: \(solvePuzzle(input: puzzleInput))")
}
