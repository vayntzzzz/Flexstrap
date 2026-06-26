local hidegui = getgenv().hideui or false
local cloneref: () -> () = cloneref or function(...): (...any) -> (...any) return (...) end
local httpservice = cloneref(game:GetService('HttpService'))
local getasync: () -> () = function(string: string): (string) -> (string)
    return game:HttpGet(string, true)
end
makefolder('Flexstrap');
makefolder('Flexstrap/Main');
    makefolder('Flexstrap/Main/Functions');
    makefolder('Flexstrap/Main/Configs');
    makefolder('Flexstrap/Main/Fonts')
    makefolder('Flexstrap/Images')
local install: () -> () = function(config: {path: string, setup: boolean}): (table) -> ()
    config = config or {}
    
    for i: number, v: table in httpservice:JSONDecode(getasync('https://api.github.com/repos/vayntzzzz/Flexstrap/contents/')) do
        if v.name:find('.lua') then
            writefile(`Flexstrap/{v.name}`, `return loadstring(game:HttpGet('https://raw.githubusercontent.com/vayntzzzz/Flexstrap/refs/heads/main/{v.name}', true))()`);
        elseif v.name:find('.mp3') or v.name:find('.png') then
            writefile(`Flexstrap/{v.name}`, game:HttpGet(`https://raw.githubusercontent.com/vayntzzzz/Flexstrap/refs/heads/main/{v.name}`));
        end;
    end;
    writefile(`Flexstrap/Main/Flexstrap.lua`, `return loadstring(game:HttpGet('https://raw.githubusercontent.com/vayntzzzz/Flexstrap/refs/heads/main/Main/Flexstrap.lua', true))()`);
    for i: number, v: table in httpservice:JSONDecode(getasync('https://api.github.com/repos/vayntzzzz/Flexstrap/contents/Main/Functions')) do
        writefile(`Flexstrap/Main/Functions/{v.name}`, `return loadstring(game:HttpGet('https://raw.githubusercontent.com/vayntzzzz/Flexstrap/refs/heads/main/Main/Functions/{v.name}', true))()`);
    end;
    writefile("Flexstrap/Main/Configs/Default.json", "{}")
end;

if (not isfolder('Flexstrap') or #listfiles('Flexstrap') <= 6) then
    install({})
end

local Flexstrap: table = loadfile('Flexstrap/Main/Flexstrap.lua')()
Flexstrap.start() 
Flexstrap.Visible(not hidegui)
