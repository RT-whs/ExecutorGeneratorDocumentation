# 231080 - Robots functions

## Homes
Robot R1 has a home position according to the customer's request. R2 and R3 have the home position facing upwards for safety reasons (R2 has a sharp knife and flame burner).

## Air
Air pressure is enabled by PLC with safety signals and robot signal. Robot has function to toggle the air pressure.
When all robots are without move for more then 3 hours the air pressure is disabled. 

!!! info "Enabling air pressure"
    To re-enable the air pressure is needed to press button "Acknowledge errors", press button "Start cycle" or simply move with robot (if you want air pressure in T1 mode).

??? example "Code example"
    ``` pascal title="Air pressure control"

    IF $ROB_STOPPED AND DI_R2_ROB_STOPPED AND DI_R3_ROB_STOPPED AND $IN_HOME AND DI_ROB2_JE_HOME AND DI_ROB3_JE_HOME THEN
        IF bCLK_1_TIME_PER_SEC THEN
        iVzduch_Life = iVzduch_Life + 1
        IF iVzduch_Life >= iVzduch_CAS THEN
            iVzduch_Life = 0
            DO_ZAP_VZDUCH = FALSE
        ENDIF
        ENDIF
    ELSE      
        iVzduch_Life = 0
        DO_ZAP_VZDUCH = TRUE
    ENDIF

    IF $EXT_START OR DI_PB_ACK_ERROR THEN
        iVzduch_Life = 0
        DO_ZAP_VZDUCH = TRUE
    ENDIF

    ```

## Hot air gun
Hot air gun is controlled by robot and physical switch. 

!!! info "Enabling hot air gun"
    Switch on to enable 24 V for control hot air gun. Robot on start cycle loop enable the heating. 

!!! warning "Disabling hot air gun"
    After robot done and stopped loop then robot turn off heating. If physical switch is turned off then here is couple of minutes until the 24 V is disabled because of safety hot air gun (must be off heating and few moment air on to cool down).

??? example "Code example"
    ``` pascal title="Hot air control control"

    IF DI_POUZIT_HORKOVZ THEN
        DO_HORKOVZ_ON = TRUE
        HORKOVZ_LIFE = 0
    ELSE
        DO_HORKOVZ_START = FALSE
        IF bCLK_1_TIME_PER_SEC THEN
            HORKOVZ_LIFE = HORKOVZ_LIFE + 1
            IF HORKOVZ_LIFE >= 180 THEN ; seconds to off
                HORKOVZ_LIFE = 0
                DO_HORKOVZ_ON = FALSE
            ENDIF
        ENDIF
    ENDIF
    
    IF NOT DI_IMM_IN_AUTOMATIC AND $EXT THEN
        DO_HORKOVZ_START = FALSE
    ENDIF

    ```

## Conveyor belts
Robots R1 and R3 can control the conveyors. R1 have a main logic to control conveyors and R3 only send blocking signal to R1.




