function onCreate()
	
	makeLuaSprite('dieforest','niwen/decay/dieforest',100,-1500)
	setProperty('dieforest.scale.x', getProperty('dieforest.scale.x') + 4);
	setProperty('dieforest.scale.y', getProperty('dieforest.scale.y') + 4);

	makeLuaSprite('ground','niwen/decay/gound',100,-1500)
	setProperty('ground.scale.x', getProperty('ground.scale.x') + 4.5);
	setProperty('ground.scale.y', getProperty('ground.scale.y') + 4.5);

	makeLuaSprite('cliff','niwen/decay/cliff shit',-200,-1100)
	setProperty('cliff.scale.x', getProperty('cliff.scale.x') + 4.5);
	setProperty('cliff.scale.y', getProperty('cliff.scale.y') + 4.5);

	makeLuaSprite('treeslol','niwen/decay/backgroundtreeslol',100,-1300)
	setProperty('treeslol.scale.x', getProperty('treeslol.scale.x') + 5);
	setProperty('treeslol.scale.y', getProperty('treeslol.scale.y') + 5);

	makeLuaSprite('skybox','niwen/decay/withered sky',100,-1500)
	setProperty('skybox.scale.x', getProperty('skybox.scale.x') + 4.5);
	setProperty('skybox.scale.y', getProperty('skybox.scale.y') + 4.5);

	makeLuaSprite('treeeees','niwen/decay/extradip',100,-1500)
	setProperty('treeeees.scale.x', getProperty('treeeees.scale.x') + 4.5);
	setProperty('treeeees.scale.y', getProperty('treeeees.scale.y') + 4.5);
	
	addLuaSprite('skybox',false)
	addLuaSprite('dieforest',false)
	addLuaSprite('treeslol',false)
	addLuaSprite('ground',false)
	addLuaSprite('cliff',false)
	addLuaSprite('treeeees',false)
	setScrollFactor('skybox', 0.05, 0.05);
	setScrollFactor('dieforest', 0.7, 0.7);
	setScrollFactor('treeslol', 0.85, 0.85);
	setScrollFactor('ground', 0.95, 0.95);
	setScrollFactor('treeeees', 1.1, 1.1);
	
	makeLuaSprite('eff','niwen/thefunnyeffect', 0, 0)
	setGraphicSize('eff',1280,720)
	setObjectCamera('eff','camHud')
	updateHitbox('eff')
	setBlendMode('eff','multiply')
	addLuaSprite('eff', false);

	makeLuaSprite('eff2','niwen/thefunnyeffect', 0, 0)
	setGraphicSize('eff2',1280,720)
	setObjectCamera('eff2','camHud')
	updateHitbox('eff2')
	setBlendMode('eff2','multiply')
	addLuaSprite('eff2', false);
	setProperty('eff2.alpha', 0);

	makeLuaSprite('flash', '', 0, 0);
	makeGraphic('flash',1280,720,'ffffff')
	addLuaSprite('flash', true);
	setObjectCamera('eff','camHud')
	setLuaSpriteScrollFactor('flash',0,0)
	setProperty('flash.scale.x',5)
	setProperty('flash.scale.y',5)
	setProperty('flash.alpha',0)
	

end

function onUpdate()
	setProperty('eff.alpha', 1-(getProperty('health')/2));
end