export async function run(input, lines) {
    let gamesum = 0
    let limits = {"red": 12, "green": 13, "blue": 14}
    lines.forEach(line => {
        let [gameid, game] = line.split(":")
        let max = { "red": 0, "green": 0, "blue": 0 }
        game.split(";").map(pull => {
            pull.split(",").map(dices => {
                let [amt, color] = dices.trim().split(" ")
                max[color] = Math.max(amt, max[color])
            })
        })
        if (max["red"] > limits["red"] | max["green"] > limits["green"] | max["blue"] > limits["blue"]) return;
        gamesum += Number(gameid.split(" ")[1])
    })
    return gamesum
}
