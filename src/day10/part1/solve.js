export async function run(input, lines) {
    let regs = {
        x: 1,
    }
    let ops = {
        addx: { cycle: 2, exec: arg => regs.x += arg },
        noop: { cycle: 1, exec: () => { } }
    }

    let sampleCycle = [20, 60, 100, 140, 180, 220]
    let cycles = []
    lines.forEach(line => {
        let { groups } = line.match(/^(?<op>\w+) ?(?<arg>-?\d+)?$/)
        let currOp = ops[groups.op]
        for (let i = 0; i < currOp.cycle; i++) cycles.push(regs.x)
        currOp.exec(Number(groups.arg))
    })

    return sampleCycle.reduce(((acc, cycle) => acc += cycle * cycles[cycle - 1]), 0)
}
