use nom::bytes::complete::{tag, take_till, take_until, take_while};
use nom::character::complete::{space0, u32, u8};
use nom::combinator::{all_consuming, map};
use nom::error::dbg_dmp;
use nom::multi::fill;
use nom::sequence::{preceded, tuple};
use nom::Parser;

type IResult<'a, T> = nom::IResult<&'a str, T>;

fn main() {
    let input = std::fs::read_to_string("inputs/4.txt").unwrap();
    dbg!(solution1(&input));
    dbg!(solution2(&input));
}

fn solution1(input: &str) -> usize {
    input
        .lines()
        .map(parse_line)
        .map(|res| res.unwrap().1)
        .map(sol1_points)
        .sum()
}

fn solution2(input: &str) -> usize {
    let wins_per_card = input
        .lines()
        .map(parse_line)
        .map(|res| res.unwrap().1)
        .collect::<Vec<u8>>();

    let mut instances = vec![1; wins_per_card.len()];
    for idx in 0..instances.len() {
        let (current, rest) = instances[idx..].split_first_mut().unwrap();
        let wins = wins_per_card[idx] as usize;
        for next in &mut rest[..wins] {
            *next += *current;
        }
    }

    instances.iter().sum()
}

fn sol1_points(winning_count: u8) -> usize {
    if let Some(point_exp) = winning_count.checked_sub(1) {
        2usize.pow(point_exp as u32)
    } else {
        0
    }
}

fn parse_number(input: &str) -> IResult<u8> {
    match preceded(space0, u8)(input) {
        Ok(o) => Ok(o),
        Err(e) => {
            panic!("parsing: {input:?}");
            Err(e)
        }
    }
}

fn parse_numbers<const N: usize>(input: &str) -> IResult<[u8; N]> {
    let mut result = [0; N];
    let (input, ()) = fill(parse_number, &mut result)(input)?;
    Ok((input, result))
}

fn parse_line(input: &str) -> IResult<u8> {
    all_consuming(map(
        tuple((parse_numbers::<10>, tag(" | "), parse_numbers::<25>)),
        |(winners, _, owned)| winners.iter().filter(|num| owned.contains(*num)).count() as u8,
    ))(&input["Card   1: ".len()..])
}

#[test]
fn abc() {}
