function onCreate()
	precacheImage('nibel/orinotesplashes')
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'ori' then 
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'extra/orinote');

			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); -- make it so original character doesn't sing these notes
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '.04'); --Default value is: 0.023, health gained on hit

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'ori' and songName == 'Restoring The Light' and mechanicsbitch then
		playSound('fall_damage', 1);
		playSound('fall_damage', 1);
		playSound('fall_damage', 1);
		playSound('fall_damage', 1);
		health = getProperty('health')
		setProperty('health', getProperty('health')-2.5);
	end
end