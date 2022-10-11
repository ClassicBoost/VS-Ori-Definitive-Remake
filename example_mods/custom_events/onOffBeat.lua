--script by bbpanzu
local onOffBeat = false;
local dadsingL = 4
local bfsingL = 4
		realAnimdad = 'idle'
		realAnimbf = 'idle'
		

function getAnim(char,prop)
prop = prop or 'name'
	return getProperty(char .. '.animation.curAnim.' .. prop)

end


function onBeatHit()
	if onOffBeat and curBeat % 2 ~= 0 then
		--if getAnim("dad") == "idle"..getProperty('dad.idleSuffix') then
			--characterPlayAnim("dad","idle"..getProperty('dad.idleSuffix'),true)
		--end
		if getAnim("boyfriend") == "idle"..getProperty('boyfriend.idleSuffix') then
			characterPlayAnim("boyfriend","idle"..getProperty('boyfriend.idleSuffix'),true)
		end


	end

end
function onEvent(n,v1,v2)
	if n == "onOffBeat" then
		onOffBeat = v1 == "true"
	end
end