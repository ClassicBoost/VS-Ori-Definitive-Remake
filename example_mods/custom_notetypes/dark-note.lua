function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'dark-note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'extra/darknote');
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashDisabled', true);
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); 
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end

function onCreatePost()
	makeAnimatedLuaSprite('dodgeI', 'iconstuff', 1000, 100);
	addAnimationByPrefix('dodgeI', 'yes', 'dodge yes', 1, false);
	addAnimationByPrefix('dodgeI', 'no', 'dodge no', 1, false);
	setObjectCamera('dodgeI','camHud')
	updateHitbox('dodgeI')
	addLuaSprite('dodgeI', false);
	setProperty('dodgeI.alpha', 0.8);
	scaleObject('dodgeI', 0.7, 0.7);
	objectPlayAnimation('dodgeI', 'no')
	if isStoryMode and not seenCutscene then 
		setProperty('dodgeI.visible', false)
	end
	makeLuaSprite('tracer', 'nibel/arrowtracer', 4000, 800)
	setProperty('tracer.scale.x', 1.2)
	setProperty('tracer.scale.y', 1.2)
	addLuaSprite('tracer', true);
	makeLuaSprite('eff','niwen/thefunnyeffect', 0, 0)
	setGraphicSize('eff',1280,720)
	setObjectCamera('eff','camHud')
	updateHitbox('eff')
	setBlendMode('eff','multiply')
	setProperty('eff.alpha', 0)
	addLuaSprite('eff', false);
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'dark-note' then
		triggerEvent('Add Camera Zoom', '.05', '0');
		characterPlayAnim('boyfriend', 'hurt', true);
		setProperty('boyfriend.specialAnim', true);
		playSound('owe', 0.8);
		doTweenColor('undark', 'boyfriend', '000000', 0.01)
		doTweenAlpha('effback', 'eff', 1, 0.01)
		runTimer('darkness', 2)
		setProperty('boyfriend.stunned', true)
		if difficulty == 1 then
		health = getProperty('health')
		setProperty('health', getProperty('health')-69); -- I would set to 2 since that's the max hp but ehh, it's cool
		end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'darkness' then
		doTweenColor('undark', 'boyfriend', '2B2B2B', 1)
		doTweenAlpha('effback', 'eff', 0, 1)
		setProperty('boyfriend.stunned', false)
	end
	if tag == 'abouttashoot' then
		objectPlayAnimation('dad', 'aim', true);
		setProperty('dad.specialAnim', true);
		if loopsLeft == 0 then
			objectPlayAnimation('dodgeI', 'no')
			scaleObject('dodgeI', 0.7, 0.7);
			spacebarable = false
			playSound('bowshoot'..tostring(math.random(1,3)), 0.6) 
			objectPlayAnimation('dad', 'shoot', true);
			setProperty('dad.specialAnim', true);
			setProperty('tracer.x', 300)
			doTweenX('tracershooooot', 'tracer', 4000, 0.1)
			if urded then
				if difficulty == 1 then
					setProperty('health', -1);
				else
					triggerEvent('Add Camera Zoom', '.2', '0');
					setProperty('health', getProperty('health')-0.4);
					playSound('owe', 0.6);
					playSound('finn-hurt', 1);
					playSound('Fail', 1);
					stopSound('Warning');
					characterPlayAnim('boyfriend', 'hurt', true); --ouchie
					setProperty('boyfriend.specialAnim', true);
					doTweenColor('undark', 'boyfriend', '000000', 0.01)
					doTweenAlpha('effback', 'eff', 1, 0.01)
					runTimer('darkness', 2)
					setProperty('boyfriend.stunned', true)
				end
			else
				anim = math.random(1,4)
				if anim == 1 then
					characterPlayAnim('boyfriend', 'dodgeLEFT', true);
				elseif anim == 2 then 
					characterPlayAnim('boyfriend', 'dodgeUP', true);
				elseif anim == 3 then 
					characterPlayAnim('boyfriend', 'dodgeDOWN', true);
				else 
					characterPlayAnim('boyfriend', 'dodgeRIGHT', true);
				end
				playSound('Success', 1);
				stopSound('Warning');
				setProperty('boyfriend.specialAnim', true);
				triggerEvent('Screen Shake','0.1,0.015')
				
			end
		end	
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'dark-note' then
		objectPlayAnimation('dodgeI', 'yes')
		scaleObject('dodgeI', 0.8, 0.8);
		playSound('WARNING', 1);
		playSound('bowpull'..tostring(math.random(1,3)), 1)
		playSound('bowpull'..tostring(math.random(1,3)), 1)
		if mechanicsbitch then
			urded = true
		else
			urded = false
		end
		runTimer('abouttashoot', 0.01, 70);
		spacebarable = true
	end

end

function onUpdate()
	if spacebarable then
		if keyJustPressed('space') then
			scaleObject('dodgeI', 0.7, 0.7);
			objectPlayAnimation('dodgeI', 'no')
			urded = false
			spacebarable = false
		end
	end
end
