--ori also needs to be made with a script since his legs would also be still during hold notes
oriidleoffsets = {'-5', '0'}
orileftoffsets = {'5', '-6'}
oridownoffsets = {'-8', '-10'}
oriupoffsets = {'7', '-6'}
orirightoffsets = {'2', '-7'}


origraboffsets = {'0', '0'}
easygrab = false
function onCreatePost()
	if difficulty == 0 then
		easygrab = false
	end
	
	makeLuaSprite('gloweffect','nibel/origlow',900,0)
	setObjectOrder('gloweffect',100);
	addLuaSprite('gloweffect',true)
	
	
	
	makeAnimatedLuaSprite('bashthing', 'nibel/ginso/bash-object', 0, -1000);
	addAnimationByPrefix('bashthing', 'bashed', 'bash-object bash', 24, false);
	addLuaSprite('bashthing', false);
	scaleObject('bashthing', 4, 4);
	
	makeAnimatedLuaSprite('countdown', 'iconstuff', 1000, 100);
	addAnimationByPrefix('countdown', 'yes', 'save yes', 1, false);
	addAnimationByPrefix('countdown', 'no', 'save no', 1, false);
	setObjectCamera('countdown','camHud')
	updateHitbox('countdown')
	addLuaSprite('countdown', false);
	setProperty('countdown.alpha', 0.4);
	scaleObject('countdown', 0.9, 0.9);
	scaleObject('ori', 0.8, 0.8);

	objectPlayAnimation('countdown', 'yes')
	
	makeAnimatedLuaSprite('ori', 'characters/orirun', 600, 100);

	addAnimationByPrefix('ori', 'idle', 'orirun idle', 30, true);
	addAnimationByPrefix('ori', 'singLEFT', 'orirun left', 30, true);
	addAnimationByPrefix('ori', 'singDOWN', 'orirun down', 30, true);
	addAnimationByPrefix('ori', 'singUP', 'orirun up', 30, true);
	addAnimationByPrefix('ori', 'singRIGHT', 'orirun right', 30, true);
	addAnimationByPrefix('ori', 'grab', 'orirun grab', 30, true);
	addAnimationByPrefix('ori', 'launch', 'orirun launch', 15, false);
	addAnimationByPrefix('ori', 'land', 'orirun land', 24, false);
	addAnimationByPrefix('ori', 'bash', 'orirun bash', 10, false);

	addLuaSprite('ori', true);
	scaleObject('ori', 2, 2);

	objectPlayAnimation('ori', 'idle');
	setProperty('ori' .. '.offset.x', oriidleoffsets[1]);
	setProperty('ori' .. '.offset.y', oriidleoffsets[2]);
	setObjectOrder('ori',6);
	setObjectOrder('bashthing',2);

	canhelp = true

end
local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function opponentNoteHit(id, direction, noteType, isSustainNote)
	runTimer('oriwillIdle', 0.1, 7);

	if not isSustainNote and not bfgrabb then
		objectPlayAnimation('ori', singAnims[direction + 1], true);

		if direction == 0 then
			setProperty('ori' .. '.offset.x', orileftoffsets[1]);
			setProperty('ori'.. '.offset.y', orileftoffsets[2]);
		elseif direction == 1 then
			setProperty('ori'.. '.offset.x', oridownoffsets[1]);
			setProperty('ori'.. '.offset.y', oridownoffsets[2]);
		elseif direction == 2 then
			setProperty('ori'.. '.offset.x', oriupoffsets[1]);
			setProperty('ori'.. '.offset.y', oriupoffsets[2]);
		elseif direction == 3 then
			setProperty('ori'.. '.offset.x', orirightoffsets[1]);
			setProperty('ori'.. '.offset.y', orirightoffsets[2]);
		end
	end
end

function onUpdate()
	if not mechanicsbitch then
	canhelp = false
	end

	setProperty('gloweffect.x', getProperty('ori.x') + 300)
	setProperty('gloweffect.y', getProperty('ori.y'))
	if getProperty('health') <= 2 and (keyJustPressed('space') and canhelp) then
		objectPlayAnimation('countdown', 'no');
		canhelp = false
		curhealth = getProperty('health')
		setProperty('health', 0.1)
		safety = true
		--runTimer('origrab', 0.1, 19)
		doTweenX('OriGrab', 'ori',  getProperty('bf.x') - 700, 0.5);
		bettersafety = false
	end
	if safety then
		setProperty('health', curhealth)
	end
	if bettersafety then
		setProperty('health', 2)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	if tag == 'oriwillIdle' and not bfgrabb then
		if loopsLeft == 0 then
			objectPlayAnimation('ori', 'idle');
			setProperty('ori' .. '.offset.x', oriidleoffsets[1]);
			setProperty('ori' .. '.offset.y', oriidleoffsets[2]);
		end
	end
	if tag == 'grasscomeback' then
		objectPlayAnimation('grass', 'return');
		
	end
	if tag == 'grassReturn' then
		objectPlayAnimation('grass', 'scroll');
	end
	if tag == 'gonnadrop' then
		doTweenY('Orijumpdown', 'ori',  100, 0.45, "cubeIn");
		doTweenX('bashmove', 'bashthing', -5000, .9)
	end
	if tag == 'gonnadropend' then
		doTweenY('Orijumpdownend', 'ori',  100, 0.45, "cubeIn");

	end
end
function onTweenCompleted(tag)
	--tweens for grabbing bf for bashes and saves
	if tag == 'OriGrabBash' then
		doTweenColor('glowtween', 'gloweffect', 'FF9600', 0.01);
		playSound('seinBashStartA')
		playSound('beep', 0.5)
		setProperty('bf.visible', false);
		objectPlayAnimation('grass', 'end');
		objectPlayAnimation('ori', 'bash');
		doTweenY('Orijumpup', 'ori',  -150, 0.5, "cubeOut");
		runTimer('gonnadrop', 0.35)
		doTweenX('OriBackBash', 'ori',  0, 0.8);
		bfgrabb = true
		bettersafety = true
		safety = false
	end
	if tag == 'OriBackBash' then
		doTweenColor('glowtween', 'gloweffect', 'FFFFFF', 0.01);
		playSound('dah', 1)
		playSound('seinBashEnd'..tostring(math.random(1,3)))
		doTweenX('EndOriBackBash', 'ori',  600, 0.5);
		doTweenY('Orijumpup', 'ori',  -400, 0.5, "cubeOut");
		objectPlayAnimation('ori', 'launch');
		objectPlayAnimation('bashthing', 'bashed');
		runTimer('gonnadropend', 0.4)
		runTimer('grasscomeback', 0.6)
		runTimer('grassReturn', 0.85)
	end
	if tag == 'Orijumpdownend' then
		objectPlayAnimation('countdown', 'yes')
		canhelp = true

		setProperty('bf.y',690);
		setProperty('bf.visible', true);
		playSound('bflandgrass');
		bettersafety = false
		bfgrabb = false
		objectPlayAnimation('ori', 'idle');
		objectPlayAnimation('countdown', '0')
		canhelp = true
	end
	if tag == 'bashmove' then
		setProperty('bashthing.x', 0)
	end
	if tag == 'OriGrab' then
		playSound('beep', 0.5)
		doTweenY('bfpickup', 'bf',  580, 0.1);
	end
	if tag == 'bfpickup' then
		doTweenX('OriBack', 'ori',  600, 2);
		setProperty('bf.visible', false);
		bettersafety = true
		safety = false
		bfgrabb = true
		objectPlayAnimation('ori', 'grab');
		setProperty('ori' .. '.offset.x', origraboffsets[1]);
		setProperty('ori' .. '.offset.y', origraboffsets[2]);
	end
	if tag == 'OriBack' then
		bettersafety = false
		setProperty('health', 2)
		bfgrabb = false
		objectPlayAnimation('ori', 'idle');
		setProperty('ori' .. '.offset.x', oriidleoffsets[1]);
		setProperty('ori' .. '.offset.y', oriidleoffsets[2]);
		setProperty('bf.visible', true);
		doTweenY('bfsetdown', 'bf',  690, 0.1);
	end
	if tag == 'bfsetdown' then
		playSound('bflandgrass')
	end
end
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'ori-note' and not isSustainNote then
		canhelp = false
		curhealth = getProperty('health')
		safety = true
		doTweenX('OriGrabBash', 'ori',  getProperty('bf.x') - 500, 0.5);
	end
end
function onEvent(name)
	if name == 'sidescroll' then
		objectPlayAnimation('countdown', 'yes');
		canhelp = true
	end
	if name == 'upscroll' then
		objectPlayAnimation('countdown', 'no');
		canhelp = false
	end
end