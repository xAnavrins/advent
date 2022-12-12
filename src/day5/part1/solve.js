export async function run(input, lines) {
    function transfer(from, to, amt) {
        for (let i = 0; i < amt; i++) to.push(from.pop())
    }

    let stacksRegexp = /[\[\s]([\w\s])[\]\s]\s?/g
    let procRegexp = /move\s(\d+)\sfrom\s(\d+)\sto\s(\d+)/

    let stacks = []
    let stacksDone = false
    lines.forEach(line => {
        let i = 0

        if (!stacksDone && line.length == 0) {
            stacks.map(stack => stack.reverse())
            stacksDone = true

        } else if (!stacksDone) {
            let crate
            while (crate = stacksRegexp.exec(line)) {
                stacks[i] ??= []
                if (crate[1].match(/[A-Z]/)) stacks[i].push(crate[1])
                i++
            }

        } else {
            let [_, move, from, to] = procRegexp.exec(line)
            transfer(stacks[+from - 1], stacks[+to - 1], +move)

        }
    })
    return stacks.reduce((a, s) => a + s.pop(), "")
}
