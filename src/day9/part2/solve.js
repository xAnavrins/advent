export async function run(input, lines) {
    let dist = (a, b) => Math.sqrt(((a[0] - b[0])**2) + ((a[1] - b[1])**2))
    let clamp = (num, min, max) => Math.min(Math.max(num, min), max)

    let dirs = { U: [0,  1], R: [ 1, 0], D: [0, -1], L: [-1, 0] }

    let segments = 10
    let visited = new Set()
    let rope = []
    for (let i = 0; i < segments; i++) rope[i] = [0,0]
    lines.forEach(line => {
        let [, dir, steps] = line.match(/(\w) (\d+)/)
        let delta = dirs[dir]
        for (let i = 0; i < Number(steps); i++) {
            let seg = 0
            rope[seg][0] += delta[0]
            rope[seg][1] += delta[1]
            seg++

            for (; seg < rope.length; seg++) {
                if (dist(rope[seg-1], rope[seg]) > Math.SQRT2) {
                    rope[seg][0] += clamp(rope[seg-1][0] - rope[seg][0], -1, 1)
                    rope[seg][1] += clamp(rope[seg-1][1] - rope[seg][1], -1, 1)
                }
            }
            visited.add(rope[rope.length-1].toString())
        }
    })
    return visited.size
}
