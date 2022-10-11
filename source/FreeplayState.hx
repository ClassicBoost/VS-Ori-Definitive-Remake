package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween;
import flixel.FlxCamera;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	private var cam:FlxCamera;

	public var camHUD:FlxCamera;
	public var camGame:FlxCamera;
	public var camOther:FlxCamera;

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = '';
	public var songDiff:FlxSprite;
	private var composerShit:String = '';

	public static var overnocheatsonglol:Bool = false;

	private var lengthshit:Float = 0.6;

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	var composerText:FlxText;
	private var disablebop = false;
	private var disablethisthingy:Bool = false;
	private var iconTween:FlxTween;
	var icon:HealthIcon;
	private var choosefontlol:String = 'vcr.ttf';
	private var insidepixelweek:Bool = false;

	public var bpm:Float = 100.0;

	private var disablescreenbop:Bool = false;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		//Paths.clearStoredMemory();
		//Paths.clearUnusedMemory();
		
		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		for (i in 0...WeekData.weeksList.length) {
			if(weekIsLocked(WeekData.weeksList[i])) continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs)
			{
				var colors:Array<Int> = song[2];
				if(colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
			}
		}

		if (ClientPrefs.defaultfont == 'VCR') choosefontlol = 'vcr.ttf';
		else choosefontlol = 'Bronx.otf';


		WeekData.loadTheFirstEnabledMod();

		/*		//KIND OF BROKEN NOW AND ALSO PRETTY USELESS//

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i] != null && initSonglist[i].length > 0) {
				var songArray:Array<String> = initSonglist[i].split(":");
				addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
			}
		}*/

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		bg.screenCenter();

		disablebop = false;

		lengthshit = 0.6;
		insidepixelweek = false;

		Conductor.changeBPM(100.0);

		disablescreenbop = false;
		disablethisthingy = false;

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);
		
		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItemCenter = true;
			songText.targetY = i;
			grpSongs.add(songText);

			if (songText.width > 980)
			{
				var textScale:Float = 980 / songText.width;
				songText.scale.x = textScale;
				for (letter in songText.lettersArray)
				{
					letter.x *= textScale;
					letter.offset.x *= textScale;
				}
				//songText.updateHitbox();
				//trace(songs[i].songName + ' new scale: ' + textScale);
			}

			Paths.currentModDirectory = songs[i].folder;
			icon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		WeekData.setDirectoryFromWeek();

		reloadBPM();

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font(choosefontlol), 32, FlxColor.WHITE, CENTER);
		scoreText.scrollFactor.set();

		scoreBG = new FlxSprite(0, 0).makeGraphic(1800, 130, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(FlxG.width * 0.7, 41, 0, "", 24);
		diffText.setFormat(Paths.font(choosefontlol), 24, FlxColor.WHITE, RIGHT);
		diffText.font = scoreText.font;
		diffText.scrollFactor.set();
	//	add(diffText);

		songDiff = new FlxSprite(0, scoreText.y + 200);
		songDiff.frames = Paths.getSparrowAtlas('song_difficulties');
		songDiff.animation.addByPrefix('0', 'chill0', 1, true);
		songDiff.animation.addByPrefix('1', 'fair0', 1, true);
		songDiff.animation.addByPrefix('2', 'moderate0', 1, true);
		songDiff.animation.addByPrefix('3', 'difficult0', 1, true);
		songDiff.animation.addByPrefix('4', 'challenging0', 1, true);
		songDiff.animation.addByPrefix('5', 'harsh0', 1, true);
		songDiff.animation.addByPrefix('6', 'insane0', 1, true);
		songDiff.animation.addByPrefix('unranked', 'unranked0', 1, true);
		songDiff.x = 50;
		songDiff.y = 0;
		songDiff.antialiasing = ClientPrefs.globalAntialiasing;
		add(songDiff);

		composerText = new FlxText(0, 50, 0, "", 32);
		composerText.setFormat(Paths.font(choosefontlol), 32, FlxColor.WHITE, RIGHT);
		composerText.font = scoreText.font;
		composerText.x = 50;
		composerText.y = 90;
		composerText.scrollFactor.set();
		add(composerText);

		add(scoreText);

		if(curSelected >= songs.length) curSelected = 0;
		bg.color = songs[curSelected].color;
		intendedColor = bg.color;

		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		changeSelection();
		changeDiff();

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		#if PRELOAD_ALL
		var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 16;
		#else
		var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 18;
		#end
		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
		text.setFormat(Paths.font(choosefontlol), size, FlxColor.WHITE, CENTER);
		text.scrollFactor.set();
		add(text);
		super.create();
	}

	override function closeSubState() {
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);
			this.songs[this.songs.length-1].color = weekColor;

			if (songCharacters.length != 1)
				num++;
		}
	}*/

	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var crochet = ((60 * bpm) * 1000);

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		positionHighscore();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		/*
		#33FF00 - Chill

		#A2FF00 - Fair

		#DDFF00 - Moderate

		#FFBB00 - Challenging

		#FF8800 - Difficult

		#FF5100 - Harsh

		#FF002B - Insane
		*/

		if (insidepixelweek) {
			composerText.setFormat(Paths.font('pixel.otf'), 24, FlxColor.WHITE, RIGHT);
			scoreText.setFormat(Paths.font('pixel.otf'), 24, FlxColor.WHITE, CENTER);
		} else {
			composerText.setFormat(Paths.font(choosefontlol), 32, FlxColor.WHITE, RIGHT);
			scoreText.setFormat(Paths.font(choosefontlol), 32, FlxColor.WHITE, CENTER);
		}

		composerText.text = 'Composer(s): ${composerShit}';

		// I know this is a mess but it works
		if (curSelected == 0) {// Tut
			songDiff.animation.play('0', true);
			songDiff.color = 0xFF33FF00;
			composerShit = '';
			overnocheatsonglol = false;
		}
		if (curSelected == 1) { // Spirit Tree
			songDiff.animation.play('0', true);
			songDiff.color = 0xFF33FF00;
			composerShit = 'Rae the Spirit, James Jamestar';
			overnocheatsonglol = false;
		}
		if (curSelected == 2) {// RTL
			songDiff.animation.play('1', true);
			songDiff.color = 0xFFA2FF00;
			composerShit = 'Rae the Spirit, James Jamestar';
			overnocheatsonglol = false;
		}
		if (curSelected == 3) {// Trirotation
			songDiff.animation.play('4', true);
			songDiff.color = 0xFFFF8800;
			composerShit = 'Voltex, James Jamestar';
			overnocheatsonglol = true;
		}
		if (curSelected == 4) { // Decay
			songDiff.animation.play('3', true);
			songDiff.color = 0xFFFFBB00;
			composerShit = 'Rae the Spirit, James Jamestar';
			overnocheatsonglol = true;
		}

		diffText.text = 'SONG DIFFICULTY: ${songDiff}';

		if(songs.length > 1)
		{
			if (upP)
			{
				changeSelection(-shiftMult);
				holdTime = 0;
			}
			if (downP)
			{
				changeSelection(shiftMult);
				holdTime = 0;
			}

			if(controls.UI_DOWN || controls.UI_UP)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					changeDiff();
				}
			}

			if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				changeSelection(-shiftMult * FlxG.mouse.wheel, false);
				changeDiff();
			}
		}

		if (controls.UI_LEFT_P)
			changeDiff(-1);
		else if (controls.UI_RIGHT_P)
			changeDiff(1);
		else if (upP || downP) changeDiff();

		if (controls.BACK)
		{
			persistentUpdate = false;
			if(colorTween != null) {
				colorTween.cancel();
			}
			if(zoomTween != null) zoomTween.cancel();
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if(ctrl)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}

		if(instPlaying != curSelected)
		{
			#if PRELOAD_ALL

			destroyFreeplayVocals();
			FlxG.sound.music.volume = 0;
			Paths.currentModDirectory = songs[curSelected].folder;
			var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
			PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
			instPlaying = curSelected;
			#end
		}

		else if (accepted)
		{
			persistentUpdate = false;
			var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
			/*#if MODS_ALLOWED
			if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
			#else
			if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
			#end
				poop = songLowercase;
				curDifficulty = 1;
				trace('Couldnt find file');
			}*/
			trace(poop);

			disablescreenbop = true;
			PlayState.SONG = Song.loadFromJson(poop, songLowercase);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;

			trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
			if(colorTween != null) {
				colorTween.cancel();
			}
			
			if (FlxG.keys.pressed.SHIFT){
				if (!overnocheatsonglol) LoadingState.loadAndSwitchState(new ChartingState());
				else FlxG.sound.play(Paths.sound('no'));
			}else{
				LoadingState.loadAndSwitchState(new PlayState());
			}

			FlxG.sound.play(Paths.sound('confirmMenu'));

			FlxG.sound.music.volume = 0;
					
			destroyFreeplayVocals();
		}
		else if(controls.RESET)
		{
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if (!disablebop && !disablethisthingy) {
			disablethisthingy = true;
			new FlxTimer().start(lengthshit, zoomCam);
		}

		if(iconTween != null) iconTween.cancel();
		iconTween = FlxTween.tween(icon.scale, {x: 1, y:1}, 0.7, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween)
			{
				iconTween = null;
			}
		});

		FlxG.camera.zoom = FlxMath.lerp(1, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));

		super.update(elapsed);
	}

	function reloadBPM() {
		if (curSelected == 0) {
			Conductor.changeBPM(100.0);
			lengthshit = 0.6;
		}
		if (curSelected == 1) {
			Conductor.changeBPM(110.0);
			lengthshit = 0.545;
		}
		if (curSelected == 2) {
			Conductor.changeBPM(160.0);
			lengthshit = 0.375;
		}
		if (curSelected == 4) {
			Conductor.changeBPM(197.0);
			lengthshit = 0.305;
		}
		if (curSelected == 3) {
			Conductor.changeBPM(144.0);
			lengthshit = 0.417;
		}
	}

	
	var zoomTween:FlxTween;
	var lastBeatHit:Int = -1;
	override function beatHit()
		{		
			super.beatHit();

			// fuck you psych engine
		//	FlxG.sound.play(Paths.sound('Metronome_Tick'), 0.7); // bpm test with audio

			if(lastBeatHit == curBeat)
				{
					return;
				}

		/*	if (curBeat % 1 == 0) {
					FlxG.camera.zoom = 1.15;
		
					if(zoomTween != null) zoomTween.cancel();
					zoomTween = FlxTween.tween(FlxG.camera, {zoom: 1}, 1, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween)
						{
							zoomTween = null;
						}
					});
				}*/
		
			lastBeatHit = curBeat;

		//	FlxG.camera.zoom += 0.1;

		//	if (!disablescreenbop)
		//	{
		//	FlxTween.tween(FlxG.camera, {zoom: 1.1}, 1, {ease: FlxEase.quadOut, type: BACKWARD});
		//	}
		}

	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	public function zoomCam(time:FlxTimer = null) {
		if (!disablebop) {
		disablebop = true;
		if (disablethisthingy) {
		if (ClientPrefs.freeplayzoom)
		FlxG.camera.zoom = 1.1;
		zoomoutthing();
	/*	var bullshit1:Bool = false; // Temporary disabled until I figure this out
		if (ClientPrefs.forevericonbop) {
			if (bullshit1) {
				FlxTween.cancelTweensOf(icon);
				FlxTween.angle(icon, -15, 0, 1.5, {ease: FlxEase.quadOut});
				icon[curSelected].scale.x = 1.2;
				icon[curSelected].scale.y = 1.2;
				bullshit1 = true;
			}
			else {
				FlxTween.cancelTweensOf(icon);
				FlxTween.angle(icon, 15, 0, 1.5, {ease: FlxEase.quadOut});
				icon[curSelected].scale.x = 1.2;
				icon[curSelected].scale.y = 1.2;
				bullshit1 = false;
			}
		}
		else {
			icon.scale.x = 1.2;
			icon.scale.y = 1.2;
		}*/
		}
		disablebop = false;
		disablethisthingy = false;
	}
	}

	function zoomoutthing() {
		if(zoomTween != null) zoomTween.cancel();
		zoomTween = FlxTween.tween(FlxG.camera, {zoom: 1}, 1, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween)
			{
				zoomTween = null;
			}
		});
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		positionHighscore();
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		if(zoomTween != null) zoomTween.cancel();

	//	Conductor.changeBPM(bpm);
			
		reloadBPM();

		var newColor:Int = songs[curSelected].color;
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		if ((curSelected == 16 || curSelected == 17 || curSelected == 18) && !insidepixelweek){// C
			insidepixelweek = true;
			FlxG.camera.flash(FlxColor.BLACK, 2);
			FlxG.sound.play(Paths.sound('static'));
		}
		else if ((curSelected != 16 && curSelected != 17 && curSelected != 18) && insidepixelweek){
			insidepixelweek = false;
			FlxG.camera.flash(FlxColor.BLACK, 2);
			FlxG.sound.play(Paths.sound('static'));
		}

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
			iconArray[i].animation.curAnim.curFrame = 0;
		}

		iconArray[curSelected].alpha = 1;
		iconArray[curSelected].animation.curAnim.curFrame = 2;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		
		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5

		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}
		
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
	}

	private function positionHighscore() {
		scoreText.x = FlxG.width - scoreText.width - 6;

		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
		diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
		diffText.x -= diffText.width / 2;
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}