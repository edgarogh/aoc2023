const input = await Deno.readTextFile("inputs/5.txt");

const seeds = input.match(/seeds: ((?:\s*\d+)*)/)[1].split(' ').map(i => parseInt(i));

function solution(seeds) {
    let intermediate = seeds;
    for (const mapsRgx = /.* map:\n([\d \n]+)/g;;) {
        const mapSource = mapsRgx.exec(input);
        if (!mapSource) break;
        const mapNumbers = mapSource[1].split(/\s+/).filter(s => s.length).map(i => parseInt(i));
        if (mapNumbers.length === 0) break;

        const maps = mapNumbers
            .map((item, index) => index % 3 === 0 ? mapNumbers.slice(index, index + 3) : null)
            .filter(a => a)
            .map(([toS, fromS, len]) => ({ toS, fromS, len }));

        intermediate = intermediate.map(prev => {
            for (const { toS, fromS, len } of maps) {
                if (prev >= fromS && prev < (fromS + len)) {
                    return toS + prev - fromS;
                }
            }
            return prev;
        })
    }

    return intermediate.reduce((a, b) => Math.min(a, b), Infinity);
}

console.log(solution(seeds));
