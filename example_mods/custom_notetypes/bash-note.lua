function onCreate()
	precacheImage('nibel/bashnotesplashes')
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'bash-note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'extra/bashnote');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '10');
		end
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'bash-note' then
		if mechanicsbitch then
		health = getProperty('health')
		setProperty('health', getProperty('health')-0.2);
		playSound('finn-hurt', 1);
		end
	end
end
