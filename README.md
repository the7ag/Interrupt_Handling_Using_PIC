# Interrupt Handling Lap with PIC16F877A
This project implements an interrupt handling system using the PIC16F877A microcontroller. The lap consists of three main tasks: a temperature-controlled fan, a simple irrigation system, and a garage security system. Each task utilizes different drivers and interrupts to perform specific functions.

## Task 1: Temperature Controlled Fan
The temperature controlled fan is designed to activate when the temperature reaches 50°C or higher. It utilizes interrupts to monitor the temperature and control the fan accordingly. The fan remains ON until the temperature drops below 50°C. Additionally, the elapsed time since the fan was last turned on is displayed on an LCD screen.

## Drivers Used
* GPIO (General Purpose Input/Output)
* LCD (Liquid Crystal Display)
* External Interrupts
* Timer Interrupts
## Simulation Video

https://github.com/the7ag/Interrupt_Handling_Using_PIC/assets/95578914/4bef9c83-1319-44a3-847c-824329b5a374


## Task 2: Simple Irrigation System
The simple irrigation system waters plants at regular intervals. It irrigates the plants for 15 seconds every 3 days. A 7-segment display is used to indicate the time since the last irrigation. The system employs timer interrupts and external interrupts for its operation.

## Drivers Used
* GPIO (General Purpose Input/Output)
* Timer Interrupts
* External Interrupts

## Simulation Video


https://github.com/the7ag/Interrupt_Handling_Using_PIC/assets/95578914/583b347d-ed4b-4898-956a-26b64d39e1f4


## Task 3: Garage Security System
The garage security system is implemented using hardware components and utilizes a password for protection. If the correct password is entered, the system activates a motor to simulate the opening of the garage door. The elapsed time is displayed on an LCD screen while the motor is running.

## Drivers Used
* GPIO (General Purpose Input/Output)
* Keypad
* LCD (Liquid Crystal Display)
* Timer Interrupts
## Simulation Video


https://github.com/the7ag/Interrupt_Handling_Using_PIC/assets/95578914/d1ed890e-89df-4bce-add1-a2e7781d2fa9


## Hardware Requirements
* PIC16F877A microcontroller
* Temperature sensor (for Task 1)
* Fan (for Task 1)
* 7-segment display (for Task 2)
* Motor (for Task 3)
* Keypad (for Task 3)
* LCD screen (for all tasks)
## Software Requirements
* MPLAB X IDE
* PIC C Compiler
## Usage
1. Connect the hardware components according to the circuit diagrams provided.
2. Set up the necessary software environment using MPLAB X IDE and PIC C Compiler.
3. Compile and flash the code onto the PIC16F877A microcontroller.
4. Run the system and observe the desired functionalities.
5. Follow the instructions on the LCD screen or keypad (for Task 3) to interact with the system.
6. Please refer to the individual source code files for detailed implementation and configuration information for each task.

## Contributing
Contributions to this project are welcome. If you have any improvements or new features to suggest, please submit a pull request.

## License
This project is licensed under the MIT License. Feel free to use, modify, and distribute the code as per the terms of the license.

## Acknowledgements
This project was developed based on the PIC16F877A datasheet and various online resources. We would like to express our gratitude to the contributors and authors of those resources for their valuable insights and knowledge.

For any questions or concerns, please contact the7ag@gmail.com
