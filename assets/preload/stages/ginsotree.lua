function onCreate()
	makeAnimatedLuaSprite('bg', 'nibel/gino/runbg', -300, 0); 
	addAnimationByPrefix('bg', 'scroll', 'runbg scroll', 100, true)
	addLuaSprite('bg', false);
	scaleObject('bg', 1.2, 1.2);

	makeAnimatedLuaSprite('rocks', 'nibel/gino/rocks', -300, 0); 
	addAnimationByPrefix('rocks', 'groove', 'rocks groove', 50, true)
	addLuaSprite('rocks', false);
	scaleObject('rocks', 1.2, 1.2);

	makeAnimatedLuaSprite('light', 'nibel/gino/epiclight', -300, 0); 
	addAnimationByPrefix('light', 'groove', 'coollight groove', 30, true)
	addLuaSprite('light', false);
	scaleObject('light', 1.2, 1.2);
	setProperty('light.alpha', 0.5)

	makeAnimatedLuaSprite('grass', 'nibel/gino/grass', -300, 0); 
	addAnimationByPrefix('grass', 'scroll', 'grass scroll', 400, true)
	addAnimationByPrefix('grass', 'return', 'grass return', 400, false)
	addAnimationByPrefix('grass', 'end', 'grass end', 400, false)
	
	addLuaSprite('grass', false);
	scaleObject('grass', 1.2, 1.2);

	makeAnimatedLuaSprite('diewater', 'nibel/gino/diewater', -600, 0); 
	addAnimationByPrefix('diewater', 'fall', 'water water', 100, true)
	setObjectCamera('diewater','camHud')
	addLuaSprite('diewater', true);
	scaleObject('diewater', 4, 4);
	setProperty('diewater.flipX', true)

end
		