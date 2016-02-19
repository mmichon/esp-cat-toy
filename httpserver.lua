srv=net.createServer(net.TCP)
srv:listen(80, function(conn)
    
    conn:on("receive", function(client, request)
        local response = ""
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
        
        if (method == nil) then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
        end
        
        local _GET = {}
        if (vars ~= nil) then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
                print("Processing HTTP command: "..k.."/"..v)
            end
        end

        response = index_html
        
        local _on,_off = "",""

        if (_GET.auto == "fast") then
            start_servo()
            start_wiggle_servo(position_change_ms_fast)
        elseif (_GET.auto == "slow") then
            start_servo()
            start_wiggle_servo(position_change_ms_slow)
        elseif (_GET.auto == "bottom") then
            stop_wiggle_servo()
            start_servo(100)
            stop_servo()
        elseif (_GET.auto == "off") then
            stop_wiggle_servo()
            start_servo(1)
            stop_servo()
        elseif (_GET.setposition ~= nil) then
            stop_wiggle_servo()
            start_servo(_GET.setposition)
            stop_servo()
        end
        
        client:send(response)
        client:close()
        collectgarbage()
    end)
end)