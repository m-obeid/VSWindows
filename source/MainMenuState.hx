package;

import openfl.system.Capabilities;
import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['StoryMenu', 'Freeplay', 'Kickstarter', 'Controlpanel'];
	#else
	var optionShit:Array<String> = ['StoryMenu', 'Freeplay'];
	#end

	var logoBumpin:FlxSprite;

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.6" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('velkommen'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.05;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		if(FlxG.save.data.antialiasing)
			{
				bg.antialiasing = true;
			}
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.05;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		if(FlxG.save.data.antialiasing)
			{
				magenta.antialiasing = true;
			}
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		logoBumpin = new FlxSprite(50, FlxG.height * 1.6);
		logoBumpin.frames = Paths.getSparrowAtlas("logoBumpin");
		logoBumpin.animation.addByPrefix('bump', 'logo bumpin');
		logoBumpin.screenCenter(Y);
		logoBumpin.x = 350;
		logoBumpin.scrollFactor.set();
		logoBumpin.scale.set(0.85, 0.85);
		add(logoBumpin);

		var tex = Paths.getSparrowAtlas('DesktopAssets');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(50, FlxG.height * 1.6);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', "DesktopAssets " + optionShit[i], 24);
			menuItem.animation.addByPrefix('selected', "DesktopAssets " + optionShit[i], 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			//menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.x = 0;
			menuItem.scrollFactor.y = 1;
			if(FlxG.save.data.antialiasing)
				{
					menuItem.antialiasing = true;
				}
			menuItem.y = 60 + (i * 260);
			if (i == 0)
			{
				var menuCursor:FlxSprite = new FlxSprite(50, FlxG.height * 1.6);
				menuCursor.frames = tex;
				menuCursor.animation.addByPrefix('idle', "DesktopAssets cursor", 24);
				menuCursor.animation.play('idle');
				menuCursor.scrollFactor.set();
				add(menuCursor);
				menuCursor.screenCenter(XY);
				menuCursor.x = 250;
				menuCursor.scale.set(0.5,0.5);
			}
		}

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.06 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 36, 0, "Friday Night Funkin' " + gameVer, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		#if sys
		var swagVersion:FlxText = new FlxText(5, FlxG.height - 18, 0, "VSWindows 2.0 on "  + Capabilities.os + " with KE " + kadeEngineVer, 12);
		#else
		#if web
		var doc = js.Browser.window.document;
		var url = doc.URL; //or any other document command supported by the browser.
		var urlHandler = new js.html.URL(url);
		var lol = urlHandler.hostname;
		if (lol == "epoxy.zuelsdorf.net") lol = "OnGamez";
		else if (lol == "127.0.0.1") lol = "Localhost";
		var swagVersion:FlxText = new FlxText(5, FlxG.height - 18, 0, "VSWindows 2.0 on " + lol + " with KE " + kadeEngineVer, 12);
		#else
		var swagVersion:FlxText = new FlxText(5, FlxG.height - 18, 0, "VSWindows 2.0 on... ehhh... idk bro with KE " + kadeEngineVer, 12);
		#end
		#end
		swagVersion.scrollFactor.set();
		swagVersion.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(swagVersion);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override  function beatHit() {
		super.beatHit();

		logoBumpin.animation.play('bump', true);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}
			}

			if (FlxG.keys.justPressed.UP)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'Kickstarter')
				{
					fancyOpenURL("https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game/");
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					
					if (FlxG.save.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'StoryMenu':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'Freeplay':
				FlxG.switchState(new FreeplayState());

				trace("Freeplay Menu Selected");
			case 'Controlpanel':
				FlxG.switchState(new OptionsMenu());
		}
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;
		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
