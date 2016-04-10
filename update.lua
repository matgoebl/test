local baseURL="https://raw.githubusercontent.com/matgoebl/nodemcu-wifimusicledclock/master/"
--local baseURL="https://raw.githubusercontent.com/matgoebl/test/master/"
local update_files={'cfgedit.lua','clock.lua','compile.lua','handle_http_basic.lua','melody.lua','modes.lua','nettime.lua','rgb.lua','twokeys.lua','update.lua','updater.lua','index.html','api.js','rgb.js','autostart.lua'}
-- 'config.lua'
-- 'init.lua'
local rgb_pin=4 -- GPIO 2
local brg=31 -- brightness

function download_files(filelist,count)
 local remaining=#filelist
 ws2812.writergb(rgb_pin,string.char(brg,brg,0):rep(count-remaining)..string.char(0,0,brg):rep(remaining))
 print("count:",count-remaining,remaining)
 local filename=table.remove(filelist,1)
 if filename~=nil then
  tmr.alarm(0, 1000, 0, function()

  print("download:",baseURL..filename)
  http.get(baseURL..filename, nil, function(code,data)
   if (code ~= 200) then
     print("http error:",code)
     ws2812.writergb(rgb_pin,string.char(brg,brg,0):rep(count-remaining)..string.char(brg,0,0)..string.char(0,0,brg):rep(remaining-1))
   else
    print("ok,size:",#data)
    file.remove(filename)
    file.open(filename,"w")
    file.write(data)
    file.close()
    download_files(filelist,count)
   end
  end)
  end)
 else
  node.restart()
 end
end

download_files(update_files,#update_files)
