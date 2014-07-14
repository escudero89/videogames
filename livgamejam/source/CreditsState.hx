package ;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.system.FlxSound;
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
	private var _closeButton:FlxButton;
	
	private var _menuFondo:FlxSprite;
	private var _musicaFondo:FlxSound;
	
	private var _textCredits:FlxTypedGroup<FlxText>;
	private var _textCreditsPosition:Float = 0;
	private var _max_text_position:Float = 200;
	

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		
		_menuFondo = new FlxSprite(0, 0, "assets/images/CreditsState.png");
		add(_menuFondo);
		
		_musicaFondo = new FlxSound();
		_musicaFondo.loadEmbedded(PathTo._MUSIC_BACKGROUND_CREDITS, true, false);
		_musicaFondo.play();
			
		// Crear boton para salir del State
		var _closeButtonWidth:Int = 50;
		var _closeButtonHeight:Int = 50;
		_closeButton = new FlxButton(FlxG.width - _closeButtonWidth, 0, "", goMenuState);
		_closeButton.loadGraphic("assets/images/util/btnClose.png");
		add(_closeButton);
	
		_textCredits = new FlxTypedGroup<FlxText>();
		marquesina();
	}
	
	// Contiene el texto y lo va trasladando
	private function marquesina():Void
	{
		var separacion:Float = 0;
		
		for (i in 0...PathTo._CREDITS_TEXT.length) {
			separacion += PathTo._CREDITS_TEXT_POS[i];

			var _newTextCredits = new FlxText(0, separacion, 640, PathTo._CREDITS_TEXT[i]);
			_newTextCredits.setFormat(PathTo._STR_FONT, PathTo._CREDITS_TEXT_FONT[i], FlxColor.WHITE, "center", FlxText.BORDER_OUTLINE, 0xff513700);
			_newTextCredits.borderSize = 3;
			_newTextCredits.alpha = 0.9;
			_textCredits.add(_newTextCredits);
		}
		
		_max_text_position += separacion;
		
		add(_textCredits);
	}
	
		/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		_textCredits.clear();
		
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		if (_textCreditsPosition < _max_text_position) {
			if (_textCredits.length > 0) {
				_textCredits.forEach(function(text:FlxText) { text.y += -1; } );	
				_textCreditsPosition ++;
			}
		} 
		
		if (_textCreditsPosition >= _max_text_position || FlxG.keys.justPressed.ANY) {
			_textCreditsPosition = -_max_text_position;
			goMenuState();
		}
	
	}
	
	private function goMenuState():Void
	{
		_musicaFondo.fadeOut(1.5);
		FlxG.camera.fade(FlxColor.WHITE, 2, false, function() {
			_musicaFondo.stop();
			FlxG.switchState(new MenuState());
		});
	}	
	
}