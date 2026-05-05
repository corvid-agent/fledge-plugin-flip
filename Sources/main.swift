import Foundation

// MARK: - Random Helpers

var rng = SystemRandomNumberGenerator()

func coinFlip() -> String {
    Bool.random(using: &rng) ? "Heads" : "Tails"
}

func diceRoll(sides: Int) -> Int {
    Int.random(in: 1...max(1, sides), using: &rng)
}

func randomNumber(min: Int, max: Int) -> Int {
    Int.random(in: min...max, using: &rng)
}

func yesOrNo() -> String {
    Bool.random(using: &rng) ? "Yes" : "No"
}

// MARK: - Argument Parsing Helpers

func parseIntFlag(_ args: [String], flag: String, defaultValue: Int) -> Int {
    guard let idx = args.firstIndex(of: flag), idx + 1 < args.count,
          let value = Int(args[idx + 1]) else {
        return defaultValue
    }
    return value
}

func stripFlags(_ args: [String], flags: [String]) -> [String] {
    var result: [String] = []
    var skip = false
    for (i, arg) in args.enumerated() {
        if skip {
            skip = false
            continue
        }
        if flags.contains(arg), i + 1 < args.count {
            skip = true
            continue
        }
        result.append(arg)
    }
    return result
}

// MARK: - Commands

func runCoin(args: [String]) {
    let count = parseIntFlag(args, flag: "--count", defaultValue: 1)
    guard count > 0 else {
        print("Error: count must be at least 1")
        return
    }

    if count == 1 {
        let result = coinFlip()
        print("🪙 \(result)!")
    } else {
        var heads = 0
        var tails = 0
        for _ in 1...count {
            let result = coinFlip()
            if result == "Heads" { heads += 1 } else { tails += 1 }
        }
        print("🪙 Flipped \(count) coins:")
        print("   Heads: \(heads)")
        print("   Tails: \(tails)")
    }
}

func runDice(args: [String]) {
    let sides = parseIntFlag(args, flag: "--sides", defaultValue: 6)
    let count = parseIntFlag(args, flag: "--count", defaultValue: 1)

    guard sides > 0 else {
        print("Error: sides must be at least 1")
        return
    }
    guard count > 0 else {
        print("Error: count must be at least 1")
        return
    }

    if count == 1 {
        let result = diceRoll(sides: sides)
        print("🎲 Rolled a d\(sides): \(result)")
    } else {
        var total = 0
        var rolls: [Int] = []
        for _ in 1...count {
            let result = diceRoll(sides: sides)
            rolls.append(result)
            total += result
        }
        let rollStrings = rolls.map { String($0) }.joined(separator: ", ")
        print("🎲 Rolled \(count)d\(sides): [\(rollStrings)]")
        print("   Total: \(total)")
    }
}

func runPick(args: [String]) {
    guard !args.isEmpty else {
        print("Error: need at least two items to pick from")
        print("Usage: fledge flip pick <ITEM1> <ITEM2> [ITEM3...]")
        return
    }
    guard args.count >= 2 else {
        print("Error: need at least two items to pick from")
        print("Usage: fledge flip pick <ITEM1> <ITEM2> [ITEM3...]")
        return
    }

    let picked = args.randomElement()!
    print("👆 Picked: \(picked)")
}

func runNumber(args: [String]) {
    guard args.count >= 2,
          let minVal = Int(args[0]),
          let maxVal = Int(args[1]) else {
        print("Error: need two integer arguments <MIN> <MAX>")
        print("Usage: fledge flip number <MIN> <MAX>")
        return
    }

    let lo = min(minVal, maxVal)
    let hi = max(minVal, maxVal)

    let result = randomNumber(min: lo, max: hi)
    print("🔢 Random number (\(lo)–\(hi)): \(result)")
}

func runYesNo() {
    let result = yesOrNo()
    let emoji = result == "Yes" ? "👍" : "👎"
    print("\(emoji) \(result)")
}

func printHelp() {
    print("""
    fledge flip — Quick random decisions

    COMMANDS:
      coin              Flip a coin — heads or tails
                        --count N    Flip multiple coins (shows tally)

      dice              Roll dice (default: d6)
                        --sides N    Number of sides (default: 6)
                        --count N    Roll multiple dice (shows each + total)

      pick <items...>   Pick a random item from the list

      number <MIN> <MAX>  Generate a random number in range (inclusive)

      yn                Random yes or no

    OPTIONS:
      --help, -h        Show this help message

    EXAMPLES:
      fledge flip coin
      fledge flip coin --count 10
      fledge flip dice --sides 20
      fledge flip dice --sides 6 --count 4
      fledge flip pick pizza tacos sushi burgers
      fledge flip number 1 100
      fledge flip yn
    """)
}

// MARK: - Main

let args = Array(CommandLine.arguments.dropFirst()) // drop executable name

if args.contains("--help") || args.contains("-h") {
    printHelp()
} else if args.isEmpty || args.first == "coin" {
    let subArgs = args.isEmpty ? [] : Array(args.dropFirst())
    runCoin(args: subArgs)
} else if args.first == "dice" {
    runDice(args: Array(args.dropFirst()))
} else if args.first == "pick" {
    runPick(args: Array(args.dropFirst()))
} else if args.first == "number" {
    runNumber(args: Array(args.dropFirst()))
} else if args.first == "yn" {
    runYesNo()
} else {
    print("Unknown command: \(args.first ?? "")")
    print("Run with --help for usage information.")
}
