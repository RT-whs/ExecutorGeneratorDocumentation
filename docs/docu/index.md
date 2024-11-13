# How to use this documentation
## Online using
Simply open this link for Whs online documentation  
[https://rt-whs.github.io/ExecutorGeneratorDocumentation/](https://rt-whs.github.io/ExecutorGeneratorDocumentation/)

## Offline installation
Follow this guide to install this documentation on your machine.  
<!--[Whs offline installation of documentation ](instalation/localInstall.md) -->
1.  Download script installation script from [here.](installation/InstallDocumentation.ps1)
2.  Locate file to folder where you want download all this documentation offline.
3.  Open in this folder powershell terminal
4.  Install by this cmd. When python missing will be automatically installed.  
 
        
        PowerShell -ExecutionPolicy Bypass -File .\InstallDocumentation.ps1 
        


5. Download script for start and show this documentation [here.](installation\ShowDocumentationWeb.ps1) and locate to same folder.
Script is used for manual start of documentation. This step do Executor generator itself so with connection with app is not needed.
   

        PowerShell -ExecutionPolicy Bypass -File .\ShowDocumentationWeb.ps1
 


## Source documentation repository
Reached from website. Click on github icon.  
Main branch contains md files.
Gh-pages branch contains deployed website.  
Every commit use CI/CD pipelines to automatic deploy webpage.  
[https://github.com/RT-whs/ExecutorGeneratorDocumentation](https://github.com/RT-whs/ExecutorGeneratorDocumentation){:target="_blank"}  

## Editing locally
The system MkDocs is based on python. This documentation is based on material design.  
Follow this steps.  

1.  Install VSCode. (Is recommended due very good work with folder tree)
1.  Install Python. You can use this [link](https://www.python.org/downloads/){:target="_blank"}. Check the possibility "Add Python to PATH" to publish python to cmd line.
1. Check the Python in shell cmd line by cmd ```python --version```
1. Upgrade pip installer when you have python longer by 

        python -m pip install --upgrade pip

1. Create your folder for documentation


1. Reach in terminal to this folder and create python virtual environment. 

        python -m venv venv        
    !!! tip "Hint"
        With Windows 11 in file explorer you can use right mouse click and use "Open in Terminal" in current folder. The path will be taken from current folder.

1. Activate environment by script. Type in shell cmd line.  
   If you will use VS code than you have to **activate virtual environment also for his terminal.** So simply call this cmd also from there.

        ./venv/Sripts/activate

1. Install MkDocs material.  Type in shell cmd line 

        pip install mkdocs-material

1. Install plugin for mkdocs glighbox.
        
        pip install mkdocs-glightbox

1. Install plugin for mkdocs for navigation. 
        
        pip install mkdocs-awesome-pages-plugin

1. Clone source code of docu next to venv folder. 
       
        git clone https://github.com/RT-whs/ExecutorGeneratorDocumentation project
1. In VS code you can open project by File -> Open Folder (open project folder)
1. Possibly in VS code you can go to Terminal -> New Terminal
1. Try the documentation web locally. Got to project folder (you can use also VS code terminal). Type cmd ```mkdocs build```
1. Type cmd ```mkdocs serve```
1. Click with ctrl on link in terminal log e.g. ```http://127.0.0.1:8000/```
1. You can make a change each ctrl+s will update web
1. When you close app or terminal you close also local web server.

### Publish to webserver
Simply commit your change to git. The web will be automatically updated within one minute.


## Getting started 
How to work with material design guide:  
[How to edit this project](https://squidfunk.github.io/mkdocs-material/){:target="_blank"}  

 