# Pollenstripper
 
This repository contains .scad and STL files as well as json presets for the bumblebee pollenstripper as described in Krüger et al

## Printing the Files

If you just want to print the files used in Krüger et al, you can go to the "STL_Files" directory and download all STL files that you want to print. Almost all files can be easily printed in PLA or PETG. If you want to use the pollen for DNA sequencing, we would recommend to use thermostable materials like ASA or ABS, to be able to clean the parts with boiling water. Almost all files can be printed without supports, with the exception of the funnel. The corpus minorly profits from supports but they are not a necessity.

# DIY Pollenstripper
## Getting Started
Do you have ideas to improve the Pollenstripper? Feel free to modify the design however you want. A lot of modifications can be done without any knowledge in 3D-Design. All you need are the files in this repository and the open source software [OpenSCAD](https://openscad.org/). It can be freely downloaded from the website. 

After installing OpenSCAD you can download this repository by clicking on "Code" and selecting "Download ZIP". After finishing the download you can unpack the directory to you prefered path.
Now you can chose which parts you want to modify. 

If you want to modify the corpus, the darkener or the funnel, you can open the corpus_designer.scad file with OpenSCAD. If you want to modify the filter inserts, you can open the filter_designer.scad file with OpenSCAD.
After opening the file you should see by default four different windows. On the Left the **Editor** shows you the code used to create the designs. On the bottom you can see the **Console**, which offers information about the rendering and if there were occuring errors. In the middle you can see the current preview of your 3D-Object. On the fourth panel on the right you can find the **Customizer**. If the Customizer is not open, you can open it by clicking on the **Window** menu and unselecting the **Hide customizer** option.
You can update the preview by pressing F5 and you can render the model with F6.

For further information about OpenSCAD, take a look at the [docs](https://openscad.org/documentation.html).  


## DIY Corpus, Darkener, Funnel & Brush-Corpus
If you want to modify the corpus, the darkener, the funnel or the brush-corpus you have two different options: either you use the customizer and play around with the options available without the need of any knowledge regarding 3D-design or programming or you can modify the code itself to create something completely custom. 
If you want to use the customizer, the variables are seperated into different tabs.

### Presets
If you don't want to create your designs from scratch, you can also use one of the available presets. You can find the presets at the top of the customizer. The preset *corpus* contains the settings for the corpus used in Krüger et al, while the preset *corpus with grid* has the same settings but with a grid at the bottom of the corpus. The *darkener* preset contains the settings for the darkener used in Krüger et al.

### Parameters
In the `Parameters` tab you can select which part you want to create or modify. 

### Acrylic Cube
In the `Acrylic Cube` tab you can select the dimensions of the acrylic cube that you are going to use. This is important for all designs since they are automaticallly modified to fit differently sized acrylic cubes.

### Darkener
The `Darkener` tab contains variables that are only relevant if you want to modify the darkener.

### Insert
In the `Insert` tab you have to enter the dimensions of the filter inserts that are created with the filter_designer.scad file. This is important for the corpus and brush-corpus designs so that the filter inserts fit into the slots.
You can also modify the positioning of the slot and the space between the filter insert and the corpus. 

### Corpus Basics
The `Corpus Basics` tab containts the variables that are used to create the corpus design. The first part of the corpus depends on the size of the acrylic cube and has to be modified in the corresponding tab. The second part of the corpus is made out of "tubes", which are basically small chambers which each contain a single slot for a filter insert. You can modify the dimensions of these tubes and the amount of tubes that are put behind each other to modify the amount of "chambers" the bumblebee has to cross.

### Grid Pattern
In earlier iterations, the corpus had a grid at the bottom where the pollen was supposed to fall through. In our testing this did not work as expected, which is why the grid was removed to decrease the amount of light that falls into the chambers to focus the bumblebees more into the direction of the exit. If you want you can create the grid in this tab and modify the dimensions and the amount of the squared holes in the corpus.

### Brush
We tested a version of the pollenstripper where brushes were mounted at an angle allowing the bumblebee to press itself through the middle between the brushes. This version did not succeed in any case, but if you want to modify it you can change the parameters at the `Brush` tab.

### Funnel
Earlier iterations had a grid where the pollen was supposed to fall through (see grid tab). Aterwards the pollen was supposed to fall into a funnel which could be slid onto the corpus with a thread for 2ml microcentrifuge tubes at the bottom. If you want to create or modify this funnel, you can find the needed variables at the `Funnel` tab.

### Misc
The `Misc` tab only contains the $fn variable which is used to define the number of fragments used to draw an arc. A higher value creates smoother arcs but also significantly increases the rendering time. If you just want to play around with the values i would recommend a lower $fn, for example 25, and to later increase it after you finished your model and create the rendering for the export of the file. My recommendation herefore would be a value of 100.


## DIY Filter Inserts
If you want to create or modify the filter inserts, you can either use the customizer and play around with the options available without the need of any knowledge regarding 3D-Design or programming or you can modify the code itself to create something completely custom
If you want to use the customizer, the variables here are also seperated into different tabs.

### Presets
If you don't want to create your designs from scratch, you can also use one of the available presets. You can find the presets at the top of the customizer. The preset *Preset a* contains the settings for the filter insert *a* as described in Krüger et al, while *Preset b* and *Preset c* are used for the other two described filter inserts. To recreate all filter inserts from the publication you can select the presets and just edit the diameter of the hole inside the `Base Plate` tab. 

### Base Plate
The `Base Plate` tab allows changes to the dimensions of the base plate, the bars on the base plate as well as the text on top of the base plate.

### Hole Structure
In the `Hole Structure` tab you select which one of the five possible designs you want to use.
You can choose if you want no structure ("None"), slides (used in version *a* in Krüger et al.), two different triangle structures ("triangle" and "triangle2", used in version *b* and *c*, respectively) (used in version c) or concentric (untested idea using concentric circles). 

### Hole Structure == Slides
If you chose the "slides" hole structure in the `Hole Structure` tab, you can edit the remainding variables in the `Hole Structure == Slides` tab. Here you can change the dimensions of the rings as well as the dimensions, offset and number of slides.

### Hole Structure == Triangle
If you chose the "triangle" hole structure in the `Hole Structure` tab, you can edit the remainding variables in the `Hole Structure == Triangle` tab. Here you can change the dimensions of the rings as well as the dimensions and number of triangles.

### Hole Structure == Triangle2
If you chose the "triangle2" hole structure in the `Hole Structure` tab, you can edit the remainding variables in the `Hole Structure == Triangle2` tab. Here you can change the dimensions of the rings as well as the dimensions and number of triangles.

### Hole Structure == Concentric
If you chose the "concentric" hole structure in the `Hole Structure` tab, you can edit the remainding variables in the `Hole Structure == Concentric` tab. Here you can change the dimensions and positioning of the concentric rings.

### Misc
The `Misc` tab only contains the $fn variable which is used to define the number of fragments used to draw an arc. A higher value creates smoother arcs but also significantly increases the rendering time. If you just want to play around with the values I would recommend a lower $fn, for example 25, and to later increase it after you finished your model and create the rendering for the export of the file. My recommendation therefore would be a value of 100.
