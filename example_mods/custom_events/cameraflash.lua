function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

function onEvent(tag, var1, var2)
	if tag == 'cameraflash' then
		vars1 = mysplit(var1, ',')
		cameraFlash(vars1[1], vars1[2], var2, true)
	end
end