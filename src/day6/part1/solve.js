export async function run(input, lines) {
    let map = []
    let [cx, cy] = [-1, -1]
    let dirs = [[0, -1], [1, 0], [0, 1], [-1, 0]]
    let cdir = 0


    lines.forEach(line => {
        let match = line.match(/./g)
        let i = line.indexOf("^")
        if (i > 0) {
            cx = i
            cy = map.length
        }
        map.push(match)
    })

    let uniqTiles = 0
    while (true) {
        let curTile = map[cy][cx]
        if (curTile != "X") {
            map[cy][cx] = "X"
            uniqTiles += 1
        }

        let nextTile = map[cy+dirs[cdir][1]] && map[cy+dirs[cdir][1]][cx+dirs[cdir][0]]
        if (nextTile === undefined) {
            break
        } else if (nextTile != "#") {
            cx += dirs[cdir][0]
            cy += dirs[cdir][1]
        } else {
            cdir += 1
            cdir %= dirs.length
        }
    }

    return uniqTiles
}
