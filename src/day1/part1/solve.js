export async function run(input, lines) {
    let res = 0
    lines.forEach(line => {
        let match = line
        .match(/(\d)/g)
        res += Number(`${match.at(0)}${match.at(-1)}`)
    })
    return res
}
