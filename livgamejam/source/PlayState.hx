package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop;

import Event;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	private var _fondoColina:FlxBackdrop;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		setBackground();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}
	
	public function setBackground() {
		
		var _fondoColina = new FlxSprite(0, 960);
		_fondoColina.loadGraphic("assets/images/colina.png");
		_fondoColina.y -= _fondoColina.height;
		
		add(_fondoColina);
		
		var tarjeta1 = new Event(31, 128);
		var tarjeta2 = new Event(231, 128);
		var tarjeta3 = new Event(431, 128);
		
		add(tarjeta1); add(tarjeta1.setIcon()); add(tarjeta1.setText());
		add(tarjeta2); add(tarjeta2.setIcon()); add(tarjeta2.setText());
		add(tarjeta3); add(tarjeta3.setIcon()); add(tarjeta3.setText());
		
		FlxG.cameras.bgColor = FlxColor.BLUE;
		
		var camera:FlxCamera = new FlxCamera(0, 0, 640, 960);
		
		FlxG.cameras.add(camera);
		
	}
}