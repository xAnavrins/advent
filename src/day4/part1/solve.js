export async function run(input, lines) {
    let grid = []
    lines.forEach(line => {
        let match = line.match(/./g)
        grid.push(match)
    })

    function seek(grid, cx, cy, dir, word) {
        for (let letter of word) {
            cx += dir[0]
            cy += dir[1]
            if (!grid[cy] || !grid[cy][cx]?.match(letter)) {
                return 0
            }
        }
        return 1
    }

    function findDirection(grid, cx, cy, letter) {
        let dirs = []
        for (let dy = -1; dy <= 1; dy++) {
            for (let dx = -1; dx <= 1; dx++) {
                if (grid[cy+dy] && (grid[cy+dy][cx+dx] == letter)) {
                    dirs.push([dx, dy])
                }
            }
        }
        return dirs
    }

    function find(grid, word) {
        let sum = 0
        for (let cy = 0; cy < grid.length; cy++) {
            for (let cx = 0; cx < grid[cy].length; cx++) {
                if (grid[cy][cx] == word.at(0)) {
                    let dirs = findDirection(grid, cx, cy, word.at(1))
                    for (let dir of dirs) {
                        let cword = [...word]
                        cword.shift()
                        sum += seek(grid, cx, cy, dir, cword)
                    }
                }
            }
        }
        return sum
    }

    return find(grid, [..."XMAS"])
}
