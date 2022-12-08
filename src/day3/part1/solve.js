export async function run(input, lines) {
    function priority(letter) {
        if (letter.match(/[a-z]/)) return letter.charCodeAt() - "a".charCodeAt() + 1
        if (letter.match(/[A-Z]/)) return letter.charCodeAt() - "A".charCodeAt() + 27
    }

    let score = 0
    lines.forEach(line => {
        let len = line.length / 2
        let [first, second] = [new Set(line.slice(0, len)), new Set(line.slice(len))]
        for (let letter of first) {
            if (second.has(letter)) {
                score += priority(letter)
                break
            }
        }
    })
    return score
}
