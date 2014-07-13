package;

import flixel.group.FlxTypedGroup;
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
	
	private var _handler:Handler;
	private var _timmy:Timmy;
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
		
		if (_handler._end_of_game) {
			_handler.destroy();
			FlxG.resetGame();
		}
	}
	
	public function setBackground() {
				
		_timmy = new Timmy();
		_handler = new Handler(MenuState.eventCollection, _timmy);

		add(_timmy.getInterfaceBack());
		add(_handler);
		add(_timmy.getInterfaceFront());
		
		add(_timmy);
		
		FlxG.camera.bgColor = FlxColor.CYAN;		
		
	}
}