# Title: PROJECT_1: ANT SURVIVAL: 7DAYS/ENDLESS 
## Written by: Maryna Sobol C00312784
## Date: 06.03.2026

## Project Overview
Ant Survival is a text-based game written in 68000 assembly for the EASy68K simulator. Players simulate the life of an ant colony, making daily decisions to gather food, rest, and survive against random events.
## Game Plot
A tiny ant out each day to gather food for its hungry colony. The world outside is full of dangers: storms and the occasional clumsy trip that could ruin a perfect haul.
The ant must decide: forage for tasty morsels or take a nap to recover strength. Too much greed, and it hurts itself; too little food, and the colony suffers.
With courage, luck, and a bit of mischief, the ant strives to survive and keep its colony fed — one crumb at a time!
## Game Modes
1.	7-Day Survival Mode – Survive for 7 days.
2.	Endless Mode – Survive indefinitely until death or starvation.

## Features
Resource Management
•	Maintain colony food levels (colony consumes 5 units/day).
Health Management
•	Ant has a health pool of 100 HP.
•	Actions and events affect HP; resting recovers it.
## Random Events
•	Storms: -20 HP, -10 food (20% probability)
•	Trips: Lose collected food (15% probability)
•	Queen’s Favor: Bonus food (10% probability)
## Player Choices
•	Forage: Gather up to 15 food units (over-greedy attempt triggers -50 HP, 0 food).
•	Rest: Recover 20 HP.
## Game Over Conditions
•	Ant’s HP reaches 0.
•	Colony food reaches 0.
## Victory Condition
•	Survive 7 days in 7-Day Mode.

## Installation / Running
1.	Open EASy68K simulator.
2.	Load PROJECT_1.ASM into the simulator.
3.	Assemble and run the program.
4.	Follow on-screen instructions to choose a game mode and perform daily actions.

## Game Flow
1.	Initialize colony resources, day counter, and ant HP.
2.	Display welcome message.
3.	Ask the player to choose a game mode (7-Day or Endless).
4.	Main Loop:
o	Display HUD: Day, Food, HP.
o	Prompt player to Forage or Rest.
o	Apply random events based on probability.
o	Update health and colony food.
o	Check victory or game over conditions.
o	Increment day and repeat.

## Random Number Generation
•	Uses a Linear Congruential Generator (LCG) to produce numbers 0–99 for event probability checks.

## Messages
The game includes several informative messages via EASy68K TRAP #15:
•	Welcome and prompts
•	Action outcomes (success/failure)
•	Event notifications
•	Game outcomes (victory/game over)

## Notes / Limitations
•	Maximum forage haul is 15 units; exceeding it triggers a greed penalty (-50 HP, 0 food).
•	Health is capped at 100.
•	Colony food cannot be negative.
•	Random event probabilities: Storm 20%, Trip 15%, Queen’s Favor 10%.


