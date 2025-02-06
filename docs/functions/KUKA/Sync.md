# Synchronization function between KUKA robots

!!! warning "Warning"

    This function is not tested yet and may not work correctly!



## Overview

This function is used for synchronization between robots. Function has commands #READY, #PROCESSING, #DONE, #ERROR and #RESET_ALL.


## Implementation
??? tip "Expand to show implemetation"

    === "config.dat"

        ``` pascal

            ENUM SYNC_OPERATION READY, PROCESSING, DONE, ERROR, RESET_ALL
            DECL SYNC_OPERATION SYNC_CMD
            DECL INT THIS_ROBOT_ID = 1 ; unique number in array of sync... NOT 0 !!! num 1 - 10
            DECL INT MAX_ROBOTS_NUM = 10
            DECL BOOL bSYNC_ROB_READY[10]
            DECL BOOL bSYNC_ROB_PROCESSING[10]
            DECL BOOL bSYNC_ROB_DONE[10]
            DECL BOOL bSYNC_ROB_ERROR[10]
            DECL SYNC_OPERATION SYNC_ACTIVATE[10]

            ; Here mapp input signals. Signal [1] means robot 1, [2] means robot 2,...
            DECL INT SYNC_IN_READY[10]
            SYNC_IN_READY[1]  = 101     ; signal IN[1026] means always FALSE
            SYNC_IN_READY[2]  = 102     ; signal IN[1026] means always FALSE
            SYNC_IN_READY[3]  = 103     ; signal IN[1026] means always FALSE
            SYNC_IN_READY[4]  = 104     ; signal IN[1026] means always FALSE
            SYNC_IN_READY[5]  = 105     ; signal IN[1026] means always FALSE
            SYNC_IN_READY[6]  = 106     ; signal IN[1026] means always FALSE
            SYNC_IN_READY[7]  = 107     ; signal IN[1026] means always FALSE
            SYNC_IN_READY[8]  = 108     ; signal IN[1026] means always FALSE
            SYNC_IN_READY[9]  = 109     ; signal IN[1026] means always FALSE
            SYNC_IN_READY[10] = 110     ; signal IN[1026] means always FALSE

            DECL INT SYNC_IN_PROCESSING[10]
            SYNC_IN_PROCESSING[1]  = 111     ; signal IN[1026] means always FALSE
            SYNC_IN_PROCESSING[2]  = 112     ; signal IN[1026] means always FALSE
            SYNC_IN_PROCESSING[3]  = 113     ; signal IN[1026] means always FALSE
            SYNC_IN_PROCESSING[4]  = 114     ; signal IN[1026] means always FALSE
            SYNC_IN_PROCESSING[5]  = 115     ; signal IN[1026] means always FALSE
            SYNC_IN_PROCESSING[6]  = 116     ; signal IN[1026] means always FALSE
            SYNC_IN_PROCESSING[7]  = 117     ; signal IN[1026] means always FALSE
            SYNC_IN_PROCESSING[8]  = 118     ; signal IN[1026] means always FALSE
            SYNC_IN_PROCESSING[9]  = 119     ; signal IN[1026] means always FALSE
            SYNC_IN_PROCESSING[10] = 120     ; signal IN[1026] means always FALSE

            DECL INT SYNC_IN_DONE[10]
            SYNC_IN_DONE[1]  = 121     ; signal IN[1026] means always FALSE
            SYNC_IN_DONE[2]  = 122     ; signal IN[1026] means always FALSE
            SYNC_IN_DONE[3]  = 123     ; signal IN[1026] means always FALSE
            SYNC_IN_DONE[4]  = 124     ; signal IN[1026] means always FALSE
            SYNC_IN_DONE[5]  = 125     ; signal IN[1026] means always FALSE
            SYNC_IN_DONE[6]  = 126     ; signal IN[1026] means always FALSE
            SYNC_IN_DONE[7]  = 127     ; signal IN[1026] means always FALSE
            SYNC_IN_DONE[8]  = 128     ; signal IN[1026] means always FALSE
            SYNC_IN_DONE[9]  = 129     ; signal IN[1026] means always FALSE
            SYNC_IN_DONE[10] = 130     ; signal IN[1026] means always FALSE

            DECL INT SYNC_IN_ERROR[10]
            SYNC_IN_ERROR[1]  = 131     ; signal IN[1026] means always FALSE
            SYNC_IN_ERROR[2]  = 132     ; signal IN[1026] means always FALSE
            SYNC_IN_ERROR[3]  = 133     ; signal IN[1026] means always FALSE
            SYNC_IN_ERROR[4]  = 134     ; signal IN[1026] means always FALSE
            SYNC_IN_ERROR[5]  = 135     ; signal IN[1026] means always FALSE
            SYNC_IN_ERROR[6]  = 136     ; signal IN[1026] means always FALSE
            SYNC_IN_ERROR[7]  = 137     ; signal IN[1026] means always FALSE
            SYNC_IN_ERROR[8]  = 138     ; signal IN[1026] means always FALSE
            SYNC_IN_ERROR[9]  = 139     ; signal IN[1026] means always FALSE
            SYNC_IN_ERROR[10] = 140     ; signal IN[1026] means always FALSE

            ; Here mapp output signals.
            DECL INT SYNC_OUT_READY       = 100 ; First bit for output signal -> program then add THIS_ROBOT_ID to use correct out signal
            DECL INT SYNC_OUT_PROCESSING  = 110 ; First bit for output signal -> program then add THIS_ROBOT_ID to use correct out signal
            DECL INT SYNC_OUT_DONE        = 120 ; First bit for output signal -> program then add THIS_ROBOT_ID to use correct out signal
            DECL INT SYNC_OUT_ERROR       = 130 ; First bit for output signal -> program then add THIS_ROBOT_ID to use correct out signal

        ```

    === "SendSyncMess.src"

        ``` pascal

            &ACCESS RVP
            &PARAM EDITMASK = *
            DEF SendSyncMess( CMD:IN )

            ; ------------------------------- Usage --------------------------------
            ; Use in program just like this -> SendSyncMess(cmd)
            ; cmd: #READY, #PROCESSING, #DONE, #ERROR, #RESET_ALL
            ;
            ; On the specific cmd, function set the correspond output to TRUE or FALSE
            
            DECL SYNC_OPERATION CMD
            
            SWITCH CMD
                CASE #READY
                    $OUT[SYNC_OUT_READY + THIS_ROBOT_ID]      = TRUE
                    $OUT[SYNC_OUT_PROCESSING + THIS_ROBOT_ID] = FALSE
                    $OUT[SYNC_OUT_DONE + THIS_ROBOT_ID]       = FALSE
                    $OUT[SYNC_OUT_ERROR + THIS_ROBOT_ID]      = FALSE
                    
                CASE #PROCESSING
                    $OUT[SYNC_OUT_READY + THIS_ROBOT_ID]      = FALSE
                    $OUT[SYNC_OUT_PROCESSING + THIS_ROBOT_ID] = TRUE
                    $OUT[SYNC_OUT_DONE + THIS_ROBOT_ID]       = FALSE
                    $OUT[SYNC_OUT_ERROR + THIS_ROBOT_ID]      = FALSE
                    
                CASE #DONE
                    $OUT[SYNC_OUT_READY + THIS_ROBOT_ID]      = FALSE
                    $OUT[SYNC_OUT_PROCESSING + THIS_ROBOT_ID] = FALSE
                    $OUT[SYNC_OUT_DONE + THIS_ROBOT_ID]       = TRUE
                    $OUT[SYNC_OUT_ERROR + THIS_ROBOT_ID]      = FALSE
                    
                CASE #ERROR
                    $OUT[SYNC_OUT_READY + THIS_ROBOT_ID]      = FALSE
                    $OUT[SYNC_OUT_PROCESSING + THIS_ROBOT_ID] = FALSE
                    $OUT[SYNC_OUT_DONE + THIS_ROBOT_ID]       = FALSE
                    $OUT[SYNC_OUT_ERROR + THIS_ROBOT_ID]      = TRUE
                    
                CASE #RESET_ALL
                    $OUT[SYNC_OUT_READY + THIS_ROBOT_ID]      = FALSE
                    $OUT[SYNC_OUT_PROCESSING + THIS_ROBOT_ID] = FALSE
                    $OUT[SYNC_OUT_DONE + THIS_ROBOT_ID]       = FALSE
                    $OUT[SYNC_OUT_ERROR + THIS_ROBOT_ID]      = FALSE
                    
                DEFAULT
                    $OUT[SYNC_OUT_READY + THIS_ROBOT_ID]      = FALSE
                    $OUT[SYNC_OUT_PROCESSING + THIS_ROBOT_ID] = FALSE
                    $OUT[SYNC_OUT_DONE + THIS_ROBOT_ID]       = FALSE
                    $OUT[SYNC_OUT_ERROR + THIS_ROBOT_ID]      = FALSE

            ENDSWITCH
            
            END

        ```


    === "ReceiveSyncMess.src"

        ``` pascal

            &ACCESS RVP
            &PARAM EDITMASK = *
            DEF ReceiveSyncMess( robotID:IN, cmd:IN ) 
            
            ; ------------------------------- Usage --------------------------------
            ; Use in program just like this -> ReceiveSyncMess(cmd)
            ; cmd: #READY, #PROCESSING, #DONE, #ERROR, #RESET_ALL
            ;
            ; On the specific cmd, function activate watch variable -> watch variable is
            ; used in sub program sps.
            ;
            ; When sps get signal from other robot then function passes throught WAIT
            ; and continue program
            
            DECL INT robotID
            DECL SYNC_OPERATION cmd
            
            IF (robotID > 0) AND (robotID <= MAX_ROBOTS_NUM) THEN
                
                SYNC_ACTIVATE[robotID] = cmd
                
                SWITCH cmd
                    CASE #READY
                        WAIT FOR bSYNC_ROB_READY[robotID]
                        
                    CASE #PROCESSING
                        WAIT FOR bSYNC_ROB_PROCESSING[robotID]
                        
                    CASE #DONE
                        WAIT FOR bSYNC_ROB_DONE[robotID]
                    
                    CASE #ERROR
                        WAIT FOR bSYNC_ROB_ERROR[robotID]
                        
                    DEFAULT
                        SYNC_ACTIVATE[robotID] = #RESET_ALL
                        
                ENDSWITCH
                
                SYNC_ACTIVATE[robotID] = #RESET_ALL
                
            ENDIF
            
            END

        ```

    === "SPS"

        ``` pascal

            ;FOLD USER DECL
            ; Please insert user defined declarations
                INT i

            ;ENDFOLD (USER DECL)




            ;FOLD USER INIT
            ; Please insert user defined initialization commands
                
                ; all sync function disable on init
                FOR i = 1 TO MAX_ROBOTS_NUM
                    SYNC_ACTIVATE[i]        = #RESET_ALL
                    bSYNC_ROB_READY[i]      = FALSE
                    bSYNC_ROB_PROCESSING[i] = FALSE
                    bSYNC_ROB_DONE[i]       = FALSE
                    bSYNC_ROB_ERROR[i]      = FALSE
                ENDFOR
                    
            ;ENDFOLD (USER INIT)




            LOOP
            ;FOLD USER PLC
            ;Make your modifications here


            
            FOR i = 1 TO MAX_ROBOTS_NUM
                
                IF SYNC_ACTIVATE[i] == #RESET_ALL THEN
                    bSYNC_ROB_READY[i]      = FALSE
                    bSYNC_ROB_PROCESSING[i] = FALSE
                    bSYNC_ROB_DONE[i]       = FALSE
                    bSYNC_ROB_ERROR[i]      = FALSE
                ENDIF
                
                IF SYNC_ACTIVATE[i] == #READY THEN
                    IF $IN[SYNC_IN_READY[i]] THEN
                        bSYNC_ROB_READY[i] = TRUE
                    ELSE
                        bSYNC_ROB_READY[i] = FALSE
                    ENDIF
                ENDIF
                
                IF SYNC_ACTIVATE[i] == #PROCESSING THEN
                    IF $IN[SYNC_IN_PROCESSING[i]] THEN
                        bSYNC_ROB_PROCESSING[i] = TRUE
                    ELSE
                        bSYNC_ROB_PROCESSING[i] = FALSE
                    ENDIF
                ENDIF

                IF SYNC_ACTIVATE[i] == #DONE THEN
                    IF $IN[SYNC_IN_DONE[i]] THEN
                        bSYNC_ROB_DONE[i] = TRUE
                    ELSE
                        bSYNC_ROB_DONE[i] = FALSE
                    ENDIF
                ENDIF

                IF SYNC_ACTIVATE[i] == #ERROR THEN
                    IF $IN[SYNC_IN_ERROR[i]] THEN
                        bSYNC_ROB_ERROR[i] = TRUE
                    ELSE
                        bSYNC_ROB_ERROR[i] = FALSE
                    ENDIF
                ENDIF

            ENDFOR
            
            ;ENDFOLD (USER PLC)
            ENDLOOP

        ```


!!! example "Example"

    === "robot_1.src"

        ``` pascal

            PTP test_1 CONT Vel=100 % PDAT103 

            SendSyncMess(#READY)
            ReceiveSyncMess(2, #DONE) ; waiting for robot 2 done
            SendSyncMess(#RESET_ALL)

            PTP test_2 CONT Vel=100 % PDAT104

        ```

    === "robot_2.src"

        ``` pascal

            ReceiveSyncMess(1, #READY) ; waiting for robot 1 ready

            SendSyncMess(#PROCESSING)

            PTP test_1 CONT Vel=100 % PDAT103 
            
            TRIGGER WHEN DISTANCE=1 DELAY=0 DO=SendSyncMess(#DONE)
            PTP test_2 CONT Vel=100 % PDAT104
            

        ```  