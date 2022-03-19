# PIV
Matlab code for particle image velocimetry (PIV)

## The basics
This project is the code for the particle image velocimetry (PIV) lab for the Advanced Fluid Dynamics subject at the University of Melbourne.

PIV is a useful technique for measuring fluid flows which relies on taking a series of images of a flow seeded with tracer particles. Pairs of images
are processed using cross-correlation to determine displacements of small fluid parcels from one timestep to another. A full 2D map of the velocity of 
the flow field can be obtained and with sucessive images (e.g. a video), the evolution of the flow field can be inspected over time.  

The requirements of the lab submission necessitate some contorted code structure but in the interest of having a portable code library this has been 
worked around by having the required lab function names be simple wrappers of the 'real' code in the `+piv` package. The piv package can then be 
used as a standalone package in future projects.

## Using this project
To use this project you must have Matlab installed.

Download the project files, open the `PIV` folder in Matlab and add the folder and all subfolders to the Matlab path. This can be done by right-clicking
on the `PIV` folder in the directory tree and selecting Add to Path > Selected folders and subfolders.

### Generating PIV lab solutions
Before starting the PIV analysis, the video of the flow must be processed into individual image. To do this, place the .mov video file in the `data/in` folder
and run `videopreprocessing.m`. This script will process the video file into individual frames and save them in the `data/out' folder.

To generate the lab solutions, run `lab.m`. This script will process the images and generate plots as required by the lab handout.

### Using the PIV package
TODO
