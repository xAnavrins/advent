export async function run(input, lines) {
    let regs = {
        x: 1,
    }
    let ops = {
        addx: { cycle: 2, exec: arg => regs.x += arg },
        noop: { cycle: 1, exec: () => { } }
    }

    let cycles = []
    lines.forEach(line => {
        let { groups } = line.match(/^(?<op>\w+) ?(?<arg>-?\d+)?$/)
        let { op, arg } = groups
        let currOp = ops[op]
        for (let i = 0; i < currOp.cycle; i++) cycles.push(regs.x)
        currOp.exec(Number(arg))
    })

    let crt = []
    let cycle = 0
    let vpos = 0
    while (cycle < cycles.length) {
        let spriteDist = Math.abs(cycles[cycle] - (cycle % 40))
        if (!crt[vpos]) crt[vpos] = []
        crt[vpos].push(spriteDist < 2)
        cycle++
        if (cycle % 40 == 0) vpos++
    }
    return crt.map(hline => hline.map(pixel => pixel ? "█" : " ").join("")).join("\n")
}
