glowfollow = false
function onStartCountdown()
	if not allowCountdown then
		
		addCharacterToList('cutscenebf', 'bf');
		addCharacterToList('cutsceneori', 'dad');
		if not seenCutscene then
		
			setProperty('scoreTxt.visible', false);
			setProperty('healthBar.visible', false);
			setProperty('healthBarBG.visible', false);
			setProperty('iconP1.visible', false);
			setProperty('iconP2.visible', false);

			triggerEvent('Change Character', 1, 'cutsceneori');
			triggerEvent('Change Character', 0, 'cutscenebf');
			characterPlayAnim('boyfriend', 'falling', false);
			characterPlayAnim('dad', 'sleep', true);
			setProperty('boyfriend.y', -1000);
			setProperty('gf.y', -1000);

			setProperty('inCutscene', true);
			runTimer('startCutscene', 2);
			allowCountdown = true;
			return Function_Stop;
		end
	end
	allowCountdown = false
	return Function_Continue;
end

function onEndSong()
	if not allowCountdown and isStoryMode then
		glowfollow = true
		allowCountdown = true
		setProperty('inCutscene', true);
		setProperty('boyfriend.visible', false)
		triggerEvent('Change Character', 1, 'cutsceneori');
		triggerEvent('Change Character', 0, 'cutscenebf');
		doTweenColor('bfColorTween', 'boyfriend', '5B5E7D', 0.01);
		characterPlayAnim('dad', 'walk', true);
		doTweenX('oriwalkaway', 'dad', -1000, 0.5)
		playSound('oriwalk', 1, 'stop')
		setProperty('dad.flipX', true)
		return Function_Stop;
	end
	return Function_Continue;
end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startCutscene' then
		doTweenY('bfWalk', 'boyfriend', 650, 0.5)
		
	end
	if tag == 'bfidle' then
		characterPlayAnim('boyfriend', 'idle', true);
		if loopsLeft == 4 then
			characterPlayAnim('boyfriend', 'singUP', false);
			characterPlayAnim('dad', 'annoy', false);
			playSound('beep');
			runTimer('quickidle', 0.2)
			
		end
		if loopsLeft == 3 then
			doTweenY('gfland', 'gf', 300, 0.4)
			characterPlayAnim('dad', 'check', false);
		end
		if loopsLeft == 1 then
			characterPlayAnim('boyfriend', 'hey', false);
			playSound('dah');
		end
		if loopsLeft == 0 then
			triggerEvent('Change Character', 0, 'altbf');
			triggerEvent('Change Character', 1, 'ori');
			startCountdown()
			setProperty('scoreTxt.visible', true);
			setProperty('healthBar.visible', true);
			setProperty('healthBarBG.visible', true);
			setProperty('iconP1.visible', true);
			setProperty('iconP2.visible', true);
		end
	end
	if tag == 'quickidle' then
		characterPlayAnim('boyfriend', 'stand', false);
	end
	if tag == 'quickidleup' then
		characterPlayAnim('boyfriend', 'standup', false);
	end
	if tag == 'bfendidle' then
		characterPlayAnim('boyfriend', 'idleup', true);
		if loopsLeft == 0 then
			characterPlayAnim('boyfriend', 'singUPUP', false);
			playSound('beep');
			runTimer('quickidleup', 0.2)
			runTimer('gfapprove', 1)
			runTimer('bfleave', 2)
		end
	end
	if tag == 'bfleave' then
		setProperty('boyfriend.flipX', false)
		characterPlayAnim('boyfriend', 'walk', true);
		doTweenX('bfwalkaway', 'boyfriend', -1000, 1.5)
		playSound('ilikeyacutg')
	end
	if tag == 'gfapprove' then
		characterPlayAnim('girlfriend', 'cheer', true);
		playSound('hey')
	end
	if tag == 'gfcry' then
		characterPlayAnim('girlfriend', 'sad', true);
		if loopsLeft == 0 then
			setProperty('inCutscene', false);
			endSong()
		end
	end
	if tag == 'wait' then
		doTweenX('bfwalktogf', 'boyfriend', 300, 1)
		playSound('ilikeyacutg')
		characterPlayAnim('boyfriend', 'walk', true);
	end
	if tag == 'getup' then
		characterPlayAnim('boyfriend', 'getup', true);
		runTimer('bfidle', 0.7, 5);
	end
end

function onTweenCompleted(tag)
	if tag == 'bfWalk' then
		characterPlayAnim('boyfriend', 'land', true);
		runTimer('getup', 2)
		playSound('bflandgrass')
	end
	if tag == 'gfland' then
		playSound('slam');
		triggerEvent('Screen Shake','0.5,0.05')
		characterPlayAnim('dad', 'surprise', false);
	end
	if tag == 'oriwalkaway' then
		glowfollow = false
		stopSound('stop')
		runTimer('wait', 1.5)
		
	end
	if tag == 'bfwalktogf' then
		characterPlayAnim('boyfriend', 'idleup', true);
		setProperty('boyfriend.flipX', true)
		runTimer('bfendidle', 0.6, 3)
	end
	if tag == 'bfwalkaway' then
		runTimer('gfcry', 0.5, 3)
	end
end
function onUpdate()
	if glowfollow then
		setProperty('gloweffect.x', getProperty('dad.x')-300)
	end
end