srv=net.createServer(net.TCP,10)
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

        local _on,_off = "",""

        -- XXX/clean up the old routines
        if (_GET.auto == "frenzy") then
            -- Change to only do this for 30 seconds
            start_servo()
            start_wiggle_servo(position_change_ms_fast)
        elseif (_GET.auto == "tease") then
            -- Change to only do this for 30 seconds
            start_servo()
            start_wiggle_servo(position_change_ms_slow)
        elseif (_GET.auto == "fulltravel") then
            stop_wiggle_servo()
            start_servo(1)
            set_servo_position(100)
            tmr.delay(1000*1000)
            stop_servo()
        elseif (_GET.auto == "lower") then
            stop_wiggle_servo()
            start_servo(100)
            stop_servo()
        elseif (_GET.setposition ~= nil) then
            stop_wiggle_servo()
            start_servo(_GET.setposition)
            stop_servo()
        elseif (_GET.auto == "raise") then
            sensor.stop()
        elseif (_GET.auto == "sensor") then
            sensor.start()
        end

        if file.open("webpage.html", "r") then
            reponse = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n"

            -- read 1K chunks to get around the socket buffer size limits
            while true do
                block = file.read(1024)
                if not block then break end

                response = response..block
            end

            file.close()
        end

        print("Response length: "..string.len(response))
        -- XXX/fix the 1460 byte response size limit
        client:send(response)
        client:close()

        collectgarbage()
    end)
end)
