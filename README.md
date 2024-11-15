# Mini_proyect_5_Processing

## Members
- Esteban Llanos
- Willian Chapid
  
## Objective:
The objective of this project is to develop a system that enables both visualization and auditory representation of data generated from a specific database, using the tools Pure Data and Processing.

## Problem Description
This project utilizes Pure Data and Processing to create a platform that captures and processes data, representing it visually and audibly. Pure Data is responsible for converting the data into sound formats, while Processing handles the graphic visualization. The goal is to synchronize both forms of representation so that data changes are simultaneously reflected in both sound and visuals, showcasing the evolution of data cohesively.

## Proposed Solution
To develop this system, the visualization was implemented in Processing, where a specific dataset is read and analyzed. After processing the data and performing the necessary calculations, signals are sent from Processing to Pure Data, allowing for the corresponding sound generation. This synchronization ensures that changes in data are translated both visually and audibly.

### In the data visualization, the following variables were used:

- **Danceability**: Mapped to an RGB color value to display on the ship.
- **Valence** and **Speechiness**: Combined to create a unique frequency for each song.
- **BPM**: Used to set the ship's speed and also controls the background color transition timing.
- **Energy**: Adjusts the volume in Pure Data.
  
Additionally, the frequency and volume variables are dynamically altered based on the ship’s `xPosition` and `yPosition`, respectively, across the screen’s quadrants, resulting in a unique sound for each position.

This approach ensures that both visual and auditory aspects respond interactively, enhancing the immersive experience of the data representation.

## Installation Guide for Processing and Pure Data with OSC Libraries  
This tutorial explains how to install Processing and Pure Data, along with the necessary libraries to work with OSC (Open Sound Control) in both programs.

#### Installing Processing and the oscP5 Library
1. **Download and Install Processing**  
   - Visit the official Processing website.  
   - Download the latest version for your operating system (Windows, macOS, or Linux).  
   - Follow the installation instructions for your operating system.

2. **Install the oscP5 Library**  
   - Open Processing.  
   - Go to **Tools** > **Manage Libraries**.  
   - In the search box, type `oscP5` and select the library that appears in the results.  
   - Click **Install** to add the oscP5 library to your Processing environment.  
   
   The oscP5 library allows you to send and receive OSC messages from Processing, which is useful for communication between audio and video applications.

#### Installing Pure Data and the osc Library
1. **Download and Install Pure Data**  
   - Visit the [Pure Data download page](https://puredata.info/downloads).  
   - Download version 0.55.1 (or another recommended version).  
   - Follow the installation instructions for your operating system.

2. **Install the osc Library in Pure Data**  
   - Open Pure Data.  
   - Go to **Help** > **Find Externals**.  
   - In the search bar, type `osc` and select the osc library from the results.  
   - Click **Install** to add the library to Pure Data.

#### Using the osc Library in Pure Data  
To use the osc library in Pure Data, you should write the function as follows in your patches:  
For example, to send a message using OSC, you can write `osc/send` in your Pure Data patch.

---

With these steps completed, you're ready to start working with OSC in both Processing and Pure Data!

## Conclusion  
In conclusion, the project successfully integrated knowledge acquired throughout the course, combining visualization and audio processing tools to create a coherent graphic and sound representation. The experience with Processing and Pure Data facilitated the creation of a meaningful audiovisual integration, capturing the essence of the project as a representative demonstration of the concepts learned in the course.
