print("wifi connection begin")
	--set wifi parameters
local cfg={}
	  cfg.ssid="WiFiMCU"; cfg.pwd="12345678"; wait=12;

repeat 
	print("Waiting for wifi connection...")
	--local wifiok = wifi.startsta({ssid="myRouterSSID", pass="routerKEY", wait=12})
	-- ** You can use default settings if configured in system params
    wifiok = wifi.startap(cfg)
until wifiok == true