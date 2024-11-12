# Customer standard
## PLC 
Used for safety and singnal IO routing.

### Safety 
Usually is necessary create safety program. 
Connect robots from profisafe.
  
Moulding area is defined by Kuka robot safety position.  
Door service routine is also there, because when update kuka robot program they do not want to open door (caused by reload).

### Io linking
Link by their order so everything manually.
Name the io by previous project used numbering.
  
Create linking R1-R2, R1-R3, R2-R3
#### Robot robot interface
-  Workspace 1-8 between robots
-  Robot in home
-  Robot going to home
-  Last part
-  25 extra bits 

## Robot KUKA
Usually used 3 robots.
One R1 on mould machine and place conveyor.
Second R2 cut and oven, cannot catch part.
Third R3 is like holder. 

## Programming steps
- find on pdm specification
- Mould workspace axis specific
- use pulse source in sps
- safety zone is also source for signal e67_robot_outside_mould
- Robot outside mould ```O_CLOSE_SAFE = WS_SOURCE + SAFETY_ZONE_MERKER```
- SAFETY_ZONE_MERKER is accessible in Io mapping when mapp SafetyOutput to DigitalInputs
- Keep io numbers from previous project
- copy files from previous projects. Continue reading...
- adjust cell.src
- create basic production program prgXXX.src where XXX is mould/ program number
- keep safe transfer trajectories between each sub programs.



### $config.dat
- standard  
- axis limits  
- io
- io linking
- gripper
- aut ext
- core driving
- gas burner
- euromap 67 - robot has own extension E67 so not interlinked with plc
- park position for robot grippers (3 positions)

### Used workspaces
- fill from config.dat previous 

### Modules
- take whole folder R1/Modules and copy paste (use same numbering)  
- use in TP podprog.scr Helping for changing grippers
- copy zpravy.src
- copy whs.sps

### whs.sps
- need to add interfaces between robot
- others stay like now
- copy also system/sps.sub


### gripper spottech
They use.

### prgXXX.src
- set init
- set mould number
- check home pos - with dialog "Robot go to home directly"
- check empty gripper is not empty drop on conveyor part
- teach the points
- use switches -M_S_function_PAM
- comment all what really is not used
- switch M_EXECUTE_RETREATE is for homing
- TakeOffParts use motion step for possible homing. Copy all. Only teach up. Move ejector conducting or coreAction() to proper code position. 
### Deposit
Placing on conveyor.  
Can be adjusted this routine by merker. When you already down skip some points. Maybe remove when R3 will be used.

### Prog vymeny
Copy all from old to new robot. Check Tool holding positions.
Serizovaci rutinu dont use. 
Adjust prog vymeny_chapadel.src


### Troubleshooting
- Inside stop velocity changed from 0 -> 10 to be able move at mould with robot on old mould machine.
- PS_KUKA_EARLY_START uses intermediate position .. but usually not necessary


## Homing
Naming: Deposit  
Needs maintain motionstep valid.
Robots have to wait till other robot reach home. (R1 waits till R2 reach home)  
  
RetreatOutOfMould() - Homing from mould.  


## Project numbers
221057 - Magna Liberec robotizovane pracoviste 2 robots  
231080 - Magna Liberec robotizovane pracoviste 3 robots (1phase only R1)  



