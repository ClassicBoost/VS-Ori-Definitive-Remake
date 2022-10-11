	function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Fire Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'healthAlt' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'extra/HEALnote'); --Change texture --Change note splash texture
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'healthAlt' then
		setProperty('health', getProperty('health')+0.04);

end
end