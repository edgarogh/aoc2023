# Day 1-1: [Shenzhen I/O](https://www.zachtronics.com/shenzhen-io/)

> _SHENZHEN I/O: BUILD CIRCUITS. WRITE CODE. RTFM._

Shenzhen I/O is an amazing video game by the amazing [Zachtronics](https://www.zachtronics.com/) of whom I might be a fan ❤️❤️❤️.

This solution was implemented using the Custom Specs Editor, which allows me to create a custom circuit specification (with my AoC input as an XBus input) and implement it.

## Screenshot

![shenzhen io aoc.png](shenzhen%20io%20aoc.png)
_The comments try to explain what's going on._

## Running

  * [Buy Shenzhen I/O](https://store.steampowered.com/app/504210/SHENZHEN_IO/) ([and all other Zachtronics puzzle games](https://store.steampowered.com/bundle/2925/The_Zachtronics_Puzzle_Pack/) because they're so fun and 1000% worth their price)
  * Locate your game data directory. On my Linux, its at `/home/$USER/.local/share/SHENZHEN IO/$STEAM_ACCOUNT_ID>`
  * Download [`c871428257787118.lua`](c871428257787118.lua) (the circuit specification) to `./custom_puzzles/`
    * Edit the `aoc_input` variable to your own input. Be careful to include a final newline as the circuit relies on `\n` to detect line endings.
  * Download [`new-specification-c871428257787118-0.txt`](new-specification-c871428257787118-0.txt) (the solution) to `./` besides other puzzle solutions
  * Run the game, the spec and circuit should be there
