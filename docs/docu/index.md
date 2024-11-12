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
 


## Repository to edit
Reached from website. Click on github icon.  
Main branch is source for md files.  
Every commit use CI/CD pipelines to automatic deploy webpage.  
[https://github.com/RT-whs/ExecutorGeneratorDocumentation](https://github.com/RT-whs/ExecutorGeneratorDocumentation)   

 