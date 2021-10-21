package;
import flixel.addons.ui.FlxUISubState;
import flixel.addons.ui.FlxUIState;
import flixel.input.gamepad.mappings.MayflashWiiRemoteMapping;
import flixel.*;

class BlueScreen extends FlxUISubState
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
		
		if (FlxG.keys.pressed.ENTER){
            // hier ist was passiert wenn ENTER gedrückt
			
		}
		if (FlxG.keys.pressed.SPACE){
            // hier ist was passiert wenn SPACE gedrückt
			
		}
		
	}
	
}