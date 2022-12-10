export async function run(input, lines) {
    let tree = {
        name: "/",
        isDir: true,
        children: []
    }
    let node = tree

    lines.forEach(line => {
        if (line.match(/^\$/)) {
            let { groups } = line.match(/^\$ (?<cmd>\w+) ?(?<arg>.*)$/)
            let { cmd, arg } = groups
            if (cmd == "cd") {
                if (arg == "..") node = node.parent
                else if (arg == "/") node = tree
                else node = node.children.find(folder => folder.isDir && folder.name === arg)
            }

        } else if (line.match(/^dir/)) {
            let { groups } = line.match(/^dir (?<dir>\w+)$/)
            let newNode = {
                name: groups.dir,
                isDir: true,
                children: [],
                parent: node
            }
            node.children.push(newNode)

        } else {
            let { groups } = line.match(/^(?<size>\d+) (?<name>[\w\.]+)$/)
            let newNode = {
                name: groups.name,
                isDir: false,
                size: Number(groups.size),
                parent: node
            }
            node.children.push(newNode)
        }

    })

    function getSizes(node, cb = () => { }) {
        if (!node.isDir) return node.size
        let dirSize = node.children.map(child => getSizes(child, cb)).reduce((acc, size) => acc + size, 0)
        cb(dirSize)

        return dirSize
    }

    let totalSize = 70_000_000
    let needSize = 30_000_000

    let usedSize = getSizes(tree)
    let availableSize = totalSize - usedSize
    let min = needSize - availableSize

    let candidates = []
    getSizes(tree, size => { if (size >= min) candidates.push(size) })

    return candidates.sort((a, b) => a - b)[0]
}
