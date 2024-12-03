export async function run(input, lines) {
    function multiply(data) {
        let match = data.match(/(\d{1,3})/g)
        return match.at(0) * match.at(1)
    }

    let sum = 0
    lines.forEach(line => {
        let match = line.match(/mul\(\d{1,3},\d{1,3}\)/g)
        match.forEach(data => {
            sum += multiply(data)
        })
    })
    return sum
}
