package;
import flixel.*;

class PiracyScreen extends MusicBeatState
{

	public function new() 
	{
		super();
	}
	
	override function create() 
	{
		super.create();
		
		var screen:FlxSprite = new FlxSprite().loadGraphic(Paths.image("bluescreen"));
		
		add(screen);
		
		
	}
	
	
	override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		if (controls.ACCEPT){
			fancyOpenURL("https://www.youtube.com/watch?v=Hz8Ydipu-7o");
		}
		
		
		
	}
	
}