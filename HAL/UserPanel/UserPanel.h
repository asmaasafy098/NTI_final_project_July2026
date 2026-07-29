#ifndef userPanel_H
#define userPanel_H
typedef enum { PNL_NONE, PNL_START, PNL_STOP, PNL_REVERSE, PNL_RESET } Panel_Event_t;
Std_ReturnType PANEL_Init(void);
void PANEL_Poll(void) ;
Panel_Event_t PANEL_GetEvent(void);
uint8_t PANEL_IsLocalMode(void);
#endif