export async function run(input, lines) {
    let score = 0
    lines.forEach(line => {
        let [, a1, a2, b1, b2] = line.match(/^(\d+)-(\d+),(\d+)-(\d+)$/)
        a1 = parseInt(a1); a2 = parseInt(a2); b1 = parseInt(b1); b2 = parseInt(b2)
        if (!((a2 < b1 && a1 < b1) || (b2 < a1 && b1 < a1))) score++
    })
    return score
}
