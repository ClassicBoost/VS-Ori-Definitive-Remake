local allowCountdown = false
function onStartCountdown()
	didcut = false
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown then
		runTimer('startCutscene', 0.8);
		setProperty('dad.y', -10000)
		allowCountdown = true;
		return Function_Stop;
	end
	
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startCutscene' then -- Timer completed, play cutscene
		doTweenY('bird', 'dad', -700, 0.3)
		characterPlayAnim('boyfriend', 'scared', true);
	end
	if tag == 'screm' then
		characterPlayAnim('boyfriend', 'hurt', true);
		characterPlayAnim('gf', 'scared', true);
		characterPlayAnim('dad', 'singUP', false);
		triggerEvent('Screen Shake','1,0.1')
		runTimer('startgaem',2)
		playSound('birdscrem')
	end
	if tag == 'startgaem' then
		doTweenAlpha('oyesnodarkness', 'eff2', 0, 10)
		startCountdown()
	end
end

function onTweenCompleted(tag)
	if tag == 'bird' then
		doTweenAlpha('oshetdarkness', 'eff2', 1, 0.5)
		playSound('slam')
		triggerEvent('Screen Shake','0.3,0.1')
		characterPlayAnim('dad', 'singDOWN', false);
		runTimer('screm', 0.9)
	end
end