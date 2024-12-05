export async function run(input, lines) {
    let grid = []
    lines.forEach(line => {
        let match = line.match(/./g)
        grid.push(match)
    })

    let sum = 0
    for (let cy = 0; cy < grid.length; cy++) {
        for (let cx = 0; cx < grid[cy].length; cx++) {
            if (grid[cy][cx] == "A") {
                let good = true
                let ms = 0
                let ss = 0
                for (let [dx, dy] of [[-1, -1], [1, 1]]) {
                    let cletter = grid[cy+dy] && grid[cy+dy][cx+dx]
                    
                    if (cletter == "M") { ms += 1 }
                    if (cletter == "S") { ss += 1 }
                }
                if (!(ms == 1 && ss == 1)) { good = false }

                for (let [dx, dy] of [[-1, 1], [1, -1]]) {
                    let cletter = grid[cy+dy] && grid[cy+dy][cx+dx]
                    
                    if (cletter == "M") { ms += 1 }
                    if (cletter == "S") { ss += 1 }
                }
                if (!(ms == 2 && ss == 2)) { good = false }
                sum += good ? 1 : 0
            }
        }
    }
    return sum
}
