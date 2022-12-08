export async function run(input, lines) {
    let matchSize = 14
    function hasRepeats(s) {
        let r = Array.from(s)
        let b = 0
        for (let i = 0; i < s.length; i++) {
            let t = r.pop()
            b |= r.indexOf(t) + 1
        }
        return b !== 0
    }
    let i
    for (i = matchSize; i < input.length; i++)
        if (!hasRepeats(input.substring(i - matchSize, i))) break

    return i
}
