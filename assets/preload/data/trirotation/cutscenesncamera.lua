allowCountdown = false
allowEnd = false
numberofannoys = 0
x = 0
y = -100
colorchange = '2B2B2B'
bgcolorchange = '121212'
tweentime = 1

local xx = 620; -- Code to change the position of the camera to the left or right for your opponent, Less = Left (They can be negative numbers), More = Right
local yy = 650; -- Code to change the position of the camera up or down for the enemy Less = Down (They can be negative numbers), More = Up
local xx2 = 1000; -- Same code as above, but for boyfriend left, right
local yy2 = 700; -- Same code as above, but for boyfriend up, down
local xx3 = 1250; -- Same code as above, but for ori left, right
local yy3 = 750; -- Same code as above, but for ori up, down

local ofs = 15; -- Code to adjust the intensity with which the camera moves, the more numbers, the more intense, and the fewer numbers, less intense
local followchars = false; 

function onStartCountdown()
	if not isStoryMode then
	playMusic('rainloop', 1, true)
	playSound('scarynoisething', 0.4)
	end
	--if isStoryMode then
		setProperty('gf.x', 250)
		setProperty('gf.y', -1000)
	--end
	if not allowCountdown and isStoryMode and not seenCutscene then
			triggerEvent('Camera Follow Pos', getProperty('boyfriend.x')-380, 600);
			setPropertyLuaSprite('gloweffectori', 'alpha', 0)
			playMusic('still', 1, true)
			setProperty('rain1.alpha', 0)
			setProperty('rain2.alpha', 0)
			setProperty('ori.visible', false)
			addCharacterToList('cutscenebf', 'bf');
			addCharacterToList('cutsceneori', 'dad');
			setProperty('scoreTxt.visible', false);
			setProperty('judgementCounter.visible', false);
			setProperty('songWatermark.visible', false);
			setProperty('creditsWatermark.visible', false);
			setProperty('healthBar.visible', false);
			setProperty('healthBarBG.visible', false);
			setProperty('iconP1.visible', false);
			setProperty('iconP2.visible', false);

			triggerEvent('Change Character', 1, 'cutsceneori');
			triggerEvent('Change Character', 0, 'cutscenebf');
			characterPlayAnim('boyfriend', 'sleep', true);
			characterPlayAnim('dad', 'sleep', true);
			setProperty('boyfriend.x', 550);
			setProperty('boyfriend.y', 200);
			setProperty('dad.x', -800);
			setProperty('dad.y', 200);
			setProperty('dad.scale.x', 1);
			setProperty('dad.scale.y', 1);


			makeLuaSprite('orihouse','nibel/orihouse',-150,100)
			setProperty('orihouse.scale.x', 2);
			setProperty('orihouse.scale.y', 2);
			addLuaSprite('orihouse',false)

			makeLuaSprite('orihouseglow','nibel/orihouselighting',-150,100)
			setProperty('orihouseglow.scale.x', 2);
			setProperty('orihouseglow.scale.y', 2);
			addLuaSprite('orihouseglow',false)
			setObjectOrder('orihouseglow',21);
			setObjectOrder('orihouse',10);

			makeLuaSprite('orihouseglowevil','nibel/orihousebadlighting',-150,100)
			setProperty('orihouseglowevil.scale.x', 2);
			setProperty('orihouseglowevil.scale.y', 2);
			addLuaSprite('orihouseglowevil',false)
			setObjectOrder('orihouseglowevil',20);
			setProperty('orihouseglowevil.visible', false)

			makeAnimatedLuaSprite('interact', 'iconstuff', 540, 0);
			addAnimationByPrefix('interact', 'no', 'interact no', 1, false);
			addAnimationByPrefix('interact', 'yes', 'interact yes', 1, false);
			setObjectCamera('interact','camHud')
			updateHitbox('interact')
			addLuaSprite('interact', false);
			setProperty('interact.alpha', 0);
			scaleObject('interact', 0.7, 0.7);
			objectPlayAnimation('interact', 'no')

			makeAnimatedLuaSprite('left', 'iconstuff', 340, 0);
			addAnimationByPrefix('left', 'left', 'left', 1, false);
			setObjectCamera('left','camHud')
			updateHitbox('left')
			addLuaSprite('left', false);
			setProperty('left.alpha', 0);
			scaleObject('left', 0.7, 0.7);

			makeAnimatedLuaSprite('right', 'iconstuff', 740, 0);
			addAnimationByPrefix('right', 'right', 'right', 1, false);
			setObjectCamera('right','camHud')
			updateHitbox('right')
			addLuaSprite('right', false);
			setProperty('right.alpha', 0);
			scaleObject('right', 0.7, 0.7);

			makeLuaSprite('location','assfart',240,450)
			setProperty('location.scale.x', 0.4);
			setProperty('location.scale.y', 0.4);
			setObjectCamera('location','camHud')
			setProperty('location.alpha', 0);
			addLuaSprite('location',false)

			doTweenZoom('camunzoom', 'camGame', 0.5, 4, 'cubeInOut')

			
			runTimer('idle')
			canIdle = false
			onRock = true
		


			allowCountdown = true;
			return Function_Stop;
	end
	followchars = true
	return Function_Continue;
end
function onEndSong()
	if not allowEnd and curBeat > 0 then
		doTweenY('gfsquish', 'gf', 300, 0.2)
		allowEnd = true
		return Function_Stop
	end
	return Function_Continue
end

function onTweenCompleted(tag)
	if tag == 'gfsquish' then
		playSound('slam')
		runTimer('endSongStuff', 1, 2)
		triggerEvent('Screen Shake', '0.5, 0.1', 'game')
		setProperty('dad.visible', false)

		doTweenAlpha('raingone', 'rain2', 0, 1);
		doTweenAlpha('raingone1', 'rain1', 0, 1);
		doTweenColor('bfColorTween', 'boyfriend', 'FFFFFF', 1);
		doTweenColor('gfColorTween', 'gf', 'FFFFFF', 1);
		doTweenAlpha('gloweffectTween', 'gloweffect', 0, 1);
		doTweenColor('bgColorTween3', 'tree', 'FFFFFF', 1);
		doTweenColor('bgColorTween4', 'thing', 'FFFFFF', 1);
		doTweenColor('bgColorTween5', 'mountains', 'FFFFFF', 1);
		doTweenColor('bgColorTween6', 'bushes', 'FFFFFF', 1);
		doTweenColor('bgColorTween7', 'grass', 'FFFFFF', 1);
		doTweenColor('forebgColorTween', 'treeeees', 'FFFFFF', 1);
		doTweenAlpha('bgundie', 'bg', 1, 1);
	end
	if tag == 'camunzoom' then
		characterPlayAnim('boyfriend', 'getup', true);
		canMove = true
		playSound('beep')
		setProperty('right.alpha', 0.8);
		setProperty('left.alpha', 0.8);
		setProperty('interact.alpha', 0.8);
		setProperty('location.alpha', 1);
		runTimer('assfart', 1, 5)
	end
	if tag == 'boyfriendfall' then
		setProperty('right.alpha', 0);
		setProperty('left.alpha', 0);
		setProperty('interact.alpha', 0);
		characterPlayAnim('boyfriend', 'land', true);
		runTimer('getup', 2)
		playSound('bflandgrass')
	end
	if tag == 'orirunaway' then
		setProperty('dad.visible', false)
		canMove = true
		canIdle = true
	end
	if tag == 'walktoendcut' then
		if numberofannoys >= 4 then
			triggerEvent('Change Character', 0, 'bf-scared');
			objectPlayAnimation('boyfriend', 'hurt')
			cameraFlash('hud', '000000', 3, false)
			runTimer('lightning', 0.05, 3)
			playSound('lightning')
			setProperty('dad.visible', true)
			doTweenAlpha('raingone', 'rain2', 1, tweentime);
			doTweenAlpha('raingone1', 'rain1', 1, tweentime);
			doTweenColor('bfColorTween', 'boyfriend', colorchange, tweentime);
			doTweenColor('gfColorTween', 'gf', colorchange, tweentime);
			doTweenAlpha('gloweffectTween', 'gloweffect', 1, tweentime);
			doTweenAlpha('gloweffectoriTween', 'gloweffectori', 1, tweentime);
			doTweenColor('bgColorTween3', 'tree', bgcolorchange, tweentime);
			doTweenColor('bgColorTween4', 'thing', bgcolorchange, tweentime);
			doTweenColor('bgColorTween5', 'mountains', bgcolorchange, tweentime);
			doTweenColor('bgColorTween6', 'bushes', colorchange, tweentime);
			doTweenColor('bgColorTween7', 'grass', colorchange, tweentime);
			doTweenColor('forebgColorTween', 'treeeees', colorchange, tweentime);
			doTweenAlpha('bgdie', 'bg', 0, tweentime);
			setProperty('oriI.visible', false)
			setProperty('oriIw.visible', false)
			setProperty('oriIl.visible', false)
			
			setProperty('scoreTxt.visible', true);
			setProperty('healthBar.visible', true);
			setProperty('healthBarBG.visible', true);
			setProperty('iconP1.visible', true);
			setProperty('iconP2.visible', true);
			setProperty('dodgeI.visible', true);
			scaleObject('dodgeI', 0.8, 0.8);
			setProperty('creditsWatermark.visible', true);
			setProperty('judgementCounter.visible', true);
			setProperty('songWatermark.visible', true)
			followchars = true
			startCountdown()
		else
			objectPlayAnimation('boyfriend', 'idle')
			runTimer('endSongStuff', 1, 2)
		end
	end
	if tag == 'gffloatup' then
		doTweenY('bffloatup', 'boyfriend', -1000, 1, 'cubeIn')
		doTweenAngle('bfspeen', 'boyfriend', -180, 1, 'cubeIn')
		characterPlayAnim('boyfriend', 'surprise', true);
		playSound('beep')
	end
	if tag == 'bffloatup' then
		endSong()
	end
end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'endSongStuff' then
		if loopsLeft == 1 then
			objectPlayAnimation('boyfriend', 'hey')
			objectPlayAnimation('gf', 'cheer')
			objectPlayAnimation('ori', 'singUP')
			playSound('hey')
		else
			doTweenY('gffloatup', 'gf', -1000, 1, 'cubeIn')
			doTweenAngle('gfspeen', 'gf', 180, 1, 'cubeIn')
			triggerEvent('Change Character', 0, 'cutscenebf');
			objectPlayAnimation('boyfriend', 'idle')
		end
	end
	if tag == 'assfart' then
	if loopsLeft == 0 then
			setProperty('location.alpha', 0);
		end
	end
	if tag == 'idle' then
		if canIdle then
			if getProperty('boyfriend.x') == -399 and (numberofannoys == 3 or numberofannoys == 4) then
				characterPlayAnim('boyfriend', 'idleup', true);
			else
				characterPlayAnim('boyfriend', 'idle', true);
			end
		end
		runTimer('idle')
	end
	if tag == 'getup' then
		canMove = true
		characterPlayAnim('boyfriend', 'getup', true);
		onGrass = true
		setProperty('right.alpha', 0.8);
		setProperty('left.alpha', 0.8);
		setProperty('interact.alpha', 0.8);
	end
	if tag == 'quickIdle' then
		characterPlayAnim('boyfriend', 'stand', true);
		runTimer('willidle', 0.3)
	end
	if tag == 'quickIdleUp' then
		characterPlayAnim('boyfriend', 'standup', true);
		runTimer('willidle', 0.3)
	end
	if tag == 'willidle' then
		canIdle = true
	end
	if tag == 'oriIdle' then
		if oricanidle then
			characterPlayAnim('dad', 'idle', true);
			runTimer('oriIdle', 1)
		end
	end
	if tag == 'hugstop' then
		characterPlayAnim('dad', 'surprise', true);
		characterPlayAnim('boyfriend', 'surprise', true);
		setProperty('boyfriend.visible', true)
		runTimer('gonnarunaway',4)
		playSound('scarynoisething')
		triggerEvent('Screen Shake', '0.5, 0.05', 'game')
		numberofannoys = numberofannoys + 1
		setProperty('orihouseglowevil.visible', true)
		setProperty('orihouseglow.visible', false)
		playMusic('rainloop', 1, true)
	end
	if tag == 'hugstart' then
		setProperty('right.alpha', 0);
		setProperty('left.alpha', 0);
		setProperty('interact.alpha', 0);
		characterPlayAnim('dad', 'hug', true);
		runTimer('hugstop', 2)
		setProperty('boyfriend.visible', false)
	end
	if tag == 'gonnarunaway' then
		doTweenX('orirunaway', 'dad', 2450, 1)
		doTweenY('oriyaxisrun', 'dad', 400, 0.5, "cubeOut")
		characterPlayAnim('dad', 'walk', true);
		setProperty('right.alpha', 0.8);
		setProperty('left.alpha', 0.8);
		setProperty('interact.alpha', 0.8);
	end
	if tag == 'interactback' then
		if numberofannoys < 4 then --no I didn't code this in lmao
			caninteract = true
		end
	end

end
numberofannoys = 0
oricanidle = true
caninteract = true
function onUpdate()
	if onGrass then
		setProperty('boyfriend.y', -0.000090656684979*getProperty('boyfriend.x')*getProperty('boyfriend.x')+0.189685658869*getProperty('boyfriend.x')+703.987892531)
	end
	if (getProperty('boyfriend.x') > -120 and getProperty('boyfriend.x') < 1570 and (onGrass or onRock)) and canMove then
		triggerEvent('Camera Follow Pos', getProperty('boyfriend.x')+200, 600);
	end
	if getProperty('boyfriend.x') == -399 and caninteract then 
		objectPlayAnimation('interact', 'yes')
		if keyJustPressed('space') then
			caninteract = false
			runTimer('interactback', 1)
			objectPlayAnimation('interact', 'no')
			numberofannoys = numberofannoys + 1
			if numberofannoys < 3 then
				characterPlayAnim('boyfriend', 'singUP', true);
				characterPlayAnim('dad', 'annoy', true);
				playSound('beep')
				runTimer('quickIdle', 0.2)
				canIdle = false
			elseif numberofannoys == 3 then
				characterPlayAnim('boyfriend', 'singUPUP', true);
				characterPlayAnim('dad', 'surprise', true);
				playSound('dah')
				runTimer('quickIdleUp', 0.3)
				runTimer('oriIdle', 0.6)
				canIdle = false
			elseif numberofannoys == 4 then
				runTimer('hugstart', 0.3)
				playSound('orihapp')
				canIdle = false
				oricanidle = false
				canMove = false
				
			end
		end

	else
		objectPlayAnimation('interact', 'no')
	end
	if canMove then
		if onRock then
			if getProperty('boyfriend.x') > 840 then
				canMove = false
				characterPlayAnim('boyfriend', 'falling', true);
				doTweenY('boyfriendfall', 'boyfriend', 800, 0.2)
				onRock = false
				moveRight = false
				moveLeft = false
			end
			if getProperty('boyfriend.x') < 430 then
				setProperty('boyfriend.x', 431)
			end
		end
		if onGrass then
			if getProperty('boyfriend.x') > 3010 then
				
				canMove = false
				onGrass = false
				setProperty('ori.visible', true)
				if numberofannoys < 4 then
					setProperty('gf.x', 250)
					setProperty('gf.y', 300)
					setProperty('ori.visible', false)
				end
				
				
				setProperty('boyfriend.x', 2000);
				doTweenX('walktoendcut', 'boyfriend', 1110, 3)
				setProperty('boyfriend.y', 600);
				objectPlayAnimation('boyfriend', 'walk')
				setProperty('dad.x', 250);
				setProperty('dad.y', 280);
				scaleObject('dad', 1.4, 1.4)

				triggerEvent('Camera Follow Pos',1300,750)
				cameraFlash('hud', 'FFFFFF', 3, false)
				setProperty('camGame.zoom', 0.7)

				removeLuaSprite('orihouse')
				removeLuaSprite('orihouseglow')
				removeLuaSprite('orihouseglowevil')
				removeLuaSprite('interact')
				removeLuaSprite('left')
				removeLuaSprite('right')

				triggerEvent('Change Character', 1, 'evilori');
				
				setProperty('boyfriend.flipX', false);
				setProperty('dad.flipX', false);
				setProperty('dad.visible', false)


			end
			if getProperty('boyfriend.x') < -400 then
				setProperty('boyfriend.x', -399)
			end
		end
		if keyJustPressed('right') then
			characterPlayAnim('boyfriend', 'walk', true);
			setProperty('boyfriend.flipX', true);
			canIdle = false
			moveRight = true
		end
		if keyJustPressed('left') then
			characterPlayAnim('boyfriend', 'walk', true);
			setProperty('boyfriend.flipX', false);
			canIdle = false
			moveLeft = true
		end
		if keyReleased('right') then
			characterPlayAnim('boyfriend', 'stand', true);
			setProperty('boyfriend.flipX', true);
			canIdle = true
			moveRight = false
		end
		if keyReleased('left') then
			characterPlayAnim('boyfriend', 'stand', true);
			setProperty('boyfriend.flipX', false);
			canIdle = true
			moveLeft = false
		end

		if moveRight then
			doTweenX('bfmoveright', 'boyfriend', getProperty('boyfriend.x')+20, 0.05)
		end
		if moveLeft then
			doTweenX('bfmoveleft', 'boyfriend', getProperty('boyfriend.x')-20, 0.05)
		end
	end

		if followchars == true then
        if mustHitSection == false then -- Code for the camera to follow the poses of your opponent
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else
                 -- Code for the camera to follow the poses of boyfriend and ori
		if bffocus then
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
		if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
	      if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
		if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
		else
		if getProperty('ori.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx3-ofs,yy3)
            end
            if getProperty('ori.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx3+ofs,yy3)
            end
            if getProperty('ori.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx3,yy3-ofs)
            end
            if getProperty('ori.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx3,yy3+ofs)
            end
		if getProperty('ori.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx3,yy3)
            end
		end
        end
    end
end


bffocus = true
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == '' then
		bffocus = true
	end
	if noteType == 'ori' then
		bffocus = false
	end
end

