export async function run(input, lines) {
    let monkeys = []
    let rounds = 20
    let cm;
    lines.forEach(line => {
        let match
        if (match = line.match(/Monkey (\d+):/)) {
            cm = Number(match[1])
            monkeys[cm] = {count: 0}
        } else if (match = line.match(/Starting items: (.+)/)) {
            monkeys[cm].items = match[1].split(", ").map(Number)
        } else if (match = line.match(/Operation: new = old (.) (.+)/)) {
            let [, op, num] = match
            monkeys[cm].op = {op, num: Number(num) || num}
        } else if (match = line.match(/Test: divisible by (\d+)/)) {
            monkeys[cm].test = {div: Number(match[1])}
        } else if (match = line.match(/If true: throw to monkey (\d+)/)) {
            monkeys[cm].test = {...monkeys[cm].test, ifTrue: Number(match[1])}
        } else if (match = line.match(/If false: throw to monkey (\d+)/)) {
            monkeys[cm].test = {...monkeys[cm].test, ifFalse: Number(match[1])}
        }
    })

    for (let round = 0; round < rounds; round++) {
        for (let curr = 0; curr < monkeys.length; curr++) {
            let monkey = monkeys[curr]
            for (let worry of monkey.items) {
                if (monkey.op.op == "+")
                    worry += monkey.op.num == "old" ? worry : monkey.op.num
                else if (monkey.op.op == "*")
                    worry *= monkey.op.num == "old" ? worry : monkey.op.num

                worry = Math.floor(worry/3)
                monkeys[curr].count++
                if (worry % monkey.test.div == 0)
                    monkeys[monkey.test.ifTrue].items.push(worry)
                else
                    monkeys[monkey.test.ifFalse].items.push(worry)
            }
            monkey.items = []
        }
    }

    monkeys.sort((a, b) => b.count - a.count)
    return monkeys[0].count * monkeys[1].count
}
