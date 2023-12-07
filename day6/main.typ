#import "@preview/cmarker:0.1.0"
#import "@preview/fontawesome:0.1.0": fa-github

#let input = read("input.txt").split("\n")
#let length = input.at(0).matches(regex("\d+")).map(m => int(m.text))
#let distances = input.at(1).matches(regex("\d+")).map(m => int(m.text))
#let races = length.zip(distances)

#v(1fr)

#align(center, [
  #text(size: 24pt, smallcaps[❄ Advent of Code 2023 -- Day 5 ❄]) \
  #link("https://github.com/edgarogh")[#text(baseline: 0.09em, fa-github()) \@edgarogh]
])

#v(2fr)

#show outline.entry: it => {
  h(10pt * (it.level - 1))
  it
}

#outline()
#pagebreak()

#set par(justify: true)

#cmarker.render(read("aoc.md"))

= Solution 1

For this solution, I naïvely apply the algorithm given in the AoC prompt.

#let scores = {
  let scores = ()
  for (time, distance) in races {
    let score = 0
    for acceleration in range(1, time) {
      let remaining-time = time - acceleration
      if remaining-time * acceleration > distance {
        score += 1
      }
    }
    scores.push(score)
  }
  scores
}

#table(
  columns: 5,
  rows: 3,
  [*Race duration*], ..length.map(t => [#t ms]),
  [*Record distance*], ..distances.map(d => [#d mm]),
  [*Win possibilities*], ..scores.map(str),
)

#let sol1 = scores.fold(1, (a, b) => a * b)
$"s"_1 = #scores.at(0) times #scores.at(1) times #scores.at(2) times #scores.at(3) = sol1$

= Solution 2

#let length = int(input.at(0).replace(regex("[^\d]+"), ""))
#let distance = int(input.at(1).replace(regex("[^\d]+"), ""))

This time, the race duration $t_"max" = length "ms"$, and record distance $d = distance "mm"$. This is way longer than the numbers we crunched together in Solution 1, so we have to be smarter than that or Typst will just crash. The problem can be reformulated as looking for the size of the set ${ t in [0; t_"max"] | a times (t_"max" - t) > d }$. Let's continue:

$ 
  & \#{ t in [|0; t_"max"|] | t times (t_"max" - t) > d } \
= & \#{ t in [|0; t_"max"|] | (- t^2 + t t_"max" - d) > 0 } \
$

Hey look! That's a quadratic function of variable $t$, and we want to know in which interval it is greater than 0. Once we know this interval's bounds, it's trivial to compute its integer length. How do we know the interval's bounds? Using the good old quadratic root equation. Let's recall our coefficients:

$ a &=& -1 \ b &=& t_"max" &=&& length \ c &=& -d &=&& -distance $

Now, let's work out the roots:

#let quad0(a, b, c) = (-b - calc.sqrt(b*b - 4 * a * c)) / (2 * a)
#let quad1(a, b, c) = (-b + calc.sqrt(b*b - 4 * a * c)) / (2 * a)
#let root0 = quad0(-1, length, -distance)
#let root1 = quad1(-1, length, -distance)

#grid(
  columns: 4,
  column-gutter: 20%,
  v(0pt),
  $ r_0 =& (-b - sqrt(b^2 - 4 a c)) / (2 a) \ approx& #calc.round(root0, digits: 3) $,
  $ r_1 =& (-b + sqrt(b^2 - 4 a c)) / (2 a) \ approx& #calc.round(root1, digits: 3) $,
  v(0pt),
)

#let sol2 = calc.floor(calc.max(root0, root1)) - calc.ceil(calc.min(root0, root1)) + 1

The winning possibility count is the _integer_ length of this range, namely $"sol2" = floor(max(r_0, r_1)) - ceil(min(r_0, r_1)) + 1$ which gives us $s_2 = sol2$.

#table(
  columns: 2,
  rows: 3,
  [*Race duration*], [#length ms],
  [*Record distance*], [#distance mm],
  [*Win possibilities*], $s_2 = sol2$,
)
