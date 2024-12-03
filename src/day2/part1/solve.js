export async function run(input, lines) {
    let sum = 0

    function analyze(data) {
        let dir = (data.at(1) - data.at(0))/Math.abs((data.at(1) - data.at(0)))
        let first = Number(data.shift())
        let isSafe = 0
        while (true) {
            let second = Number(data.shift())
            if (!second) break;

            if ((dir > 0 && first < second && Math.abs(first-second) < 4) || (dir < 0 && first > second && Math.abs(first-second) < 4)) {
                isSafe = 1
                first = second
            } else {
                isSafe = 0
                break
            }
        }
        return isSafe
    }

    lines.forEach(line => {
        let match = line.match(/(\d+)/g)
        sum += analyze(match)
    })

    return sum
}
