local baseURL="https://raw.githubusercontent.com/matgoebl/nodemcu-wifimusicledclock/master/"
local baseURL="https://raw.githubusercontent.com/matgoebl/test/master/"
local update_files={'cfgedit.lua','clock.lua','compile.lua','handle_http_basic.lua','melody.lua','modes.lua','nettime.lua','rgb.lua','twokeys.lua','update.lua','updater.lua','index.html','api.js','rgb.js','autostart.lua'}
-- 'config.lua'
-- 'init.lua'
local rgb_pin=4 -- GPIO 2

function download_files(filelist,count)
 local remaining=#filelist
 ws2812.writergb(rgb_pin,string.char(255,255,0):rep(count-remaining)..string.char(0,0,255):rep(remaining))
 print("count:",count-remaining,remaining)
 local filename=table.remove(filelist)
 if filename~=nil then
  print("download:",baseURL..filename)
  http.get(listURL, nil, function(code,data)
   if (code ~= 200) then
     print("http error:",code)
     ws2812.writergb(rgb_pin,string.char(255,255,0):rep(count-remaining-1)..string.char(255,0,0)..string.char(0,0,255):rep(remaining))
   else
    print("ok,size:",#data)
    file.remove(filename)
    file.open(filename,"w")
    file.write(d)
    file.close()
   end
  end)
  download_files(filelist,count)
 else
  node.restart()
 end
end

download_files(update_files,#update_files)
