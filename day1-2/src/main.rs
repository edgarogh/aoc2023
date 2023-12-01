fn main() {
    let input = std::fs::read_to_string("inputs/1.txt").unwrap();
    dbg!(solution(&input));
}

fn solution(input: &str) -> u32 {
    input
        .lines()
        .map(pair)
        .map(|[dec, unit]| dec * 10 + unit)
        .sum::<u32>()
}

fn pair(line: &str) -> [u32; 2] {
    let mut digits = (0..line.len()).map(|s| &line[s..]).filter_map(digit);

    match (digits.next(), digits.last()) {
        (Some(dec), Some(unit)) => [dec, unit],
        (Some(dec_unit), None) => [dec_unit, dec_unit],
        _ => unreachable!("missing digit in line {line}"),
    }
}

fn digit(s: &str) -> Option<u32> {
    if let Some(digit) = s.chars().next().and_then(|c| c.to_digit(10)) {
        Some(digit)
    } else {
        match s {
            _ if s.starts_with("one") => Some(1),
            _ if s.starts_with("two") => Some(2),
            _ if s.starts_with("three") => Some(3),
            _ if s.starts_with("four") => Some(4),
            _ if s.starts_with("five") => Some(5),
            _ if s.starts_with("six") => Some(6),
            _ if s.starts_with("seven") => Some(7),
            _ if s.starts_with("eight") => Some(8),
            _ if s.starts_with("nine") => Some(9),
            _ => None,
        }
    }
}
