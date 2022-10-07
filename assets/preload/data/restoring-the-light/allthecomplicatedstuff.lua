local allowCountdown = false




function onStartCountdown()
	
	if not allowCountdown and not seenCutscene then
		--this entire function is for cutscene code
		playSound('tension', 1, 'stoptension')
		playSound('rumble', 1, 'stop')
		setProperty('bf.visible', false)

		damageovertime = 0
		
		makeAnimatedLuaSprite('cutbg', 'nibel/gino/runbg', 0, 200)
		addAnimationByIndices('cutbg', 'stop', 'runbg scroll', '0', 1)
		addLuaSprite('cutbg', false)

		makeAnimatedLuaSprite('cutlight', 'nibel/gino/epiclight', -300, 0); 
		addAnimationByPrefix('cutlight', 'groove', 'coollight groove', 30, true)
		addLuaSprite('cutlight', false);
		scaleObject('cutlight', 1.2, 1.2);
		setProperty('cutlight.alpha', 0.5)
		
		makeAnimatedLuaSprite('cutgrass', 'nibel/gino/grass', 0, 300)
		addAnimationByIndices('cutgrass', 'stop', 'grass scroll', '0', 1)
		addLuaSprite('cutgrass', false)



		makeAnimatedLuaSprite('cutbashthing1', 'nibel/gino/bash-object',-800, -100);
		addAnimationByPrefix('cutbashthing1', 'bashed', 'bash-object bash', 24, false);
		addLuaSprite('cutbashthing1', false);
		scaleObject('cutbashthing1', 1.3, 1.3);
		setProperty('cutbashthing1.angle', 10)

		makeAnimatedLuaSprite('cutbashthing2', 'nibel/gino/bash-object', -700, 200);
		addAnimationByPrefix('cutbashthing2', 'bashed', 'bash-object bash', 24, false);
		addLuaSprite('cutbashthing2', false);
		scaleObject('cutbashthing2', 1.3, 1.3);
		setProperty('cutbashthing2.angle', -10)

		makeAnimatedLuaSprite('cutbashthing3', 'nibel/gino/bash-object', 200, -100);
		addAnimationByPrefix('cutbashthing3', 'bashed', 'bash-object bash', 24, false);
		addLuaSprite('cutbashthing3', false);
		scaleObject('cutbashthing3', 1.3, 1.3);
		setProperty('cutbashthing3.angle', -10)

		makeAnimatedLuaSprite('cutbashthing4', 'nibel/gino/bash-object', 200, 200);
		addAnimationByPrefix('cutbashthing4', 'bashed', 'bash-object bash', 24, false);
		addLuaSprite('cutbashthing4', false);
		scaleObject('cutbashthing4', 1.3, 1.3);
		setProperty('cutbashthing4.angle', 10)

		makeLuaSprite('balls', 'nibel/gino/balls', 250, 200)
		addLuaSprite('balls', false)

		setProperty('diewaterbot.visible', true)
		setProperty('diewaterbot1.visible', true)
		setProperty('diewaterbot.y', 300)
		setProperty('diewaterbot1.y', 450)
		setProperty('diewater.visible', false)

		makeAnimatedLuaSprite('startcutbf', 'characters/cutscene-bf', 970, 925);
		addAnimationByPrefix('startcutbf', 'lookup', 'BF quickidleup', 1, false)
		addAnimationByPrefix('startcutbf', 'lookbehind', 'cutscene-bf surprise', 15, false)
		addLuaSprite('startcutbf', true);

		objectPlayAnimation('startcutbf', 'lookup', false);
		
		scaleObject('startcutbf', 0.4, 0.4);

		
		makeAnimatedLuaSprite('cutori', 'characters/orirun', 1100, 220); 
		addAnimationByPrefix('cutori', 'run', 'orirun idle', 30, true)
		addAnimationByPrefix('cutori', 'bash', 'orirun bash', 10, false)
		addAnimationByPrefix('cutori', 'launch', 'orirun launch', 15, false)
		setProperty('cutori.flipX', true)
		addLuaSprite('cutori', true);
		scaleObject('cutori', 1.1, 1.1);
		objectPlayAnimation('cutori', 'run', false);
		runTimer('cutorirun', 3)

		allowCountdown = true;
		return Function_Stop;
	end
	if difficulty == 0 then
		damageovertime = 0.001
	elseif difficulty == 1 then
		damageovertime = 0.002
	elseif difficulty == 2 then
		damageovertime = 0.003
	end
	cameraFlash('hud', '000000', 500, false)
	return Function_Continue;
end
oricurposX = 200
oricurposY = -300
function rockcalc()
	--calculates a lot of numbers for where ori needs to fly and where the rocks need to fall for upscroll stuff
	if upscroll then
	
		rockX = math.random(50, 1100)
		rockY = math.random(400, 800)

		if oricurposX + 650 >= rockX then
			oriGotoX = rockX - 600
			setProperty('oripart2.flipX', true)
		
		else
			oriGotoX = rockX - 700
			setProperty('oripart2.flipX', false)
		end

		oriGotoY = rockY - 800
	
		setProperty('rockrockrock.x', rockX)
		setProperty('rockrockrock.y', rockY - 2000)
	
	
		doTweenY('rockfalltoori', 'rockrockrock', rockY, 0.8)

	


	
		if oricurposY + 800 >= rockY then
			doTweenY('Orijumprock', 'oripart2', oriGotoY - 300, 0.5, "cubeOut");
		else
			doTweenY('Orijumprock', 'oripart2', oricurposY - 300, 0.5, "cubeOut");
		end
		runTimer('droptorock', 0.35)
		doTweenX('Oritorock', 'oripart2',  oriGotoX, 0.8);

		oricurposX = oriGotoX
		oricurposY = oriGotoY
	end

end

function onCreate()
	running = true
	triggerEvent('Camera Follow Pos',1000,700)
	makeAnimatedLuaSprite('rain1','nibel/gino/NewRAINLayer01', 0, 0)
	addAnimationByPrefix('rain1', 'rain', 'RainFirstlayer instance 1', 30, true)
	setObjectCamera('rain1','camHud')
	updateHitbox('rain1')
	addLuaSprite('rain1', true);
	setProperty('rain1.visible', false)

	makeAnimatedLuaSprite('rain2','nibel/gino/NewRainLayer02', 0, 0)
	addAnimationByPrefix('rain2', 'rainn', 'RainFirstlayer instance 1', 30, true)
	setObjectCamera('rain2','camHud')
	updateHitbox('rain2')
	addLuaSprite('rain2', true);
	setProperty('rain2.visible', false)

	--start of upward travel stuff

	makeAnimatedLuaSprite('diewaterbot', 'nibel/gino/diewater', 0, 50); 
	addAnimationByPrefix('diewaterbot', 'fall', 'water water', 70, true)
	setProperty('diewaterbot.flipY', true)
	setObjectCamera('diewaterbot','camHud')
	addLuaSprite('diewaterbot', false);
	scaleObject('diewaterbot', 4, 4);
	setProperty('diewaterbot.angle', 90)

	makeAnimatedLuaSprite('diewaterbot1', 'nibel/gino/diewater', 0, 100); 
	addAnimationByPrefix('diewaterbot1', 'fall', 'water water', 60, true)
	setObjectCamera('diewaterbot1','camHud')
	addLuaSprite('diewaterbot1', false);
	scaleObject('diewaterbot1', 4, 4);
	setProperty('diewaterbot1.angle', 90)

	makeAnimatedLuaSprite('grassright', 'nibel/gino/grass', -400, -500); 
	addAnimationByPrefix('grassright', 'scroll', 'grass scroll', 300, true)
	addAnimationByPrefix('grassright', 'return', 'grass return', 300, false)
	addAnimationByPrefix('grassright', 'end', 'grass end', 300, false)
	addLuaSprite('grassright', false);
	setProperty('grassright.angle', 270)

	makeAnimatedLuaSprite('grassleft', 'nibel/gino/grass', -1450, -500); 
	addAnimationByPrefix('grassleft', 'scroll', 'grass scroll', 300, true)
	addAnimationByPrefix('grassleft', 'return', 'grass return', 300, false)
	addAnimationByPrefix('grassleft', 'end', 'grass end', 300, false)
	addLuaSprite('grassleft', false);
	setProperty('grassleft.angle', 90)
	setProperty('grassleft.flipX', true)

	makeAnimatedLuaSprite('rockrockrock', 'nibel/gino/r o c k', 50, 0); 
	addAnimationByPrefix('rockrockrock', 'rock', 'r o c k yeet', 30, false)
	addLuaSprite('rockrockrock', true);
	scaleObject('rockrockrock', 0.6, 0.6);

	makeAnimatedLuaSprite('rockrockrock2', 'nibel/gino/r o c k', 50, 0); 
	addAnimationByPrefix('rockrockrock2', 'rock', 'r o c k yeet', 30, false)
	addLuaSprite('rockrockrock2', true);
	scaleObject('rockrockrock2', 0.6, 0.6);

	makeAnimatedLuaSprite('oripart2', 'characters/orirun', 200, -300); 
	addAnimationByPrefix('oripart2', 'bash', 'orirun bash', 100, false);
	addAnimationByPrefix('oripart2', 'launch', 'orirun launch', 15, false);
	addLuaSprite('oripart2', true);
	scaleObject('oripart2', 1.3, 1.3);

	setProperty('grassright.visible', false)
	setProperty('grassleft.visible', false)
	setProperty('diewaterbot.visible', false)
	setProperty('diewaterbot1.visible', false)
	setProperty('rockrockrock.visible', false)
	setProperty('rockrockrock2.visible', false)
	setProperty('oripart2.visible', false)

	--end of upward travel stuff

	makeAnimatedLuaSprite('water', 'nibel/gino/water', 1800, 0); 
	addAnimationByPrefix('water', 'fall', 'water water', 100, true)
	--setObjectCamera('water','camHud')
	addLuaSprite('water', true);
	scaleObject('water', 4, 4);
	
end
function onCreatePost()
	setProperty('health', 2.0)
	triggerEvent('Camera Follow Pos',1000,700);
	objectPlayAnimation('water', 'fall', true);
	objectPlayAnimation('diewater', 'fall', true);
	objectPlayAnimation('grass', 'scroll', true);

	

	--end cutscene stuff

	makeLuaSprite('ginsotreetop','nibel/gino/escapo',-100,-1500)
	setProperty('ginsotreetop.scale.x', 1.2);
	setProperty('ginsotreetop.scale.y', 1.2);
	addLuaSprite('ginsotreetop', false);

	makeAnimatedLuaSprite('ginsowater', 'nibel/gino/waterburst', -300, -1600); 
	addAnimationByPrefix('ginsowater', 'boom', 'waterburst boom', 24, false)
	addLuaSprite('ginsowater', true);
	scaleObject('ginsowater', 1.2, 1.2);


	--uncomment for end cutscene testing
	--triggerEvent('Camera Follow Pos',1000,-1000)






	makeAnimatedLuaSprite('flying-bf', 'nibel/gino/bf-flying', 800, -700); 
	addAnimationByPrefix('flying-bf', 'nyoooom', 'bf-flying flying', 24, true)
	addAnimationByPrefix('flying-bf', 'oof', 'bf-flying thud', 24, false)
	addLuaSprite('flying-bf', true);
	scaleObject('flying-bf', 1.2, 1.2);

	makeAnimatedLuaSprite('flying-ori', 'nibel/gino/ori-flying', 800, -700); 
	addAnimationByPrefix('flying-ori', 'jump', 'ori-flying fly', 24, true)
	addAnimationByPrefix('flying-ori', 'flip', 'ori-flying flip', 15, false)
	addAnimationByPrefix('flying-ori', 'land', 'ori-flying land', 24, false)
	addAnimationByPrefix('flying-ori', 'realization', 'ori-flying realization', 24, false)
	addAnimationByPrefix('flying-ori', 'run', 'ori-flying run', 24, true)
	addAnimationByPrefix('flying-ori', 'help', 'ori-flying help', 24, false)
	addLuaSprite('flying-ori', true);
	scaleObject('flying-ori', 1.3, 1.3);

end
function onUpdate(elapsed)
	--used when bf and ori fly out of the ginso tree
	if crazycalcstuff then
		--three points were used to calculate the parabolas
		--(800, -700), (1087.5, -1300), (1375, -767.12)
		setProperty('flying-bf.y', 0.00685296030246*getProperty('flying-bf.x')*getProperty('flying-bf.x')-15.021919092*getProperty('flying-bf.x')+6931.64068053)
		--(800, -700), (490, -1400) ,(180, -910.82)
		setProperty('flying-ori.y', 0.00618720083247*getProperty('flying-ori.x')*getProperty('flying-ori.x')-5.72342455775*getProperty('flying-ori.x')-81.0688865765)
	end
end

function onBeatHit()
	--randomly run by waterfalls
	waterfallchance = math.random(0,10)
	if waterfallchance == 5 and upscroll == false then
		doTweenX('waterfallmove', 'water', -1000, 0.7)
	end
	--starts end cutscene
	if curBeat == 1 then
		triggerEvent('Camera Follow Pos',1000,650)
	end
	if curBeat == 416 then
		objectPlayAnimation('countdown', 'no')
		bettersafety = true
		setProperty('countdown.alpha', 0);
		crazycalcstuff = true
		running = false
		triggerEvent('Camera Follow Pos',1000,-1000)
		objectPlayAnimation('ginsowater', 'boom', true);
		setProperty('bg.visible', false)
		setProperty('water.visible', false)
		setProperty('diewater.visible', false)
		setProperty('bf.visible', false)
		setProperty('ori.visible', false)
		setProperty('rain1.visible', true)
		setProperty('rain1.visible', true)
		
		doTweenX('flyinnX', 'flying-bf', 1375, 2)
		doTweenX('OriflyinnX', 'flying-ori', 180, 1.5)
	end
	--rest are tags for the end cutscene
	if curbeat == 417 then
		objectPlayAnimation('ginsowater', 'boom', true);
	end
	if curBeat == 418 then
		objectPlayAnimation('flying-ori', 'flip', false)
	end
	if curBeat == 430 then
		objectPlayAnimation('flying-ori', 'realization', false)
		crazycalcstuff = false
	end
	if curBeat == 435 then
		objectPlayAnimation('flying-ori', 'run', true)
		doTweenX('runtobfX', 'flying-ori', 1150, 0.8)
	end
end
function onTweenCompleted(tag)
	--tweens used for upscrolls stuff
	if tag == 'Oritorock' and upscroll and getProperty('health') > -1 then
		playSound('seinBashEnd'..tostring(math.random(1,3)))
		objectPlayAnimation('oripart2', 'launch');
		objectPlayAnimation('rockrockrock2', 'rock');
		runTimer('bashready', 0.3)
		setProperty('rockrockrock2.x', getProperty('rockrockrock.x'))
		setProperty('rockrockrock2.y', getProperty('rockrockrock.y'))
		doTweenY('rockfalldown', 'rockrockrock2', rockY + 2000, 0.8)
		rockcalc()
		
		
	end
	--brings waterfall back when it passes the camera
	if tag == 'waterfallmove' then
		setProperty('water.x', 2000)
	end
	--end cutscene tags
	if tag == 'flyinnX' then
		objectPlayAnimation('flying-bf', 'oof', false);
		playSound('bflandgrass')
	end
	if tag == 'OriflyinnX' then
		objectPlayAnimation('flying-ori', 'land', false);
		playSound('bflandgrass')
	end
	if tag == 'runtobfX' then
		objectPlayAnimation('flying-ori', 'help', false);
	end
	--start cutscene tags
	if tag == 'cutoriruntobf' then
		removeLuaSprite('startcutbf')
		playSound('seinBashStartA')
		objectPlayAnimation('cutori', 'bash', false);
		doTweenY('cutoritofirstbashY', 'cutori', -50, 0.45, 'cubeOut')
		doTweenX('cutoritofirstbashX', 'cutori', -350, 0.5)
	end
	if tag == 'cutoritofirstbashX' then
		playSound('seinBashEnd'..tostring(math.random(1,3)))
		objectPlayAnimation('cutori', 'launch', false);
		objectPlayAnimation('cutbashthing2', 'bashed', false);
		doTweenY('cutoritosecondbashY', 'cutori', -350, 0.35, 'cubeOut')
		doTweenX('cutoritosecondbashX', 'cutori', -450, 0.4)
	end
	if tag == 'cutoritosecondbashX' then
		playSound('seinBashEnd'..tostring(math.random(1,3)))
		objectPlayAnimation('cutori', 'launch', false);
		objectPlayAnimation('cutbashthing1', 'bashed', false);
		setProperty('cutori.flipX', false)
		doTweenY('cutoritolastbashY', 'cutori', -700, 0.45, 'cubeOut')
		doTweenX('cutoritolastbashX', 'cutori', 0, 0.5)
	end
	if tag == 'cutoritolastbashX' then
		setProperty('diewater.visible', true)
		setProperty('bf.visible', true)
		setProperty('countdown.visible', true)
		
		removeLuaSprite('cutori')
		removeLuaSprite('cutlight')
		removeLuaSprite('cutgrass')
		removeLuaSprite('cutbg')
		removeLuaSprite('balls')
		removeLuaSprite('cutbashthing1')
		removeLuaSprite('cutbashthing2')
		removeLuaSprite('cutbashthing3')
		removeLuaSprite('cutbashthing4')
		
		doTweenY('watergonnakill' ,'diewaterbot', 50, 0.01)
		doTweenY('watergonnakill1' ,'diewaterbot1', 100, 0.01)
		setProperty('diewaterbot.visible', false)
		setProperty('diewaterbot1.visible', false)
		stopSound('stoptension')
		stopSound('stop')
		startCountdown()
		if difficulty == 0 then
			damageovertime = 0.001
		elseif difficulty == 1 then
			damageovertime = 0.002
		elseif difficulty == 2 then
			damageovertime = 0.003
		end
	end
end
function onTimerCompleted(tag)
	--animation and movement timers for upscroll
	if tag == 'bashready' then
		objectPlayAnimation('oripart2', 'bash', false);
	end
	if tag == 'droptorock' then
		doTweenY('Oridroprock', 'oripart2', oriGotoY, 0.5, "cubeIn");
	end
	--start cutscene timer
	if tag == 'cutorirun' then
		triggerEvent('Screen Shake', '4, 0.03', 'game')
		objectPlayAnimation('startcutbf', 'lookbehind', false);
		setProperty('startcutbf.x', 700)
		setProperty('startcutbf.y', 750)
		doTweenX('cutoriruntobf', 'cutori', 150, 0.5)
		doTweenY('watergonnakill' ,'diewaterbot', -300, 2)
		doTweenY('watergonnakill1' ,'diewaterbot1', -250, 2)
		playSound('beep', 0.5)
		
	end
end
function onEvent(name)
	--allows events that control visuals for sidescroll and upscroll
	if name == 'sidescroll' then
		running = true
		upscroll = false
		setProperty('bg.angle', 0)
		setProperty('bg.x', -300)
		setProperty('bg.y', 0)
		scaleObject('bg', 1.2, 1.2);

		setProperty('grass.visible', true)
		setProperty('diewater.visible', true)
		setProperty('ori.visible', true)
		setProperty('bf.visible', true)

		setProperty('grassright.visible', false)
		setProperty('grassleft.visible', false)
		setProperty('diewaterbot.visible', false)
		setProperty('diewaterbot1.visible', false)
		setProperty('rockrockrock.visible', false)
		setProperty('rockrockrock2.visible', false)
		setProperty('oripart2.visible', false)
	end
	if name == 'upscroll' then
		running = false
		upscroll = true
		objectPlayAnimation('countdown', 'no')
		setProperty('bg.angle', 270)
		setProperty('bg.x', -1300)
		setProperty('bg.y', -700)
		scaleObject('bg', 1.2, 1.6);

		setProperty('ori.visible', false)
		setProperty('bf.visible', false)

		setProperty('grass.visible', false)
		setProperty('diewater.visible', false)

		setProperty('grassright.visible', true)
		setProperty('grassleft.visible', true)
		setProperty('diewaterbot.visible', true)
		setProperty('diewaterbot1.visible', true)
		setProperty('rockrockrock.visible', true)
		setProperty('rockrockrock2.visible', true)
		setProperty('oripart2.visible', true)
		rockcalc()
	end
end

