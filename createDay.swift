import Foundation

let year = Date().formatted(.dateTime.year())
let day =
    CommandLine.arguments.count > 1
    ? CommandLine.arguments[1] : Date().formatted(.dateTime.day(.twoDigits))

let fm = FileManager.default
let currentPath = fm.currentDirectoryPath

let yearDir = currentPath + "/\(year)"
if !fm.fileExists(atPath: yearDir) {
    try fm.createDirectory(atPath: yearDir, withIntermediateDirectories: true)
    print("Year \(year) created.")
}

let dayDir = yearDir + "/solutions/\(day)"
if !fm.fileExists(atPath: dayDir) {
    try fm.createDirectory(atPath: dayDir, withIntermediateDirectories: true)

    let templatePath = currentPath + "/template.swift"
    let destinationPath = dayDir + "/\(day)a.swift"
    try fm.copyItem(atPath: templatePath, toPath: destinationPath)

    let testInputPath = dayDir + "/testInput.txt"
    try "".write(toFile: testInputPath, atomically: true, encoding: .utf8)

    let puzzleInputPath = dayDir + "/puzzleInput.txt"
    try "".write(toFile: puzzleInputPath, atomically: true, encoding: .utf8)

    print("Day \(day) created.")
} else {
    print("Day \(day) already exists.")
}

print("Good luck!")
