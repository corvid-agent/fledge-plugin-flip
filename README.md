# fledge-plugin-flip

Quick random decisions: coin flips, dice rolls, random picks, number ranges, and yes/no answers.

## Install

```bash
fledge plugins install corvid-agent/fledge-plugin-flip
```

## Usage

```bash
fledge flip <command> [args]
```

## Commands

| Command | Description |
|---------|-------------|
| `coin [--count N]` | Flip a coin (default when no command given). Multiple flips show a tally. |
| `dice [--sides N] [--count N]` | Roll dice (default: d6). Multiple rolls show each result and the total. |
| `pick <ITEM1> <ITEM2> [ITEM3...]` | Pick a random item from a list |
| `number <MIN> <MAX>` | Generate a random number in an inclusive range |
| `yn` | Random yes or no answer |

## Examples

```bash
fledge flip coin
fledge flip coin --count 10
fledge flip dice --sides 20
fledge flip dice --sides 6 --count 4
fledge flip pick pizza tacos sushi burgers
fledge flip number 1 100
fledge flip yn
```

## License

MIT
