export async function run(input, lines) {
    let elves = []
    let i = 0
    lines.forEach(line => {
        if (line.length > 0) {
            elves[i] = elves[i] ?? 0
            elves[i] += parseInt(line)
        } else {
            i++
        }
    })
    elves.sort((a, b) => b - a)

    return elves[0] + elves[1] + elves[2]
}
