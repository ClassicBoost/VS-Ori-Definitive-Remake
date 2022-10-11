	function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Fire Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'swords' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'purgatory/SwordNotes'); --Change texture --Change note splash texture

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Lets Opponent's instakill notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			else
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'swords' then
		characterPlayAnim('dad', 'attack', true);
		playSound('sword', 1);
	end
	if noteType == 'swords' then
	if keyPressed('space') then
		playSound('block', 1);
	else
		characterPlayAnim('boyfriend', 'hurt', true);
		playSound('finn-hurt', 1);
		playSound('finn-hurt', 1);
		playSound('stab', 1);
		health = getProperty('health')
		setProperty('health', getProperty('health')-0.015); -- To make the achievement possible you take 8 damage.
    end
end
end