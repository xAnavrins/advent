export async function run(input, lines) {
    let forest = []

    let i = 0
    lines.forEach(line => {
        forest[i] ??= []
        forest[i] = [...line].map(Number)
        i++
    })

    function checkLine(x, y, dx, dy, forest, visible) {
        visible.add(`${x}-${y}`)
        let max = forest[y][x]

        while (true) {
            x += dx
            y += dy
            if (y < 0 || y >= forest.length || x < 0 || x >= forest[y].length) break
            if (forest[y][x] > max) {
                max = forest[y][x]
                visible.add(`${x}-${y}`)
            }
        }
    }

    let visible = new Set()
    for (let x = 0; x < forest[0].length; x++) {
        checkLine(x, 0, 0, 1, forest, visible)
        checkLine(x, forest.length - 1, 0, -1, forest, visible)
    }
    for (let y = 0; y < forest.length; y++) {
        checkLine(0, y, 1, 0, forest, visible)
        checkLine(forest[0].length - 1, y, -1, 0, forest, visible)
    }

    return visible.size
}
