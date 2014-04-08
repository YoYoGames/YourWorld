/// Pick(x, y);
//
// Use the picking surface and "pick"
//
//*****************************************************************************

global.DoPick = true;
global.PickMouseX = argument0;
global.PickMouseY = argument1;

// Setup to pick the relevant information
global.enableRenderCity = false;
global.enableRenderSprites = false;
global.enableRenderObjects = false;

if (KMleft)
    {
    switch (global.EditorMode)
        {
        case (EDIT_SELECTION):
        case (EDIT_OBJECTS):
        case (EDIT_PAINT):
        case (EDIT_ROADS):
        case (EDIT_SPRITES):
        case (EDIT_PEDS):
            global.enableRenderCity = true;
            break;
        }
    }
else if (KMright)
    {
    switch (global.EditorMode)
        {
        case (EDIT_SELECTION):
            global.enableRenderCity = true;
            break;
        case (EDIT_SPRITES):
            global.enableRenderSprites = true;
            break;
        case (EDIT_OBJECTS):
            global.enableRenderObjects = true;
            break;
        }
    }

