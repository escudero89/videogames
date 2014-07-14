package ;

import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.plugin.MouseEventManager;
import flixel.system.FlxSound;


/**
 * ...
 * @author CEF
 */
class TutorialState extends FlxState
{
	
	private var _musicaFondo:FlxSound;
	private var _TITLE:String = "Tutorial";
	private var _botonSkip:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		
		FlxG.plugins.add(new MouseEventManager());
		
		_musicaFondo = new FlxSound();
		_musicaFondo.loadEmbedded(PathTo._MUSIC_BACKGROUND_PLAYSTATE, true, false);
		_musicaFondo.play();
		
		var _fondoTuto:FlxSprite = new FlxSprite(0, 0, "assets/images/fondoTutorial.png");
		add(_fondoTuto);
		
		var _txTitle:FlxText = new FlxText(0, 0, FlxG.width, _TITLE);
		_txTitle.setFormat(PathTo._STR_FONT, 100, FlxColor.WHITE, "center", FlxText.BORDER_OUTLINE, FlxColor.BLACK);
		_txTitle.borderSize = 3;
		add(_txTitle);
		
		_botonSkip = new FlxSprite(480, 890, "assets/images/menu/botonSkip.png");
		add(_botonSkip);
		
		MouseEventManager.add(_botonSkip, 
			function(sprite:FlxSprite) { // mouse down
				_musicaFondo.fadeOut(1.5);
				FlxG.camera.fade(FlxColor.WHITE, 2, false, function() { FlxG.switchState(new PlayState()); } );
				playSound('menuclick');
			}, null, 
			function(sprite:FlxSprite) { // mouse over
				playSound('menuhover');
				sprite.loadGraphic("assets/images/menu/botonSkipHover.png");
			}, 
			function(sprite:FlxSprite) { // mouse out
				sprite.loadGraphic("assets/images/menu/botonSkip.png");
		});
		
	}
	
	public static function playSound(sonido:String):Void
	{
		var sound = new FlxSound();
		var path:String = "";
		
		switch(sonido) {
			case 'menuclick':
				path = PathTo._SOUND_MENU_CLICK;
			case 'menuhover':
				path = PathTo._SOUND_MENU_HOVER;
			default:
				path = PathTo._SOUND_CARD;
		}
		
		sound.loadEmbedded(path, false, true);
		sound.play();
		sound.autoDestroy = true;
	}
	
	
}