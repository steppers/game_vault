local isMono = false
local colorDepth = 3
local source = CAMERA_FRONT
    
function CartridgeSetup()
    cameraSource(source)
    ConsoleSetMono(isMono)
    ConsoleSetColorDepth(colorDepth)
end

function CartridgeUpdate()
    
end

function CartridgeDraw()
    background(64)
    
    if CurrentOrientation == PORTRAIT or CurrentOrientation == PORTRAIT_UPSIDE_DOWN then
        sprite(CAMERA, DISPLAY_RES/2, DISPLAY_RES/2, DISPLAY_RES / 1.7777, DISPLAY_RES)
    else
        sprite(CAMERA, DISPLAY_RES/2, DISPLAY_RES/2, DISPLAY_RES, DISPLAY_RES / 1.7777)
    end
end

function CartridgeOnButton(btn, state)
    if state == PRESSED then
        if btn == CONSOLE_A then
            local n = readGlobalData("imageNum")
            if n == nil then
                n = 0
            end
             
            local pic
            if CurrentOrientation == PORTRAIT or CurrentOrientation == PORTRAIT_UPSIDE_DOWN then
                pic = ConsoleGetFramebuffer():copy(29, 1, 72, 128)
            else
                pic = ConsoleGetFramebuffer():copy(1, 29, 128, 72)
            end
            saveImage(asset.documents .. "img" .. tostring(math.floor(n)) .. ".png", pic)
            saveGlobalData("imageNum", n + 1)
        elseif btn == CONSOLE_B then
            if source == CAMERA_BACK then
                source = CAMERA_FRONT
            else
                source = CAMERA_BACK
            end
            cameraSource(source)
        elseif btn == CONSOLE_UP then
            if colorDepth < 8 then
                colorDepth = colorDepth + 1
            end
            ConsoleSetColorDepth(colorDepth)
        elseif btn == CONSOLE_DOWN then
            if colorDepth > 1 then
                colorDepth = colorDepth - 1
            end
            ConsoleSetColorDepth(colorDepth)
        elseif btn == CONSOLE_LEFT then
            ConsoleSetMono(true)
        elseif btn == CONSOLE_RIGHT then
            ConsoleSetMono(false)
        end
    end
	end