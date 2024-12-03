export async function run(input, lines) {
    let [leftList, rightList] = [[], []]
    lines.forEach(line => {
        let match = line.match(/^(\d+)\s+(\d+)$/)
        let leftNum = Number(match.at(1))
        let rightNum = Number(match.at(2))
        leftList.push(leftNum)
        rightList.push(rightNum)
    })
    leftList.sort()
    rightList.sort()

    let sum = 0
    for (let i in leftList) {
        sum += Math.abs(leftList[i] - rightList[i])
    }

    return sum
}
