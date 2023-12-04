export async function run(input, lines) {
    let gamesum = 0
    lines.forEach(line => {
        let [, game] = line.split(":")
        let max = { "red": 0, "green": 0, "blue": 0 }
        game.split(";").map(pull => {
            pull.split(",").map(dices => {
                let [amt, color] = dices.trim().split(" ")
                max[color] = Math.max(amt, max[color])
            })
        })
        gamesum += max.red * max.green * max.blue
    })
    return gamesum
}
