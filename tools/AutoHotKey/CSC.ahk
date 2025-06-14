; * ------------------------------------------------------------------------- */
; *                                                                           */
; *    Filename      :   TiaPortal.ahk                            	          */
; *    Project       :   Whs tia portal   				                      */
; *    Date          :   29.03.2024                                           */
; *    Date change   :   18.06.2024                                           */
; *    Version       :   V1.1                                                 */
; *                                                                           */
; * ------------------------------------------------------------------------- */
; *                                                                           */
; *    Short description                                                      */
; *    - AutoHotKey script template with hotkeys and hotstrings               */
; *      for efficient coding with Nexeed Automation Control plus             */
; *                                                                           */
; * ------------------------------------------------------------------------- */
; *                                                                           */
; *    Version history                                                        */

; *                                                                           */
; * ------------------------------------------------------------------------- */

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; ; =============================================================================
; ; Translation of clipboard, default: Firefox tab, DeepL.com, DE-EN (CTRL+ALT+T)
; ; This hotkey is commented out. Remove the semikolons to use it.
; ; When using translators keep in mind that sensitive texts may not be copied to cloud translators.
; ; =============================================================================
;  
;  ^!t::    
;  { 
;    Send ^c
;    Run, firefox.exe -new-tab https://www.deepl.com/translator#de/en/"%clipboard%"
;  }
;  ::EndOfScript::^!t



; =============================================================================
; Macros/hotstrings for PLC editors (WHS Plc TiaPortal)
; =============================================================================
#If WinActive("ahk_exe Siemens.Automation.Portal.exe") 
{
; ------------------------------------------------------------------------------
; Pragmas
; ------------------------------------------------------------------------------

  

; ------------------------------------------------------------------------------
; IEC 61131 and coding directives
; ------------------------------------------------------------------------------

  ; --------------------
  ; For Loop            
  ; --------------------
  ::fo::
  {
    Send {Esc}                                                   ; close auto complete popup
    clipboard := "FOR _idx := 1 TO X`r`nDO`r`n  `r`nEND_FOR`r`n" ; set clipboard text
    Send ^v                                                      ; paste from clipboard (CTRL+V)
  }
  ::EndOfScript::fo
  
  ; --------------------
  ; Increment Step      
  ; --------------------
  ::sp++::
  {
    Send {Esc}                             ; close auto complete popup
    clipboard := "_step := _step + 1;`r`n" ; set clipboard text
    Send ^v                                ; paste from clipboard (CTRL+V)
  }
  ::EndOfScript::sp++
  
  ; --------------------
  ; Case Step Of           
  ; --------------------
  ::cso::
  {
    Send {Esc}
    clipboard := "CASE _step`r`nOF`r`n  0:`r`n    // comment`r`n    `r`n    _step := _step + 1;`r`n    `r`n  99:`r`n    // comment`r`n    `r`n    IF( FinishCondition )`r`n    THEN`r`n      _step := 0;`r`n    END_IF`r`n    `r`n  ELSE`r`n    SetExtEvent(OpconEventClass.SOFTERROR, EVENT_INVALID_CASE, CONCAT('_step=', DINT_TO_STRING(_step)), Station.Unit.ObjectID, Lock := FALSE);`r`nEND_CASE`r`n" 
    Send ^v
  }
  ::EndOfScript::cso

  

;  ; -------------------------
;  ; Executor generator info              
;  ; -------------------------
;  ::egi::
;  {
;   ; Send {Esc}                                                                             ; close auto complete popup
;    InputBox, userInput, Enter Text, Please enter the text to fill the Step, , 280, 150
;    InputBox, userInput2, Enter Text, Please enter the text to fill the Detail, , 280, 150
;    if ErrorLevel
;    MsgBox, You canceled or closed the InputBox.
;    else
;    
;    clipboard := "<EG Step=""" . userInput . """ Info="" "" Detail=""" . userInput2 . """ />`r`n"                ; set clipboard text
;    Send ^v                                                                                ; paste from clipboard (CTRL+V)
;    return
;    
;  }
;  ::EndOfScript::egi	

; -------------------------
  ; Executor generator info              
  ; -------------------------
  ::egi::
  ::egid::
  ::egic::
  ::egif::
  {
   ; Send {Esc}                                                                             ; close auto complete popup
   
    ; Determine language from trigger text
    triggerLang := SubStr(A_ThisHotkey, 6)
    if (triggerLang = "d")
        defaultLang := "de-DE"
    else if (triggerLang = "c")
        defaultLang := "cs-CZ"
    else if (triggerLang = "f")
        defaultLang := "fr-FR"
    else 
        defaultLang := "en-US"
 
     Gui, Add, Text, , Write State:
     Gui, Add, Edit, vUserInputState w280 Limit Number, ; Default text here, if needed
     
     Gui, Add, Text, , Write Info (when empty state nr. will be used):
	Gui, Add, Edit, vUserInputInfo2 w280, ; Default text here, if needed

     Gui, Add, Text, , Write Detail:
	Gui, Add, Edit, vUserInputDetail w280, ; Default text here, if needed

     Gui, Add, Text, , SelectLang:
	Gui, Add, ComboBox, vVariableSelectionLangInfo, de-DE||cs-CZ||en-US||fr-FR
    GuiControl,Choose, VariableSelectionLangInfo, %defaultLang% ; Set default value for ComboBox
	Gui, Add, Button, gButtonOK3, OK
	Gui, Show, , Info with lang

	; Wait for user input
	return

ButtonOK3:
    GuiControlGet, variableSelectionLangInfo,, VariableSelectionLangInfo
    GuiControlGet, userInputDetail,, UserInputDetail
    GuiControlGet, userInputState,, UserInputState
     GuiControlGet, userInputInfo2,, UserInputInfo2
  ; Close the GUI window

    Gui, Destroy

    clipboard := "<EG Step=""" . userInputState . """ Info=""" . userInputInfo2 . """ Detail=""" . userInputDetail . """ Lang=""" . variableSelectionLangInfo . """ />`r`n"                ; set clipboard text
    Send ^v                                                                                ; paste from clipboard (CTRL+V)
return


    
  }
  ::EndOfScript::egil	
  
  

	
  ; -------------------------
  ; Executor generator info               
  ; -------------------------
 ; ::egii::
 ; {
 ;  ; Send {Esc}                                                                             ; close auto complete popup
 ;   InputBox, userInput, Enter Text, Please enter the text to fill the Step, , 280, 150
 ;   InputBox, userInfo, Enter Text, Please enter the text to fill the Info, , 280, 150
 ;   InputBox, userInput2, Enter Text, Please enter the text to fill the Detail, , 280, 150
 ;   if ErrorLevel
 ;   MsgBox, You canceled or closed the InputBox.
 ;   else
 ;   
 ;   clipboard := "<EG Step=""" . userInput . """ Info=""" . userInfo . """ Detail=""" . userInput2 . """ />`r`n"                ; set clipboard text
 ;   Send ^v                                                                                ; paste from clipboard (CTRL+V)
 ;   return
 ;   
 ; }
 ; ::EndOfScript::egii	

  ; -------------------------
  ; Executor generator mode               
  ; -------------------------
	
::egm::
  {
    ;Send {Esc}                                                                             ; close auto complete popup
	; Create the GUI window
    Gui, Add, Text, , Select a mode and lang:
	Gui, Add, ComboBox, vVariableSelectionMode, PRODUCTION|MANUAL|HOME|MAINTENANCE|CHANGEOVER
	
	Gui, Add, Button, gButtonOK1, OK
	Gui, Show, , Select mode

  ; Wait for user input
	return

	; Button OK click handler
ButtonOK1:
    Gui, Submit, NoHide
    ; Get the selected value from the combobox
    GuiControlGet, selectedValue,, VariableSelectionMode
    GuiControlGet, selectedValueLang,, VariableSelectionLang
    
    ; Close the GUI window
    
    Gui, Destroy

    
    clipboard := "<EG Mode=""" . selectedValue . """  Descr=""Changing mode for next infos"" />`r`n"                ; set clipboard text
    Send ^v                                                                                ; paste from clipboard (CTRL+V)
return

    GuiClose:
    GuiEscape:
     Gui, Destroy
     return
    
  }
  ::EndOfScript::egm
  
  


  ; -------------------------
  ; Executor generator state             
  ; -------------------------
	
 ::egs::
  {
    ;Send {Esc}                                                                             ; close auto complete popup
	; Create the GUI window
    Gui, Add, Text, , Select a state:
	Gui, Add, ComboBox, vVariableSelectionState, STOPPED|STOPPING|RESETTING|IDLE|STARTING|EXECUTE|COMPLETED|COMPLETING|ABORTING|ABORTED|CLEARING|HOLDING|HELD|UNHOLDING|SUSPENDING|SUSPENDED|UNSUSPENDING|ACTIVATING|DEACTIVATED|DEACTIVATING
	Gui, Add, Button, gButtonOK2, OK
	Gui, Show, , Select state

  ; Wait for user input
	return

	; Button OK click handler
ButtonOK2:
    Gui, Submit, NoHide
    ; Get the selected value from the combobox
    GuiControlGet, selectedValueState,, VariableSelectionState
    
    
    ; Close the GUI window
    GuiClose2:
    GuiEscape2:
    Gui, Destroy

    
    clipboard := "<EG State=""" . selectedValueState . """  Descr=""Changing state for next infos"" />`r`n"                ; set clipboard text
    Send ^v                                                                                ; paste from clipboard (CTRL+V)
return
    
  }
  ::EndOfScript::egs	
  
  
  
  
  ; --------------------------------------------------------------
  ; Executor generator event category event number, event category             
  ; ---------------------------------------------------------------
  ::ege::
 
  {
   ; Send {Esc}                                                                             ; close auto complete popup
   
    ; Determine language from trigger text
    
 
     Gui, Add, Text, , Write Category:
     Gui, Add, Edit, vUserInputCat w280 Limit Number, ; Default text here, if needed
     
     Gui, Add, Text, , Write EventID (when empty state nr. will be used):
	Gui, Add, Edit, vUserInputID w280, ; Default text here, if needed



     
	Gui, Add, Button, gButtonOK4, OK
	Gui, Show, , Set new Event

	; Wait for user input
	return

ButtonOK4:
   
    GuiControlGet, userInputCat,, UserInputCat
    GuiControlGet, userInputID,, UserInputID
    
  ; Close the GUI window

    Gui, Destroy

    clipboard := "<EG_Event  Category=""" . userInputCat . """ EventID=""" . userInputID . """  />`r`n"                ; set clipboard text
    Send ^v                                                                                ; paste from clipboard (CTRL+V)
return


    
  }
  ::EndOfScript::egil	
  
  }
  
; --------------------
  ; ######################################  Automation studio ####################################      
  ; -------------------- 
  
#If WinActive("ahk_exe pg.exe")
{
; ------------------------------------------------------------------------------
; Pragmas
; ------------------------------------------------------------------------------

  

; ------------------------------------------------------------------------------
; IEC 61131 and coding directives
; ------------------------------------------------------------------------------

  ; --------------------
  ; For Loop            
  ; --------------------
  ::fo::
  {
    Send {Esc}                                                   ; close auto complete popup
    clipboard := "FOR _idx := 1 TO X`r`nDO`r`n  `r`nEND_FOR`r`n" ; set clipboard text
    Send ^v                                                      ; paste from clipboard (CTRL+V)
  }
  ::EndOfScript::fo
  
  ; --------------------
  ; Increment Step      
  ; --------------------
  ::sp++::
  {
    Send {Esc}                             ; close auto complete popup
    clipboard := "_step := _step + 1;`r`n" ; set clipboard text
    Send ^v                                ; paste from clipboard (CTRL+V)
  }
  ::EndOfScript::sp++
  
  ; --------------------
  ; Case Step Of           
  ; --------------------
  ::cso::
  {
    Send {Esc}
    clipboard := "CASE _step`r`nOF`r`n  0:`r`n    // comment`r`n    `r`n    _step := _step + 1;`r`n    `r`n  99:`r`n    // comment`r`n    `r`n    IF( FinishCondition )`r`n    THEN`r`n      _step := 0;`r`n    END_IF`r`n    `r`n  ELSE`r`n    SetExtEvent(OpconEventClass.SOFTERROR, EVENT_INVALID_CASE, CONCAT('_step=', DINT_TO_STRING(_step)), Station.Unit.ObjectID, Lock := FALSE);`r`nEND_CASE`r`n" 
    Send ^v
  }
  ::EndOfScript::cso

  

;  ; -------------------------
;  ; Executor generator info              
;  ; -------------------------
;  ::egi::
;  {
;   ; Send {Esc}                                                                             ; close auto complete popup
;    InputBox, userInput, Enter Text, Please enter the text to fill the Step, , 280, 150
;    InputBox, userInput2, Enter Text, Please enter the text to fill the Detail, , 280, 150
;    if ErrorLevel
;    MsgBox, You canceled or closed the InputBox.
;    else
;    
;    clipboard := "//<EG Step=""" . userInput . """ Info="" "" Detail=""" . userInput2 . """ />`r`n"                ; set clipboard text
;    Send ^v                                                                                ; paste from clipboard (CTRL+V)
;    return
;    
;  }
;  ::EndOfScript::egi	

; -------------------------
  ; Executor generator info              
  ; -------------------------
  ::egi::
  ::egid::
  ::egic::
  ::egif::
  {
   ; Send {Esc}                                                                             ; close auto complete popup
   
    ; Determine language from trigger text
    triggerLang := SubStr(A_ThisHotkey, 6)
    if (triggerLang = "d")
        defaultLang := "de-DE"
    else if (triggerLang = "c")
        defaultLang := "cs-CZ"
    else if (triggerLang = "f")
        defaultLang := "fr-FR"
    else 
        defaultLang := "en-US"
 
     Gui, Add, Text, , Write State:
     Gui, Add, Edit, vUserInputState w280 Limit Number, ; Default text here, if needed
     
     Gui, Add, Text, , Write Info (when empty state nr. will be used):
	Gui, Add, Edit, vUserInputInfo2 w280, ; Default text here, if needed

     Gui, Add, Text, , Write Detail:
	Gui, Add, Edit, vUserInputDetail w280, ; Default text here, if needed

     Gui, Add, Text, , SelectLang:
	Gui, Add, ComboBox, vVariableSelectionLangInfo, de-DE||cs-CZ||en-US||fr-FR
    GuiControl,Choose, VariableSelectionLangInfo, %defaultLang% ; Set default value for ComboBox
	Gui, Add, Button, gButtonOK3a, OK
	Gui, Show, , Info with lang


    indexInfo := 3000+5548
	; Wait for user input
	return

ButtonOK3a:
    GuiControlGet, variableSelectionLangInfo,, VariableSelectionLangInfo
    GuiControlGet, userInputDetail,, UserInputDetail
    GuiControlGet, userInputState,, UserInputState
     GuiControlGet, userInputInfo2,, UserInputInfo2
  ; Close the GUI window

    Gui, Destroy
    
    

    clipboard := "//<EG Step=""" . userInputState . """ Info=""" . userInputInfo2 . """`r`n //Detail=""" . userInputDetail . """ Lang=""" . variableSelectionLangInfo . """`r`n //nInfoIndex=""EG regenerate it"" />`r`n"                ; set clipboard text
    
    ;#HMI_DIRECT.widgetModuleInfo.nSubState := #HMI.INPUT.PML.current_mode * 30000 + #HMI.INPUT.PML.current_state * 1000 + #wSubstate[#HMI.INPUT.PML.current_state];
    
    
    Send ^v                                                                                ; paste from clipboard (CTRL+V)
return


    
  }
  ::EndOfScript::egil	
  
  

	
  ; -------------------------
  ; Executor generator info               
  ; -------------------------
 ; ::egii::
 ; {
 ;  ; Send {Esc}                                                                             ; close auto complete popup
 ;   InputBox, userInput, Enter Text, Please enter the text to fill the Step, , 280, 150
 ;   InputBox, userInfo, Enter Text, Please enter the text to fill the Info, , 280, 150
 ;   InputBox, userInput2, Enter Text, Please enter the text to fill the Detail, , 280, 150
 ;   if ErrorLevel
 ;   MsgBox, You canceled or closed the InputBox.
 ;   else
 ;   
 ;   clipboard := "//<EG Step=""" . userInput . """ Info=""" . userInfo . """ Detail=""" . userInput2 . """ />`r`n"                ; set clipboard text
 ;   Send ^v                                                                                ; paste from clipboard (CTRL+V)
 ;   return
 ;   
 ; }
 ; ::EndOfScript::egii	

  ; -------------------------
  ; Executor generator mode               
  ; -------------------------
	
::egm::
  {
    ;Send {Esc}                                                                             ; close auto complete popup
	; Create the GUI window
    Gui, Add, Text, , Select a mode and lang:
	Gui, Add, ComboBox, vVariableSelectionMode, PRODUCTION|MANUAL|HOME|MAINTENANCE|CHANGEOVER
	
	Gui, Add, Button, gButtonOK1a, OK
	Gui, Show, , Select mode

  ; Wait for user input
	return

	; Button OK click handler
ButtonOK1a:
    Gui, Submit, NoHide
    ; Get the selected value from the combobox
    GuiControlGet, selectedValue,, VariableSelectionMode
    GuiControlGet, selectedValueLang,, VariableSelectionLang
    
    ; Close the GUI window
    
    Gui, Destroy

    
    clipboard := "//<EG Mode=""" . selectedValue . """  Descr=""Changing mode for next infos"" />`r`n"                ; set clipboard text
    Send ^v                                                                                ; paste from clipboard (CTRL+V)
return

    GuiClosea:
    GuiEscapea:
     Gui, Destroy
     return
    
  }
  ::EndOfScript::egm
  
  


  ; -------------------------
  ; Executor generator state             
  ; -------------------------
	
 ::egs::
  {
    ;Send {Esc}                                                                             ; close auto complete popup
	; Create the GUI window
    Gui, Add, Text, , Select a state:
	Gui, Add, ComboBox, vVariableSelectionState, STOPPED|STOPPING|RESETTING|IDLE|STARTING|EXECUTE|COMPLETED|COMPLETING|ABORTING|ABORTED|CLEARING|HOLDING|HELD|UNHOLDING|SUSPENDING|SUSPENDED|UNSUSPENDING|ACTIVATING|DEACTIVATED|DEACTIVATING|UNDEFINED
	Gui, Add, Button, gButtonOK2a, OK
	Gui, Show, , Select state

  ; Wait for user input
	return

	; Button OK click handler
ButtonOK2a:
    Gui, Submit, NoHide
    ; Get the selected value from the combobox
    GuiControlGet, selectedValueState,, VariableSelectionState
    
    stateMap := { "STOPPED": 2, "STOPPING": 7, "RESETTING": 15, "IDLE": 4, "STARTING": 3, "EXECUTE": 6, "COMPLETED": 17, "COMPLETING": 16, "ABORTING": 8, "ABORTED": 9, "CLEARING": 1, "HOLDING": 10, "HELD": 11, "UNHOLDING": 12, "SUSPENDING": 13, "SUSPENDED": 15, "UNSUSPENDING": 14, "ACTIVATING": 32, "DEACTIVATED": 31, "DEACTIVATING": 30 }
    
       ; Get the numeric value from the map
    selectedValueNumeric := stateMap[selectedValueState]
    
    
    
    ; Close the GUI window
    GuiClose2a:
    GuiEscape2a:
    Gui, Destroy

    
    clipboard := "//<EG State=""" . selectedValueState . """ StateNr=""" . selectedValueNumeric  . """  Descr=""Changing state for next infos"" />`r`n"                ; set clipboard text
    Send ^v                                                                                ; paste from clipboard (CTRL+V)
return
    
  }
  ::EndOfScript::egs	
  
  
  
  
  ; --------------------------------------------------------------
  ; Executor generator event category event number, event category             
  ; ---------------------------------------------------------------
  ::ege::
 
  {
   ; Send {Esc}                                                                             ; close auto complete popup
   
    ; Determine language from trigger text
    
 
     Gui, Add, Text, , Write Category:
     Gui, Add, Edit, vUserInputCat w280 Limit Number, ; Default text here, if needed
     
     Gui, Add, Text, , Write EventID (when empty state nr. will be used):
	Gui, Add, Edit, vUserInputID w280, ; Default text here, if needed



     
	Gui, Add, Button, gButtonOK4a, OK
	Gui, Show, , Set new Event

	; Wait for user input
	return

ButtonOK4a:
   
    GuiControlGet, userInputCat,, UserInputCat
    GuiControlGet, userInputID,, UserInputID
    
  ; Close the GUI window

    Gui, Destroy

    clipboard := "//<EG_Event  Category=""" . userInputCat . """ EventID=""" . userInputID . """  />`r`n"                ; set clipboard text
    Send ^v                                                                                ; paste from clipboard (CTRL+V)
return


    
  }
  ::EndOfScript::egil	
  
  
  
  ; -------------------------
  ; Bind widgets module home and module info           
  ; -------------------------
  ::asbm::

  {
   ; Send {Esc}                                                                             ; close auto complete popup
   
    
 
     Gui, Add, Text, , Write module name to widget bing and snippet :
     Gui, Add, Edit, vUserInputModule w280 , Write number of module in {NN} format (ex. "03")
     Gui, Add, Button, gButtonOK5a, OK
    
     Gui, Show, , Widget binding

	; Wait for user input
	return

ButtonOK5a:
    
    GuiControlGet, userInputModule,, UserInputModule
    ; Close the GUI window

    Gui, Destroy

    
clipboard := "<!--Snippet file part for module" . userInputModule . " -->`r`n 
    <Snippet id=""snModule" . userInputModule . "SubStateIndex"" xsi:type=""session"" type=""Numeric"" formatItem=""{1|#X}"" />`r`n
    <Snippet id=""snModule" . userInputModule . "SubStateInfo"" xsi:type=""session"" type=""IndexText"" formatItem=""IAT/SubStateInfo_UnitModule" . userInputModule . "/{@snModule" . userInputModule . "SubStateIndex}"" />`r`n
    <Snippet id=""snModule" . userInputModule . "SubStateDetail"" xsi:type=""session"" type=""IndexText"" formatItem=""IAT/SubStateDetail_UnitModule" . userInputModule . "/{@snModule" . userInputModule . "SubStateIndex}"" />`r`n
    <!--End snippet file part for module" . userInputModule . " -->`r`n `r`n
     <!--Binding file part-->`r`n
    <!--Info module" . userInputModule . "-->`r`n`r`n
        <!--Bind from widget to snippets-->`r`n     `r`n
         <Binding mode=""oneWay""> `r`n
            <Source xsi:type=""brease"" contentRefId=""cUnitHomeM" . userInputModule . """  widgetRefId=""ModuleInfo"" attribute=""nSubStateForText"" />`r`n
            <Target xsi:type=""snippet"" refId=""snModule" . userInputModule . "SubStateIndex"" attribute=""value"" />`r`n
        </Binding>`r`n`r`n
        <!--bind snippets to snippets-->`r`n
    <Binding mode=""oneWay""> `r`n
        <Source xsi:type=""snippet"" refId=""snModule" . userInputModule . "SubStateIndex"" attribute=""value"" />`r`n
        <Target xsi:type=""snippet"" refId=""snModule" . userInputModule . "SubStateInfo"" attribute=""value"" />`r`n
    </Binding>`r`n`r`n
    <Binding mode=""oneWay""> `r`n
        <Source xsi:type=""snippet"" refId=""snModule" . userInputModule . "SubStateIndex"" attribute=""value"" />`r`n
        <Target xsi:type=""snippet"" refId=""snModule" . userInputModule . "SubStateDetail"" attribute=""value"" />`r`n
    </Binding>`r`n`r`n
    <!--Bind snippets to widgets--> `r`n`r`n 
        
    <Binding mode=""oneWay""> `r`n
        <Source xsi:type=""snippet"" refId=""snModule" . userInputModule . "SubStateInfo"" attribute=""value"" />`r`n
        <Target xsi:type=""brease"" contentRefId=""cUnitHomeM" . userInputModule . """  widgetRefId=""ModuleInfo"" attribute=""SubStateInfo"" />`r`n
    </Binding>`r`n`r`n
        
    <Binding mode=""oneWay""> `r`n
        <Source xsi:type=""snippet"" refId=""snModule" . userInputModule . "SubStateDetail"" attribute=""value"" />`r`n
        <Target xsi:type=""brease"" contentRefId=""cUnitHomeM" . userInputModule . """  widgetRefId=""ModuleInfo"" attribute=""SubStateInfoDetail"" />`r`n
    </Binding>`r`n`
        
        
        
    <!--Bind OpcUa to widgets--> `r`n`r`n 
    <Binding mode=""oneWay""> `r`n
        <Source xsi:type=""opcUa"" refId=""::Module" . userInputModule . ":HMI.StdHmi.ModuleInfoWidget.nWidgetStyle"" attribute=""value"" />`r`n
        <Target xsi:type=""brease"" contentRefId=""cUnitHomeM" . userInputModule . """ widgetRefId=""ModuleInfo"" attribute=""nInfoWidgetStyle"" />`r`n
    </Binding>`r`n
    
    <Binding mode=""twoWay""> `r`n
        <Source xsi:type=""opcUaComplexObject"" refId=""::Module" . userInputModule . ":HMI.StdHmi.ModuleInfoWidget""/>`r`n
        <Target xsi:type=""brease"" contentRefId=""cUnitHomeM" . userInputModule . """ widgetRefId=""ModuleInfo"" attribute=""Structure"" />`r`n
    </Binding>`r`n
    
    <Binding mode=""oneWay""> `r`n
        <Source xsi:type=""opcUa"" refId=""::Module" . userInputModule . ":HMI.StdHmi.ModuleInfoWidget.nPackMLState"" attribute=""value"" />`r`n
        <Target xsi:type=""brease"" contentRefId=""cUnitHomeM" . userInputModule . """ widgetRefId=""ModuleInfo"" attribute=""nPackMlState"" />`r`n
    </Binding>`r`n
    
     <Binding mode=""oneWay""> `r`n
        <Source xsi:type=""opcUa"" refId=""::Module" . userInputModule . ":HMI.StdHmi.ModuleInfoWidget.nSubStateForText"" attribute=""value"" />`r`n
        <Target xsi:type=""brease"" contentRefId=""cUnitHomeM" . userInputModule . """ widgetRefId=""ModuleInfo"" attribute=""nSubStateForText"" />`r`n
    </Binding>`r`n   `r`n 
   
    
    <!--Home module" . userInputModule . "-->`r`n
    <Binding mode=""oneWay""> `r`n
        <Source xsi:type=""opcUa"" refId=""::Module" . userInputModule . ":HMI.StdHmi.HomeWidget.nHomeWidgetStyle"" attribute=""value"" />`r`n
        <Target xsi:type=""brease"" contentRefId=""cUnitHome"" widgetRefId=""HomeModule" . userInputModule . """ attribute=""nHomeWidgetStyle"" />`r`n
    </Binding>`r`n
    
    <Binding mode=""twoWay""> `r`n
        <Source xsi:type=""opcUaComplexObject"" refId=""::Module" . userInputModule . ":HMI.StdHmi.HomeWidget"" />`r`n
        <Target xsi:type=""brease"" contentRefId=""cUnitHome"" widgetRefId=""HomeModule" . userInputModule . """ attribute=""Structure"" />`r`n
    </Binding>`r`n
    
    <!--Binding file part end for module" . userInputModule . " -->`r`n   "

   

     
    
    Send ^v                                                                                ; paste from clipboard (CTRL+V)
    
  
    
    
return


    
  }
  ::EndOfScript::asbm	
  
  
  ; --------------------
  ; For add merker deleted by {user} at {date}    
  ; --------------------
  ::ud::
  {
    Send {Esc}  
    ; Get the current Windows user name
    EnvGet, UserName, USERNAME
    
    ; Get the current date
    FormatTime, CurrentDate, , yyyy-MM-dd  ; You can change the date format if needed
    
                                                     ; close auto complete popup
    ; Set the clipboard text
    clipboard := "//unification deleted by " . UserName . " at " . CurrentDate . "//         "
    ; Wait for the clipboard to update
    ClipWait, 1
    
    Send ^v                                                      ; paste from clipboard (CTRL+V)
  }
  ::EndOfScript::ud
  
  }
  