export async function run(input, lines) {
    let res = 0
    lines.forEach(line => {
        let match = line
        .replaceAll("one", "o1ne")
        .replaceAll("two", "t2wo")
        .replaceAll("three", "t3hree")
        .replaceAll("four", "f4our")
        .replaceAll("five", "f5ive")
        .replaceAll("six", "s6ix")
        .replaceAll("seven", "s7even")
        .replaceAll("eight", "e8ight")
        .replaceAll("nine", "n9ine")
        .match(/(\d)/g)
        res += Number(`${match.at(0)}${match.at(-1)}`)
    })
    return res
}
