package;
import flixel.input.gamepad.mappings.MayflashWiiRemoteMapping;
import flixel.*;

class PiracyScreen extends MusicBeatState
{
	public static var allowedHosts:Array<String> = ["127.0.0.1", "epoxy.zuelsdorf.net", "m-obeid.github.io"];
	public function new() 
	{
		super();
	}
	
	override function create() 
	{
		super.create();

		// u have permkisson?????????
		// also i might be the first one to put effort into this shit lol
		var doc = js.Browser.window.document;
		var url = doc.URL; //or any other document command supported by the browser.
		var urlHandler = new js.html.URL(url);
		var banned = true;
		for (i in allowedHosts)
		{
			if (urlHandler.hostname == i)
			{
				banned = false;
			}
		}
		if (!banned)
		{
			FlxG.switchState(new MainMenuState());
		}
		else
		{
			var screen:FlxSprite = new FlxSprite().loadGraphic(Paths.image("bluescreen"));
			add(screen);
		}
	}
	
	
	override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		if (FlxG.keys.pressed.ENTER){
            // hier ist was passiert wenn ENTER gedrückt
			fancyOpenURL("https://m-obeid.github.io/VSWindows");
		}
		if (FlxG.keys.pressed.SPACE){
            // hier ist was passiert wenn SPACE gedrückt
			fancyOpenURL("https://gamebanana.com/mods/312639");
		}
		if (FlxG.keys.pressed.ESCAPE){
			// nonono dont do this
			FlxG.switchState(new MainMenuState());
		}
		
		
	}
	
}