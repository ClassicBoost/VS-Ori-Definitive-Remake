	function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Fire Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'troll' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'extra/troll'); --Change texture --Change note splash texture

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Lets Opponent's instakill notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has no penalties
			else
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'troll' then
		health = getProperty('health')
		playSound('hankshoot', 1);
		setProperty('health', getProperty('health')-3); -- To make the achievement possible you take 8 damage.
end
end