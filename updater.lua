local updateURL="https://raw.githubusercontent.com/matgoebl/nodemcu-wifimusicledclock/master/update.lua"
local updateURL="https://raw.githubusercontent.com/matgoebl/test/master/update.lua"
local rgb_pin=4 -- GPIO 2
local brg=31 -- brightness

tmr.alarm(0,1000,1, function()
 if(wifi.sta.getip()==nil) then
  print("waiting for wifi..")
 else
  print("wlan connected:", wifi.sta.getip())
  tmr.stop(0)
  print("get update:",updateURL)
  ws2812.writergb(rgb_pin,string.char(0,0,brg)..string.char(0,0,0)..string.char(0,0,brg))
  http.get(updateURL, nil, function(code,data)
   if (code ~= 200) then
     print("http error:",code)
     ws2812.writergb(rgb_pin,string.char(brg,0,0)..string.char(0,0,0)..string.char(brg,0,0))
   else
    print("body size:",#data)
    pcall(loadstring(data))
   end
  end)
 end
end)
