function startup()
    print('Starting up...\n')
    dofile('cat_toy.lua')
end

print('Use tmr.stop(1) to stop startup.\n')
tmr.alarm(0,5000,0,startup)
