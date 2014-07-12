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

import Card;
import Handler;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	private var _fondoColina:FlxBackdrop;
	private var _Handler:Handler;
	//private var _dataBase:DataBase;
	
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
		
		if (_Handler._end_of_game) {
			FlxG.resetState();
		}
	}
	
	public function setBackground() {
		
		var _fondoColina = new FlxSprite(0, 960);
		_fondoColina.loadGraphic("assets/images/colina.png");
		_fondoColina.y -= _fondoColina.height;
		
		add(_fondoColina);
		
		//_Handler = new Handler();
		
		// agregando la base de datos
		//_dataBase = new DataBase();
		_Handler = new Handler(MenuState.eventCollection);
		
		add(_Handler);
		
		FlxG.cameras.bgColor = FlxColor.BLUE;
		
		var camera:FlxCamera = new FlxCamera(0, 0, 640, 960);
		
		FlxG.cameras.add(camera);
		
	}
}