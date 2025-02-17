# Kicad 8.0 for use in WHS
## Overview
Used for projecting electronic devices like lights, camera equipments, IO-Link device module and etc.

## Installation Kicad

1.  Install Kicad on your system. Follow this [manual](https://docs.kicad.org/8.0/cs/kicad/kicad.html#installing_and_upgrading_kicad){:target="_blank"}
2.  Do not import previous settings.
3.  Very important is correctly set pathes. Create folder for libraries. You can choose path by your preferences eg. ```C:\WHS_Kicad_Libraries```.
4.  Create system variable. On windows go to cmdline as administrator and type  

        setx WHS_KICAD_LIBRARIES C:\WHS_Kicad_Libraries /M

## Installation Library loader
Used for automatic converting downloaded part to Kicad format.

1.   Install library loader from site [samacsys](https://www.samacsys.com/library-loader/){:target="_blank"}
2.   Create your own account on [https://componentsearchengine.com/](https://componentsearchengine.com/)
3.   Set download folder to scanning in library loader eg```C:\WHS_Kicad_Temp```.  When you have switched on library loader and download anything to this   folder library loader automatically add new part to temporary Kicad library located there. This library will not be joined to KICAD IDE. 
4.   Adjust settings of library loader profile. Click on profile
    
    <img src="LibraryLoaderMain.jpg" alt="Library loader settings" width="350">
    <img src="LibraryLoaderProfile.jpg" alt="Library loader settings" width="350">

5.  Adjust location for temporary library. 

    <img src="LibraryLoaderSettings.jpg" alt="Library loader settings" width="350">

## WHS Kicad library converter
Internal app to manage libraries in Kicad. Has these functions:

1.  Copy new part from temp library of Library Loader
2.  Copy new part from other libraries to whs structure
3.  Adds ERP property - user should fill. 
4.  Can add selected part to HELIOS. (is planned feature, not now) 
5.  Copy all files to correct whs library
6.  Sets all library links from WHS_Kicad_Libraries to KICAD.
7.  Pushes git to server also when export data to Helios
8.  During installation automatically download library from GIT to  ```C:\WHS_Kicad_Libraries```

Installation   

1.  The app is only plugin to use in Kicad. 
2.  Download release from GitHub (Sw is in production). The access can give you Martin Myslikovjan, Roman Tomášek or somebody from management.
3.  Adjust config.json file next the run file. And adjust the patches. 

            "watched_folder": "C:\\WHS_Kicad_Libraries"
            "symbol_lib_file": "C:\\Users\\rt\\AppData\\Roaming\\kicad\\\8.0\\sym-lib-table"
            "footprint_lib_file": "C:\\Users\\rt\\AppData\\Roaming\\kicad\\\8.0\\fp-lib-table"

## Debuging and developing
1.  Execute code from root by typing ```python src/main.py```       
2.  In VScode start test from test page.    
3.  Start test from terminal. ```python tests/test.py```    









 


 