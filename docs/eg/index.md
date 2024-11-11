# Executor generator
## Installation
Here is described installation of executor generator app.

1.  Create top folder for your installation of Executor Generator
1.  Download to this folder installation script.[here.](installation/DeployReleaseNewestApp.ps1)
1.  Start in the folder powershell terminal and run script that install the newest version of executor generator. You will access the jag sharepoint file with security token to login. Log by your account and copy token to script.  

        PowerShell -ExecutionPolicy Bypass -File .\DeployReleaseNewestApp.ps1 

## Switch to older version

1.  Copy from path ```YourTopFolder\DeployedApp\Tools\Git``` file ```DeployReleaseApp.ps1``` to ```YourTopFolder```
1.  Start in the folder powershell terminal and run script. Select version of executor generator which you want to use. Type vX.X.X format to select version.  

        PowerShell -ExecutionPolicy Bypass -File .\DeployReleaseApp.ps1 

2.  After installation finish you can start selected version. 
2.  When app start do not automatically update app to newest version. 