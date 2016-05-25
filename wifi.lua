print(" ---- Connect to Default WIFI AP ")

-- ** Start wifi in station mode and wait for connection ***

if wifi.startsta({wait=12}) ==  true then 
	print("Default WiFi connected!")
	print (" IP : " .. wifi.sta.getip())
else --Second WiFi AP connection	
	print ('Default connection isn\'t established' )
	
end 
	
	
if wifi.startsta() == false  then -- if connection isn't
	
	print("Connect to default_infomir  WiFi AP")
	
	if 	wifi.startsta({ssid = 'default-infomir', pwd = '1234568', wait=12}) == true then 
		print("default-infomir  connected!")
		print (" IP : " .. wifi.sta.getip())
	else 
		print("default_infomir connection isn't established ")
	end
end

