function connect_wifi (ap, password)
    print("Connecting to network\n")

    wifi.sleeptype(wifi.MODEM_SLEEP)
    wifi.setmode(wifi.STATION)
    wifi.sta.config(ap, password)

    local start_time = tmr.now()
    tmr.alarm(0, 100, 1, function()
        if wifi.sta.getip() ~= nil then
            local elapsed = (tmr.now() - start_time) / 1000
            print("Connected in "..elapsed.." ms\n")
            print('IP: ',wifi.sta.getip()..'\n')

            tmr.stop(0)
        end
    end)
end

function read_file(filename)
    local content = ""
    local line = ""

    file.open(filename, "r")

    -- NodeMCU has a size limit with file.read() so reading line by line is necessary :(
    repeat
        line = file.readline()
        if line ~= nil then content = content .. line; end
    until line == nil

    file.close()

    return content
end

function post_to_ifttt(event, key, time_elapsed)

    client = net.createConnection(net.TCP, 0)

    client:on("receive", function(client, response) print("Response body: "..response.."\n") end)

    client:on("connection", function(c)
        request_body = 'POST /trigger/'..event..'/with/key/'..key..' HTTP/1.1\r\nHost: maker.ifttt.com\r\n'
            ..'Content-Type: application/json\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n'
            ..'{"Value1":"'..time_elapsed..'"}'

        print("Request: "..request_body.."\n")

        client:send(request_body)
    end)

    client:connect(80, "maker.ifttt.com")
    client:close()
    collectgarbage()

--[[
    http.post('https://maker.ifttt.com/trigger/'..event..'/with/key/'..key,
        'Content-Type: application/json\r\n',
        '{"time_elapsed":'..time_elapsed..'}',
        function(code, data)
            if (code < 0) then
                print("HTTP request failed\n")
            else
                print(code, data)
            end
        end)
        ]]--
end
