export async function run(input, lines) {
    function multiply(data) {
        let match = data.match(/(\d{1,3})/g)
        return match.at(0) * match.at(1)
    }

    let sum = 0
    let multEn = true
    lines.forEach(line => {
        let match = line.match(/mul\((\d{1,3}),(\d{1,3})\)|don't\(\)|do\(\)/g)
        match.forEach(data => {
            if (data == "do()") { multEn = true }
            else if (data == "don't()") { multEn = false }
            else if (multEn) { sum += multiply(data) }
        })
    })
    return sum
}
