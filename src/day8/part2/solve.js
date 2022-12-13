export async function run(input, lines) {
    let forest = []

    let i = 0
    lines.forEach(line => {
        forest[i] ??= []
        forest[i] = [...line].map(Number)
        i++
    })

    function checkLine(x, y, dx, dy, forest) {
        let visible = 0
        let max = forest[y][x]

        while (true) {
            x += dx
            y += dy
            if (y < 0 || y >= forest.length || x < 0 || x >= forest[y].length) break
            visible++
            if (forest[y][x] >= max) break
        }

        return visible
    }

    let max = 0
    for (let y = 0; y < forest.length; y++) {
        for (let x = 0; x < forest[y].length; x++) {
            let score  = checkLine(x, y, 0, -1, forest)
                score *= checkLine(x, y, 0,  1, forest)
                score *= checkLine(x, y, 1,  0, forest)
                score *= checkLine(x, y,-1,  0, forest)
            if (score > max) max = score
        }
    }

    return max
}
