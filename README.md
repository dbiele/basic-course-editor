## Basic Course Editor  ##

**Course Editor** allows course owners to change course content without authoring tools or an IDE.

The course editor is used to modify:

- General Data
- Feedback Window
- Glossary Data 
- Reference Data
- Scene Data
	- Lesson Title
	- Audio File
	- Caption Text
	- Caption Timing


### Built using Flash ###

The idea was to create an easy to use interface to modify a courses XML file. The editor runs as an exe, loads a courses XML file, and outputs new xml. 

To build the course, you'll need:

- Adobe Flash
- Flash Develop

### Understanding the folder structure ###

The **CREATIVE** folder contains any images edited in Photoshop.  These images are then imported into Flash.  

The **FLASH** folder contains all Flash and AS3 code. Use this folder to build the course editor.exe

The **INSTRUCTIONS** folder contains a word document with documentation on how to run the course editor.

### How to view code ###
Any AS3 IDE will be able to view the code, but I included a Flash Develop file to make it easy.  Simply open "New Balance Course Editor.as3proj" in Flash Develop to start reviewing code.

The course editor uses MVCS pattern for implementing the user interface. 

### Instructions ###

The content.xml in the bin folder contains a sample courses xml file.  Use this file to test the course editor.

More detailed information can be found in "New Balance Editing Course.docx"