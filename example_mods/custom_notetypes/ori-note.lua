function onCreate()
	precacheImage('nibel/orinotesplashes')
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'ori-note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'extra/orinote');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.4');
		end
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'ori-note' and songName == 'Restoring The Light' and mechanicsbitch then
		playSound('fall_damage', 1);
		playSound('fall_damage', 1);
		playSound('fall_damage', 1);
		playSound('fall_damage', 1);
		health = getProperty('health')
		setProperty('health', getProperty('health')-2.5);
	end
end
