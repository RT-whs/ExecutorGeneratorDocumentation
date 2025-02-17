# Alarm sending from PLC to IPM

## Description
The main idea of the alarm reader is that we use one general structure for collecting alarms in different language versions and sending them to an HTTP server. These alarms are stored in a unified format, eliminating the need for custom programming to adjust the core functionality.

## Implemetation
### **1. Configuration View**
- Add the configuration file **.mpAlarmXHistory** to the project.
- Ensure the number of elements in this configuration matches the **maximum number of languages** used in the program variables.
    <img src="Ipm/AlarmSynConfView.png" alt="Configuration View">
- The settings for all elements should be the same as shown in the image below
    <img src="Ipm/AlarmSynConfViewSettings.png" alt="Configuration View">

### **2. Logical view**


## Test tools

## Testing

## Source code
Complete source code for download:
[AlarmMessenger](./Ipm/AlarmMessenger.zip)