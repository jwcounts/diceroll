# DiceRoll-Go
This is a simple dice rolling application I wrote to test my skills in the Swift programming langauge.

It can be used either staticly, or as an interactive shell.

To use is staticly, just call it in the command line and put the number of dice and type of dice as an argument:

```
> diceroll -d 3d8
7, 4, 8
Total: 19
```

If you call it without any arguments, it will go into an interactive shell:

```
> diceroll
>> Welcome to Dice Roller. This program lets you roll a bunch of dice at the same time.
>> What kind and how many (e.g. 2d6, 1d20, etc.). You can also type 'q' to quit, or 'h' for help.
3d8
7, 4, 8
Total: 19
```