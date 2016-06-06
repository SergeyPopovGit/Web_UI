-- Web Server demo

-- Create new server socket
if webskt ~= nil then
	-- close the socket if it existed
	net.close(webskt)
	tmr.delayms(100)
end

webskt = net.new(net.TCP,net.SERVER)
if webskt < 0 then
	print("Error creating socket")
	return
end

http = {}
http.debug = 1



function respond(clt,str)
	if str ~= nil then
		net.send(clt,str)
		if http.debug == 1 then
			print(clt.."->"..str)
		end
	end
end

function dbg(head,val)
	if  http.debug then
		if head and val then
			print(head.."->"..val)
		end
	end
end



function webrecv(clt, d)
	if http.debug == 1 then print(d) end
	
	local ret, resp
		--Detect Request type
	http.method = string.match(d, "(%u+) .+\r\n")
	dbg("HTTP Method", http.method)
		--Detect connection type
	http.connect = string.match(d,"Connection: (%l+%p+%l+)}")
	dbg ("HTTP connection", http.connect)
		
		--Make responce 
		
	if http.method == 'POST' then
	--POST method processing
		-- find lua cmd value
		http.lua_cmd = string.match(d,'Lua_cmd:(.+)}') 
		
		if http.lua_cmd  then
			dbg("Lua cmd",http.lua_cmd)
			ret = dostring(http.lua_cmd,1,'web_cmd')
			dbg("Lua cmd return",http.lua_cmd)
		end 				
	---------------------------	
	elseif http.method == 'GET' then
	--GET method processing
		--send HTTP responce header
		
		---
		--send SVG image
		
		---
		
		--send JS 
		
		---
		
		--send HTTP end
		
	------------------------------
	end
		--sent init line 
	net.send(clt,"HTTP/1.1 200 OK\r\n")

end

	--send ansver fanction

net.on(webskt,"sent", function(clt,len) 
	net.send(clt,[[
	Server: WiFiMCU
	Content-Type:text/html
	Connection: keep-alive
	
	
	]])
end)


net.on(webskt,"receive", webrecv)

net.on(webskt,"accept", function(clt,ip,port) print("ACCEPT: "..ip..":"..port..", clt: "..clt) end)

--net.on(webskt,"sent", function(clt) print("SENT") net.close(clt) end)


net.on(webskt,"disconnect", function(clt) net.close(clt) print("Socket closed from client, Close: "..clt)end)

webport = 80 -- port on which the web server will listen
local stat = net.start(webskt, webport) 
if stat < 0 then
	print("Error:", stat)
	return
end

local _ip
_ip = wifi.sta.getip()
print("Web server started, skt: "..webskt..", listening on ".._ip..":"..webport.."\r\n")
print("Execute: net.close(webskt) to stop it.")