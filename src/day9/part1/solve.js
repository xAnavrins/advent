export async function run(input, lines) {
    let dist = (a, b) => Math.sqrt(((a[0] - b[0])**2) + ((a[1] - b[1])**2))

    let dirs = { U: [0,  1], R: [ 1, 0], D: [0, -1], L: [-1, 0] }

    let visited = new Set()
    let [head, tail] = [[0, 0], [0, 0]]
    lines.forEach(line => {
        let [, dir, steps] = line.match(/(\w) (\d+)/)
        let delta = dirs[dir]
        for (let i = 0; i < Number(steps); i++) {
            head[0] += delta[0]
            head[1] += delta[1]
            if (dist(head, tail) > Math.SQRT2) {
                tail[0] = head[0] - delta[0]
                tail[1] = head[1] - delta[1]
            }
            visited.add(tail.toString())
        }
    })
    return visited.size
}
