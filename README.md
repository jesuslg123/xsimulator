
# XSimulator

XSimulator is a coding challenge written in Ruby that simulate the deploy of 1 to N rovers into an area of Mars.

## The project

This simulator has been structured in 5 main pieces.

- Inputs
- Map
- Rover
- Simulator
- Main app

### Input

The input has the ability to load and process all the required information from a file. The responsibilities are:

- Load the file
- Validate the information
- Process and save it into a structured type

*Related files:* 
- *lib/xsimulator/input/input.rb*
- *lib/xsimulator/input/input_rover.rb*
- *lib/xsimulator/input/input_validor.rb*

### Map

Map is a simple entity which contains the limits of the are and the positions of all the rovers deployed in the same to avoid collisions. It can:

- Validate if a coordinate is available.
- Track the position of the rovers deployed.

*Related files:* 
- *lib/xsimulator/map.rb*

### Rover

The rover has ability to move and turn.

In order to turn it use a compass property which can easily calculate which is the next orientation after turning left or right.

To move it use the compass reference to calculate in which axis the movement has to happen and validate it against the map before proceed.

In case of a rover tries to make an invalid movement, the rover will stop and notify the last valid position.

*Related files:* 
- *lib/xsimulator/rover.rb*

### Simulator

Simulator is the class in charge of coordinating the input, the map and the rovers. It's expect the path for the input file.

Simulator will make use of the input to generate the required information to make possible generate a map and deploy the rovers.

*Related files:* 
- *lib/xsimulator.rb*

### Main app

The main app is our entry point and it is a way to use the simulator class inside a ruby script, it basically read the input path file from the console command arguments and instantiate the simulator with it.

*Related files:* 
- *app.rb*

## Getting Started

### Prerequisites

As the software is develop in Ruby, you will need to have Ruby 2.6+ installed in your machine. [Ruby install guide](https://www.ruby-lang.org/en/documentation/installation)

### Installing

As the project is written in ruby it will first require you to install all the dependencies.

    bundle install

Once all the dependencies are installed, you are ready to go.

## Execute

### Input 

The app need a text input file containing all the information relative to the deploy in the area and the rovers start position and actions to execute. 

The input file must contains information about the area, the top right area X and Y coordinates as bottom left are considered 0,0 by default, and the rover information. It can contain 1 or N rovers to be deployed. Each rover must contains the initial position, X and Y coordinates plus the initial letter for the orientation (E, N, W or S), and the list of actions to execute, L = Left, R = Right or M = Move.

Sample

```
5 5                     // Top right area coordinates
  
1 2 N                   // Rover initial position
  
L M L M L M L M M       // Rover actions
  
3 3 E                   // Rover initial position
  
M M R M M R M R R M     // Rover actions
```

You can find some sample input files located at the `input` folder.


### Run

To run the simulator you just need to execute the main app of the project, the  `app.rb` file, and pass as argument the path for the input information file. You can create your own inputs files or use one of the provided on the `inputs` folder

Example 
`ruby app.rb inputs/valid.txt`

#### Output

```
Initializing...             // App is starting
Sequence completed: true    // Rover one actions completion result
Position: 1,3 N             // Rover one last position
Sequence completed: true    // Rover two actions completion result
Position: 5,1 E             // Rover two last position
```

## Running the tests

This project tests has been done using **RSpec** framework. Just execute:

    rspec

## Author

**Jesús López García**