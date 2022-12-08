export async function run(input, lines) {
    function priority(letter) {
        if (letter.match(/[a-z]/)) return letter.charCodeAt() - "a".charCodeAt() + 1
        if (letter.match(/[A-Z]/)) return letter.charCodeAt() - "A".charCodeAt() + 27
    }

    let score = 0
    let group = []
    lines.forEach(line => {
        group.push(new Set(line))
        if (group.length === 3) {
            group.sort((a, b) => a.size - b.size)
            let [first, second, third] = group
            for (let letter of first) {
                if (second.has(letter) && third.has(letter)) {
                    score += priority(letter)
                    break
                }
            }
            group = []
        }
    })
    return score
}
