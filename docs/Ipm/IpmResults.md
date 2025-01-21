### Description
The main idea of ipm results is we are using one general structure for moving results from Unit (robot, machine etc) to Ipm.
These results are stored in one generic form. So no programmer coding is necessary for adjusting the IPM core. The programmer only stores the data (the results) to the result structure. This structure allows in general store 10 results to the list.

### Base structures
Every Ipm Command data list should have this basic structure. So **Std_result** is defined by programmer to command in init section. Is defined datatype and register number. 

         
        Std                    : IpmDataListStdStruct
        Std_Result             : IpmDataListStdResultDefStruct                  
        FixedPart              : IPM_{UnitName}_{ActionName}_Cmd_Std_DataList   //IPM_Rob_Pick_Cmd_Std_DataList
        OptionalData           : IpmDataType{BasicDataType}Struct               //IpmDataTypeUdintStruct

When data comes from IPM during storing CommandStruct to UnitSlot also this Std_result is copied from init to **CommandStruct** in ..\Logical\Lib_csc\CSC\Ipm\IpmSlot.typ

        CommandStruct
                ...
                ...
                ...
                internal:CommandTcpInternalStruct

This internal variable contains address for dynamicaly created extension params (DataDescriptorDataLists is stored for later use). 
**ExtensionResults** is initialized by Std_Result in template function *inline  IPM_RETVAL IpmSlotBase::StoreData*.
By this we copy information about register number and datatype.
The definition is copied to working static structure IpmStdResultStruct. This is all the time statically reachable. So no dynamic alocation is necessary.
				
        CommandTcpInternalStruct			        	
                ExtensionParams     :CommandTcpInternalExtStruct	
                ExtensionResults	:IpmStdResultStruct	
                ResultRequestActive	:BOOL	                 	

**IpmStdResultStruct:** in ..\Logical\Lib_csc\CSC\Ipm\IpmDatatype.typ      

        IpmStdResultStruct           : STRUCT 
            DataListNbResultExpected : USINT;
            DataListResults          : ARRAY[0..9]OF IpmDataTypeResultStruct; (*Location for read out results from units*)
            RequestUnitData          : stTepRegister; (*For sequence which read outs results*)
            _indexDataListResults    : USINT := 0;
            _wstep                   : UINT := 0; (*For sequence which read outs results*)
        END_STRUCT;


**IpmDataTypeResultStruct** ..\Logical\Lib_csc\CSC\Ipm\IpmDatatype.typ This is a structure for storing every one result.

        IpmDataTypeResultStruct : 	STRUCT 
		    Value           : ARRAY[0..80]OF USINT; (*Value of var  IPM <-> UNIT   reinpreter cast of results values.The reciever knows which datatypes are needed*)
		    UnitRegisterNo  : UINT; (*Unit/Robot register index to store user variable 1000..65000*)
		    DataTypeCode    : USINT := 3;
		    StringLenght    : USINT; (*Used for Strings number of char used in result*)
	    END_STRUCT;

Data stored to the array of 81 unsigned integers. And every data array has defined data type code. This code describes in which types are data stored in array. When string is present also the string length is used. 

### UnitRegisterNo
In internal unit memory.
IPM expects the every unit will have own set of registers. This registers are internal memory of units.
The readout process address and read selected registers. Move this data throw the generic instance from unit to IPM. 

### Unit Steps
1. Unit store result during process to internal register.

### Cmd finish
After every cmd finished is called function LoadResultStruct() which basically set **ResultRequestActive** in internal substructure of IPM command.

### Tep steps to read outs              
1. ```ReadRegisterFromUnit()```  - function to read from unit to Tep (not for TepDataConventer, or generic Ipm_Fieldbus, or future RobotModuleV2) ***no programmer change***
2. ```FuResult_Generic()```  - In IPM Tep instance (in generic TEP not for TepDataConventer) ***no programmer change***
3. ```ReadoutResult()```  - Cyclical service calling FuResult_Generic (in generic TEP not for TepDataConventer). Checking if **ResultRequestActive** is setted by cmd 101. If yes call readout till finish. ***no programmer change***
4. Data are prepared for IPM in **ExtensionResults** of current cmd.

### Tep Data converter read out
1. In Unit_IpmTepConverter.st we use CommandResult.st where is written logic by programmer to readout values from unit. 

### Steps to handle Cmd101 Readout results from IPM
1. ```Deserialize()```
2. ```IPM_RETVAL GetCmdResults()``` Create answer to IPM. Take data from **Internal\ExtensionResults** of selected command.
The data creating is generic. No programmer effort needed.
3. ```CreateOneItemResultAnswer()``` Function adding to result stream results one by one. Should be called from loop.



### Open points
-       Unit tests.

###Adam points
