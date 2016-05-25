--delay for stop execution
gpio.mode(0,gpio.INPUT)	-- configure BOOT button pin
tmr.delayms(1000)	-- make delay for pushing button
if gpio.read(0) ~= 0 then --Start if BOOT button didt'n push in delay time after restart
	--do init actions
	 print('Initialization begin')
	dofile('wifi.lua')
	dofile('webserver.lua')
else

	print('Initialization pass')
 
 end