--script by bbpanzu
local onCamBeat = false;
		



function onBeatHit()
	if onCamBeat then
		triggerEvent('Add Camera Zoom');
	end

end
function onEvent(n,v1,v2)
	if n == "bopbopbop" then
		onCamBeat = v1 == "true"
	end
end