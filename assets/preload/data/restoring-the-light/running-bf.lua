--bf needs to be made with a script since if you just use him as a character, his legs stay still during hold notes
idleoffsets = {'-5', '0'}
leftoffsets = {'5', '-6'}
downoffsets = {'-8', '-11'}
upoffsets = {'-6', '7'}
rightoffsets = {'-12', '-7'}

leftoffsetsmiss = {'-7', '-21'}
downoffsetsmiss = {'-1', '-27'}
upoffsetsmiss = {'-6', '-13'}
rightoffsetsmiss = {'6', '-27'}

scaredoffsets = {'-4', '0'}



function onCreate()
	makeAnimatedLuaSprite('bf', 'characters/NM_run_BF', 500, 690);

	addAnimationByPrefix('bf', 'idle', 'Run_cycle', 24, true);
	addAnimationByPrefix('bf', 'singLEFT', 'Leftt', 24, true);
	addAnimationByPrefix('bf', 'singDOWN', 'Down i', 24, true);
	addAnimationByPrefix('bf', 'singUP', 'Up i', 24, true);
	addAnimationByPrefix('bf', 'singRIGHT', 'Rightt', 24, true);

	addAnimationByPrefix('bf', 'scared', 'Run_When', 24, true);
	addAnimationByPrefix('bf', 'singLEFTmiss', 'Left Miss', 24, false);
	addAnimationByPrefix('bf', 'singDOWNmiss', 'Down Miss', 24, false);
	addAnimationByPrefix('bf', 'singUPmiss', 'Up Miss', 24, false);
	addAnimationByPrefix('bf', 'singRIGHTmiss', 'Right Miss', 24, false);

	objectPlayAnimation('bf', 'idle');
	setProperty('bf' .. '.offset.x', idleoffsets[1]);
	setProperty('bf' .. '.offset.y', idleoffsets[2]);


	addLuaSprite('bf', false);
end
local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	inIdle = false
	if not isSustainNote then
		objectPlayAnimation('bf', singAnims[direction + 1], true);

		if direction == 0 then
			setProperty('bf' .. '.offset.x', leftoffsets[1]);
			setProperty('bf'.. '.offset.y', leftoffsets[2]);
		elseif direction == 1 then
			setProperty('bf'.. '.offset.x', downoffsets[1]);
			setProperty('bf'.. '.offset.y', downoffsets[2]);
		elseif direction == 2 then
			setProperty('bf'.. '.offset.x', upoffsets[1]);
			setProperty('bf'.. '.offset.y', upoffsets[2]);
		elseif direction == 3 then
			setProperty('bf'.. '.offset.x', rightoffsets[1]);
			setProperty('bf'.. '.offset.y', rightoffsets[2]);
		end
	end
end
local singAnimsMiss = {"singLEFTmiss", "singDOWNmiss", "singUPmiss", "singRIGHTmiss"}
function noteMiss(id, direction, noteType, isSustainNote)
	inIdle = false

	objectPlayAnimation('bf', singAnimsMiss[direction + 1], true);

	if direction == 0 then
		setProperty('bf' .. '.offset.x', leftoffsetsmiss[1]);
		setProperty('bf'.. '.offset.y', leftoffsetsmiss[2]);
	elseif direction == 1 then
		setProperty('bf'.. '.offset.x', downoffsetsmiss[1]);
		setProperty('bf'.. '.offset.y', downoffsetsmiss[2]);
	elseif direction == 2 then
		setProperty('bf'.. '.offset.x', upoffsetsmiss[1]);
		setProperty('bf'.. '.offset.y', upoffsetsmiss[2]);
	elseif direction == 3 then
		setProperty('bf'.. '.offset.x', rightoffsetsmiss[1]);
		setProperty('bf'.. '.offset.y', rightoffsetsmiss[2]);
	end

end

healthy = true
inIdle = true
function onUpdate()
	--if invisible bf is idling then the script one can
	if getProperty('boyfriend.animation.curAnim.name') == "idle"..getProperty('boyfriend.idleSuffix') and inIdle == false then
		if getProperty('health') >= 1 then
			objectPlayAnimation('bf', 'idle');
			setProperty('bf' .. '.offset.x', idleoffsets[1]);
			setProperty('bf' .. '.offset.y', idleoffsets[2]);
			inIdle = true
		elseif getProperty('health') <= 1 then 
			objectPlayAnimation('bf', 'scared');
			setProperty('bf' .. '.offset.x', scaredoffsets[1]);
			setProperty('bf' .. '.offset.y', scaredoffsets[2]);
			inIdle = true
		end
	end
	if inIdle == true then
		if getProperty('health') >= 1 and healthy == false then
			objectPlayAnimation('bf', 'idle');
			setProperty('bf' .. '.offset.x', idleoffsets[1]);
			setProperty('bf' .. '.offset.y', idleoffsets[2]);
			healthy = true
		elseif getProperty('health') <= 1 and healthy == true then 
			objectPlayAnimation('bf', 'scared');
			setProperty('bf' .. '.offset.x', scaredoffsets[1]);
			setProperty('bf' .. '.offset.y', scaredoffsets[2]);
			healthy = false
		end
	end
	doTweenX('TweenX', 'bf',  getProperty('health')*500, 0.1);
	
end