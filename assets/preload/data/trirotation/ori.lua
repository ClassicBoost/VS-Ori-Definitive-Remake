-- script by ItsCapp don't steal, it's dumb

canIdle = true

-- simply, offsets. they're the numbers in the top left of the character editor
idleoffsets = {'1', '-5'} -- I recommend you have your idle offset at 0
leftoffsets = {'89', '50'}
downoffsets = {'29', '4'}
upoffsets = {'84', '60'}
rightoffsets = {'-118', '48'}

-- change all of these to the name of the animation in your character's xml file
idle_xml_name = 'ori idle0'
scared_xml_name = 'ori-scared idle'
left_xml_name = 'ori right0'
down_xml_name = 'ori down0'
up_xml_name = 'ori up0'
right_xml_name = 'ori left0'
leftmiss_xml_name = 'ori right miss0'
downmiss_xml_name = 'ori down miss0'
upmiss_xml_name = 'ori up miss0'
rightmiss_xml_name = 'ori left miss0'

-- basically horizontal and vertical positions
x_position = 1200
y_position = 500

-- scales your character (set to 1 by default)
xScale = 0.8
yScale = 0.8

-- invisible character (so basically if you wanna use the change character event, you need to make the second character invisible first)
invisible = false

-- pretty self-explanitory
name_of_character_xml = 'ori_assets'
name_of_character = 'ori'
name_of_notetype = 'ori'

-- if it's set to true the character appears behind the default characters, including gf, watch out for that
foreground = true
playablecharacter = true -- change to 'true' if you want to flipX



function onCreate()

	makeLuaSprite('gloweffectori','nibel/origlow', x_position-200,y_position-200)
	--setProperty('gloweffectori.alpha', 1)
	
	makeAnimatedLuaSprite(name_of_character, 'characters/' .. name_of_character_xml, x_position, y_position);

	addAnimationByPrefix(name_of_character, 'idle', idle_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singLEFT', left_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singDOWN', down_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singUP', up_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'scared', scared_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singRIGHT', right_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singUPmiss', upmiss_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singDOWNmiss', downmiss_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singLEFTmiss', leftmiss_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singRIGHTmiss', rightmiss_xml_name, 24, false);

	if playablecharacter == true then
		setPropertyLuaSprite(name_of_character, 'flipX', true);
	else
		setPropertyLuaSprite(name_of_character, 'flipX', false);
	end

	scaleObject(name_of_character, xScale, yScale);


	objectPlayAnimation(name_of_character, 'idle');
	addLuaSprite(name_of_character, foreground);
	addLuaSprite('gloweffectori', true)
	if invisible == true then
		setPropertyLuaSprite(name_of_character, 'alpha', 0)
	end
end

local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == name_of_notetype then
		objectPlayAnimation(name_of_character, singAnims[direction + 1], false);

		if direction == 0 then
			setProperty(name_of_character .. '.offset.x', leftoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
			end
		elseif direction == 1 then
			setProperty(name_of_character .. '.offset.x', downoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
			end
		elseif direction == 2 then
			setProperty(name_of_character .. '.offset.x', upoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
			end
		elseif direction == 3 then
			setProperty(name_of_character .. '.offset.x', rightoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
			end
		end
	end
end

-- I know this is messy, but it's the only way I know to make it work on both sides.
local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == name_of_notetype then
		canIdle = false
		runTimer('gonnaidle', 0.1)
		
		objectPlayAnimation(name_of_character, singAnims[direction + 1], false);

		if direction == 0 then
			setProperty(name_of_character .. '.offset.x', leftoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftoffsets[2]);
		elseif direction == 1 then
			setProperty(name_of_character .. '.offset.x', downoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downoffsets[2]);
		elseif direction == 2 then
			setProperty(name_of_character .. '.offset.x', upoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upoffsets[2]);
		elseif direction == 3 then
			setProperty(name_of_character .. '.offset.x', rightoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightoffsets[2]);
		end
	end
end

--miss animation
local singAnimsmiss = {"singLEFTmiss", "singDOWNmiss", "singUPmiss", "singRIGHTmiss"}
function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == name_of_notetype then
		canIdle = false
		runTimer('gonnaidle', 0.1)
		
		objectPlayAnimation(name_of_character, singAnimsmiss[direction + 1], false);

		if direction == 0 then
			setProperty(name_of_character .. '.offset.x', leftoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftoffsets[2]);
		elseif direction == 1 then
			setProperty(name_of_character .. '.offset.x', downoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downoffsets[2]);
		elseif direction == 2 then
			setProperty(name_of_character .. '.offset.x', upoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upoffsets[2]);
		elseif direction == 3 then
			setProperty(name_of_character .. '.offset.x', rightoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightoffsets[2]);
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'gonnaidle' then
		canIdle = true
	end
end

function onBeatHit()
	-- triggered 4 times per section
	if curBeat % 2 == 0 and canIdle then
		objectPlayAnimation(name_of_character, 'idle');
		setProperty(name_of_character .. '.offset.x', idleoffsets[1]);
		setProperty(name_of_character .. '.offset.y', idleoffsets[2]);
	end
end

function onCreatePost()
	objectPlayAnimation(name_of_character, 'idle');
	setProperty(name_of_character .. '.offset.x', idleoffsets[1]);
	setProperty(name_of_character .. '.offset.y', idleoffsets[2]);
end