export async function run(input, lines) {
    let rules = {}
    let stage = 1
    let sum = 0
    lines.forEach(line => {
        if (line == "") {
            stage = 2
        } else if (stage == 1) {
            let match = line.match(/(\d{2})\|(\d{2})/)
            let [before, after] = [+match.at(1), +match.at(2)]
            if (!rules[after]) {
                rules[after] = new Map()
            }
            rules[after].set(before)

        } else if (stage == 2) {
            let update = line.split(",").map(i => +i)
            let good = 1 
            for (let i = 0; i < update.length-1; i++) {
                for (let j = i+1; j < update.length; j++) {
                    let [before, after] = [update[i], update[j]]
                    if (rules[before] && rules[before].has(after)) {
                        update[i] = after
                        update[j] = before
                        good = 0
                    }
                }
            }
            if (!good) {
                let middleIndex = Math.floor(update.length/2)
                let middleValue = update[middleIndex]
                sum += middleValue
            }
        }
    })

    return sum
}
