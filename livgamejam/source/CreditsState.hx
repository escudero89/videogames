package ;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class CreditsState extends FlxState
{
	private var _FONT:String = "assets/fonts/LondrinaSolid-Regular.ttf";
	private var _TITLE:String = "Creditos";
	
	private var _closeButton:FlxButton;
	

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		
		var _txTitle:FlxText = new FlxText(0, 0, FlxG.width, _TITLE);
		_txTitle.setFormat(_FONT, 100, FlxColor.WHITE, "center");
		add(_txTitle);
		
		/** Poner bloques o cartas con un icono para cada uno
		 * y al costado nuestro nombre, edad, telefono, numero de seguro social... 
		 *  jaja
		**/
		
		// Crear boton para salir del State
		var _closeButtonWidth:Int = 50;
		var _closeButtonHeight:Int = 50;
		_closeButton = new FlxButton(FlxG.width - _closeButtonWidth, 0, "", goMenuState);
		_closeButton.loadGraphic("assets/images/util/btnClose.png");
		add(_closeButton);
		
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
	
	private function goMenuState():Void
	{
		FlxG.switchState(new MenuState());
	}	
	
}