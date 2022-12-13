// POST https://adventofcode.com/2022/day/2/answer
// level=1&answer=14531

import path from "path/posix"
import fs from "fs/promises"
import fetch from "node-fetch"
import headers from "../aoc_headers.js"
import { JSDOM } from "jsdom"

let [,, cmd, day, part] = process.argv

function getPaths(day, part) {
    let paths = {}
    paths.dayPath = path.join("src", `day${day}`),
    paths.partPath = path.join(paths.dayPath, `part${part}`),
    paths.inputPath = path.join(paths.dayPath, "input.txt"),
    paths.solvePath = path.join(paths.partPath, "solve.js"),
    paths.resultPath = path.join(paths.partPath, "result.txt")
    return paths
}

let dayUrl = `https://adventofcode.com/2022/day/${day}`

if (cmd === "init") {
    let { dayPath, partPath, inputPath, solvePath } = getPaths(day, "1")
    let { partPath: partPath2, solvePath: solvePath2 } = getPaths(day, "2")

    await fs.mkdir(dayPath).then(_ => console.log("Day folder created")).catch(_ => console.log("Day folder already exists"))
    await fs.mkdir(partPath).then(_ => console.log("Part 1 folder created")).catch(_ => console.log("Part 1 folder already exists"))
    await fs.mkdir(partPath2).then(_ => console.log("Part 2 folder created")).catch(_ => console.log("Part 2 folder already exists"))
    fs.stat(solvePath)
    .then(_ => console.log("Part 1 solve file already exists"))
    .catch(_ => fs.copyFile("utils/template.js", solvePath).then(_ => console.log("Part 1 solve file created")))

    fs.stat(solvePath2)
    .then(_ => console.log("Part 2 solve file already exists"))
    .catch(_ => fs.copyFile("utils/template.js", solvePath2).then(_ => console.log("Part 2 solve file created")))

    console.log("Fetching your puzzle input...")
    let data = await fetch(dayUrl + "/input", {
        method: "GET",
        headers: headers
    })

    if (data?.ok) {
        let dlInput = await data.text()
        await fs.writeFile(inputPath, dlInput.replace(/\r?\n$/, "")).catch(_ => console.log("Input file already exists"))
        console.log("Fetched puzzle input!")

    } else if (!data?.ok) {
        console.log(await data.text())
    }
    
} else if (cmd === "solve") {
    let { solvePath, inputPath, resultPath } = getPaths(day, part)
    let { run } = await import(path.join("..", solvePath))
    let data = await fs.readFile(inputPath)
    let stringData = data.toString()
    console.time("Took")
    let result = await run(stringData, stringData.split(/\r?\n/))
    console.timeEnd("Took")
    console.log("Result: ", result)
    await fs.writeFile(resultPath, result?.toString() ?? "")

} else if (cmd === "submit") {
    let { resultPath } = getPaths(day, part)

    let fileData = await fs.readFile(resultPath)
    
    console.log("Submitting your answer...")
    let data = await fetch(dayUrl + "/answer", {
        method: "POST",
        headers: {...headers, 'Content-Type': 'application/x-www-form-urlencoded'},
        body: `level=${part}&answer=${encodeURIComponent(fileData)}`
    })
    let htmlData = await data.text()
    let dom = new JSDOM(htmlData)
    let p = dom.window.document.querySelector("main > article > p").textContent

    if (p.match(/answer is too low/)) {
        console.log("Answer is too low, wait 60s")
        
    } else if (p.match(/answer too recently/)) {
        let wait = p.match(/You have (.+) left to wait./)[1]
        console.log(`Answered too recently, wait ${wait}`);
        
    } else if (p.match(/answer is too high/)) {
        console.log("Answer is too high, wait 60s")
        
    } else if (p.match(/not the right answer/)) {
        console.log(`Answer is incorrect (${fileData})`);

    } else if (p.match(/That's the right answer/)) {
        console.log(`Answer is correct (${fileData})`);

    } else if (p.match(/Did you already complete/)) {
        console.log("This puzzle is already completed")

    } else if (p.match(/for someone else/)) {
        console.log(`Answer is correct... for someone else! (${fileData})`);

    }
}
