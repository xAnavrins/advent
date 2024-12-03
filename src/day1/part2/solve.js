export async function run(input, lines) {
    let [leftList, rightList] = [[], []]
    lines.forEach(line => {
        let match = line.match(/^(\d+)\s+(\d+)$/)
        let leftNum = Number(match.at(1))
        let rightNum = Number(match.at(2))
        leftList.push(leftNum)
        rightList.push(rightNum)
    })

    let sum = 0
    for (let leftVal of leftList) {
        sum += leftVal * rightList.filter(rightVal => rightVal == leftVal).length
    }

    return sum
}
