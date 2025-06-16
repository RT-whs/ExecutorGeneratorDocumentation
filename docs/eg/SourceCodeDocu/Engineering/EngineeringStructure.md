# Executor generator engineering

## Project structure
<pre>
```
ProjectName/
├── Project
│   ├── Controllers
│   │   └── plc
│   ├── Devices
│   │   ├── Cameras
│   │   └── Robots
│   ├── Docu
│   ├── Engineering
│   └── Hmi
└── Resources
    ├── Dockers
    ├── Libraries
    ├── DeviceDescriptionFiles
    ├── Pictures
    └── Tools
```
</pre>
Our projects usually consist from many devices and many sw projects. To keep it well organized we want use tree structure which we will pack to plc like one project. Thanks this we can keep same versions of plcs, robots etc in one project. To pdm folder roboters you can share some note about version in this package. This structure will use also executor generator for work with every project.

### Controllers
If you have many plc in splitted projects you can create here more folders for every plc one.
### Devices 
Every device which has own project or settings should be actual here. 
### Docu
For devices especially some rare used store here their manuals.
Eplan IO export
### Engineering
Folder for executor generator project
### Hmi
When separate Hmi used. Also can be foldered to many separated devices.
### Resources
Everything needed for project bud not essentials part of that.  
