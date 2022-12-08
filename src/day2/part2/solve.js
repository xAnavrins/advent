export async function run(input, lines) {
    const moves = {
        A: 0,
        B: 1,
        C: 2,
        X: 0,
        Y: 1,
        Z: 2
    }

    const scoring = {
        win: 6,
        draw: 3,
        lost: 0
    }

    let score = 0
    lines.forEach(match => {
        let [p1, p2] = match.split(/\s/)
        let [m1, m2] = [moves[p1], moves[p2]]

        score++
        switch (m2) {
            case 0:
                score += (m1 + 2) % 3 + scoring.lost
                break;
            case 1:
                score += m1 + scoring.draw
                break;
            case 2:
                score += (m1 + 1) % 3 + scoring.win
                break;
        }
    })

    return score
}
