# The CMOS Ring Oscillator

## 1. What Is a CMOS Ring Oscillator?

A CMOS ring oscillator is a circuit. It makes a signal that goes up and down. This action is called oscillation. The circuit does not need an input signal. It makes the oscillation by itself.

The circuit has an odd number of inverters. An inverter is a small circuit. It changes a high signal to a low signal. It also changes a low signal to a high signal.

The inverters connect in a loop. The output of the last inverter connects to the input of the first inverter. This is why the circuit is called a "ring."

You must use an odd number of inverters. Do not use an even number. An even number of inverters will not oscillate. Three inverters are the minimum number. Five or seven inverters are common choices.

### 1.1 How the Oscillation Starts

At the start, each inverter has a small delay. This delay is called the propagation delay. The propagation delay is the time between an input change and an output change.

The signal moves around the loop. Each inverter flips the signal and adds a small delay. After the signal passes through all inverters one time, the signal is flipped an odd number of times. This means the output signal has the opposite value from the start.

The signal keeps moving around the loop. It keeps flipping. This creates a continuous wave. The wave repeats at a fixed rate. This rate is the oscillation frequency.

### 1.2 The Oscillation Frequency

The frequency of the ring oscillator depends on two factors:

- The number of inverters in the ring.
- The propagation delay of each inverter.

You can calculate the frequency with this formula:

```
f = 1 / (2 x N x t_pd)
```

In this formula:

- `f` is the oscillation frequency.
- `N` is the number of inverters in the ring.
- `t_pd` is the propagation delay of one inverter.

The signal must travel around the ring two times to complete one full cycle. This is why the formula has the number 2.

## 2. What Is a CMOS Ring Oscillator For?

Engineers use ring oscillators for many purposes. This section lists the main uses.

### 2.1 Clock Generation

Digital chips need a clock signal. The clock signal controls the timing of operations. A ring oscillator can generate a simple clock signal on a chip. It does not need external parts.

### 2.2 Process Monitoring

Ring oscillators are sensitive to the manufacturing process. Small changes in the manufacturing process change the propagation delay of the inverters. Engineers put ring oscillators on test chips. They measure the frequency. The frequency tells them about the quality of the manufacturing process.

### 2.3 Voltage and Temperature Sensing

The propagation delay of an inverter changes with supply voltage and temperature. A higher supply voltage gives a shorter delay. A higher temperature gives a longer delay. Because of this, a ring oscillator can work as a simple sensor. Engineers can measure the frequency to estimate the voltage or the temperature on a chip.

### 2.4 Learning Tool

A ring oscillator is a good learning project. It uses only one type of circuit block, the inverter. But it teaches many important concepts. These concepts include propagation delay, transistor physics, and simulation methods.

## 3. What You Need Before You Start

You need the following items before you start this project:

- A computer with Linux. You can also use a virtual machine or a Docker container on Windows or macOS.
- A text editor. Any simple text editor is acceptable.
- An internet connection. You need this to download the tools.
- Basic knowledge of MOSFET transistors. You should know what a MOSFET is and how it switches on and off.

You will install these tools during the project:

- **Xschem**: This tool lets you draw circuit schematics.
- **ngspice**: This tool runs SPICE simulations. A SPICE simulation predicts how a circuit will behave.
- **Sky130 PDK**: This is a Process Design Kit. It contains the transistor models for the Sky130 manufacturing process. Sky130 is an open-source process from SkyWater Technology.

## 4. Step-by-Step Instructions

Follow these steps in order. Do not skip a step.

### Step 1: Install the Tools

You can install the tools one by one. You can also use a ready-made tool package. This guide describes the ready-made package method. It is faster and has fewer errors.

1. Open a terminal window on your computer.
2. Install Docker. Docker is a tool that runs software in a separate, controlled space called a container.
3. Download the IIC-OSIC-TOOLS container. This container includes Xschem, ngspice, and the Sky130 PDK together. Use this command:

   ```
   docker pull hpretl/iic-osic-tools
   ```

4. Start the container with this command:

   ```
   docker run -it hpretl/iic-osic-tools
   ```

5. Wait for the container to start. When it is ready, the terminal will show a new prompt.

### Step 2: Open Xschem and Create a New Project

1. In the container, type this command to start Xschem:

   ```
   xschem
   ```

2. The Xschem window will open. This window is your schematic canvas.
3. Click **File**, then click **New**. This action creates a new, empty schematic.
4. Save the new schematic. Click **File**, then click **Save As**. Name the file `inverter.sch`.

### Step 3: Build a Single CMOS Inverter

A CMOS inverter has two transistors. One transistor is a PMOS transistor. The other transistor is an NMOS transistor.

1. In Xschem, open the Sky130 device library. This library contains the standard transistor symbols.
2. Place one PMOS transistor on the canvas. Use the symbol named `sky130_fd_pr__pfet_01v8`.
3. Place one NMOS transistor below the PMOS transistor. Use the symbol named `sky130_fd_pr__nfet_01v8`.
4. Connect the drain of the PMOS transistor to the drain of the NMOS transistor. This connected point is the output node.
5. Connect the gate of the PMOS transistor to the gate of the NMOS transistor. This connected point is the input node.
6. Connect the source of the PMOS transistor to the supply voltage. The supply voltage is named `VDD`.
7. Connect the source of the NMOS transistor to ground. Ground is named `GND` or `VSS`.
8. Add an input voltage source. Connect it to the input node.
9. Add two labels for measurement: one label at the input node and one label at the output node.

### Step 4: Simulate the Inverter

You must check that your inverter switches correctly before you build the full ring oscillator.

1. In Xschem, add a simulation command block. Set it to run a DC sweep. A DC sweep changes the input voltage in small steps and records the output voltage at each step.
2. Set the sweep range from 0 volts to 1.8 volts. This range matches the Sky130 supply voltage.
3. Run the simulation. Click **Simulation**, then click **Netlist and Simulate**.
4. ngspice will open. It will show a plot. This plot is called the voltage transfer curve, or VTC.
5. Check the VTC. The output voltage must start near 1.8 volts, when the input is near 0 volts. The output voltage must fall near 0 volts, when the input is near 1.8 volts. This behavior confirms that the inverter works correctly.
6. Find the switching threshold on the plot. The switching threshold is the input voltage where the output voltage crosses half of the supply voltage. Write down this value. You will need it later.

### Step 5: Measure the Propagation Delay

1. Change the simulation command block. Set it to run a transient simulation. A transient simulation shows how signals change over time.
2. Set the input signal to a pulse. The pulse must change quickly from 0 volts to 1.8 volts, and back again.
3. Run the simulation.
4. On the output plot, find two points in time:
   - The time when the input signal crosses 50% of its final value.
   - The time when the output signal crosses 50% of its final value.
5. Calculate the difference between these two times. This difference is the propagation delay of your inverter.
6. Write down this value. You will need it in Step 7.

### Step 6: Build the Ring Oscillator

1. Open a new schematic in Xschem. Name it `ring_oscillator.sch`.
2. Copy your inverter symbol from Step 3. You need five copies for a 5-stage ring oscillator.
3. Place the five inverter copies in a row on the canvas.
4. Connect the output of inverter 1 to the input of inverter 2.
5. Connect the output of inverter 2 to the input of inverter 3.
6. Connect the output of inverter 3 to the input of inverter 4.
7. Connect the output of inverter 4 to the input of inverter 5.
8. Connect the output of inverter 5 back to the input of inverter 1. This connection closes the ring.
9. Connect the `VDD` and `GND` pins of all five inverters to the main supply and ground nets.
10. Add a voltage label on the output of one inverter. You will use this node to measure the frequency.

Note: A ring with an even number of inverters will not oscillate. Always use an odd number.

### Step 7: Simulate the Ring Oscillator

1. Add a transient simulation command block to the ring oscillator schematic.
2. Set the simulation stop time. Use a value about 20 times longer than your expected oscillation period. You can estimate the period with the formula from Section 1.2 and the propagation delay value from Step 5.
3. Run the simulation.
4. ngspice will show a plot of the output voltage over time. The plot must show a repeating wave. This wave confirms that the ring oscillator works.
5. Measure the time between two matching points on the wave, for example, two rising edges. This time is the oscillation period.
6. Calculate the frequency. Use this formula:

   ```
   f = 1 / period
   ```

7. Compare this measured frequency to your calculated estimate from Section 1.2. The two values should be close.

### Step 8: Run Corner and Sensitivity Analysis

Process, voltage, and temperature can change the performance of your ring oscillator. This step checks how sensitive your design is to these changes.

1. Open the simulation command block again.
2. Change the supply voltage in small steps, for example, from 1.6 volts to 2.0 volts. Run a new transient simulation at each voltage step.
3. Record the frequency at each voltage step.
4. Plot the frequency against the supply voltage. This plot shows the voltage sensitivity of your design.
5. Change the simulation temperature in small steps, for example, from -20°C to 80°C. Run a new transient simulation at each temperature step.
6. Record the frequency at each temperature step.
7. Plot the frequency against the temperature. This plot shows the temperature sensitivity of your design.
8. If the Sky130 PDK provides process corner files, run the simulation with the "slow" corner and the "fast" corner. Record the frequency for each corner. This step shows the manufacturing sensitivity of your design.

### Step 9: Document Your Work

1. Create a folder for your project.
2. Save all schematic files in this folder.
3. Save all simulation plots as image files.
4. Write a short report. Include these items in the report:
   - A description of the circuit.
   - The switching threshold from Step 4.
   - The propagation delay from Step 5.
   - The measured oscillation frequency from Step 7.
   - The plots from Step 8.
   - A comparison between your hand calculation and your simulation results.
5. Upload your project folder to a code hosting website, for example, GitHub.
6. Add a README file to the project. The README file must explain the project and show the main results.

## 5. Optional Next Step: Silicon Fabrication

You can submit your ring oscillator design for real chip fabrication. The Tiny Tapeout project offers this service. Tiny Tapeout accepts designs on a schedule called a shuttle. Each shuttle has a submission deadline.

To submit your design, you must convert your schematic into a physical layout. A physical layout is a file that describes the exact shape of each transistor and wire on the chip. Check the Tiny Tapeout website for the current tools and instructions for this conversion step.
