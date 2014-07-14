package;

import flixel.group.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop;

import flixel.plugin.MouseEventManager;

import Card;
import Handler;
import RecordPlayer;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	private var _handler:Handler;
	private var _timmy:Timmy;
	
	public static var _recordPlayer:RecordPlayer;
	
	//private var _dataBase:DataBase;
	private var atributos:String = "";
	private var atributosDebugger:FlxText;
	private var expDisplay:FlxText;
	private var ageDisplay:FlxText;
	
	private var _musicaFondo:FlxSound;
	
	// Contador para saltar turnos automaticamente
	private var counter:Int = 6;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		setBackground();
		
		_musicaFondo = new FlxSound();
		_musicaFondo.loadEmbedded(PathTo._MUSIC_BACKGROUND_PLAYSTATE, true, false);
		_musicaFondo.play();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{		
		_musicaFondo.stop();
		
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		/*
		counter -= FlxG.elapsed;
		if ( _timmy.getChoice()) {
			counter = 6;
		}
		if (counter == 0) {
			skipHand();
			counter = 6;
		}
		*/
		if (_handler._end_of_game) {
			_musicaFondo.fadeOut(4);
			_handler.destroy();
			FlxG.camera.fade(FlxColor.BLACK, 5, false, function() {
				_musicaFondo.stop();
				FlxG.switchState(new SummaryState());
			});
		}
		
		atributos = "";
		for (key in _handler._atributes.keys()) {
			atributos += key + ": " + _handler._atributes[key] + "\n";
		}
	
		atributosDebugger.text = atributos;
		
		// Si tocamos escape
		if (FlxG.keys.justPressed.ESCAPE) {
			_musicaFondo.fadeOut(1.5);
			FlxG.camera.fade(FlxColor.WHITE, 2, false, function() {
				_musicaFondo.stop();
				FlxG.switchState(new MenuState());
				_handler.destroy();
			});

		}
		
		ageDisplay.text = PathTo._TEXT_DURATION + ":  " + _handler.getTimmyAge();
		expDisplay.text = PathTo._TEXT_EXPERIENCE + ":  " + _handler.getTimmyExp();
		
	}
	
	public function setBackground() {

		// We need the MouseEventManager plugin for sprite-mouse-interaction
		// Important to set this up before createCards()
		FlxG.plugins.add(new MouseEventManager());
		
		_timmy = new Timmy();
		_recordPlayer = new RecordPlayer();
		_handler = new Handler(MenuState.eventCollection, _timmy);

		add(_timmy.getInterfaceBack());
		add(_handler);
		add(_timmy.getInterfaceFront());
		
		add(_timmy);
		
		FlxG.camera.bgColor = FlxColor.CYAN;
		
		atributosDebugger = new FlxText(10, 750, -1, atributos, 17);
		atributosDebugger.scrollFactor.set(0, 0);
		//add(atributosDebugger);
		
		//var fondoTexto = new FlxSprite(30, 800, "assets/images/
		
		ageDisplay = new FlxText(35, 825, 0, PathTo._TEXT_DURATION + ":\t" + 0);
		ageDisplay.setFormat(PathTo._STR_FONT, 40, PathTo._COLOR_DURATION_DARK, null, FlxText.BORDER_OUTLINE, FlxColor.BLACK);
		ageDisplay.addFormat(new FlxTextFormat(PathTo._COLOR_DURATION, false, false, FlxColor.BLACK, PathTo._TEXT_DURATION.length + 1, 100));
		ageDisplay.borderSize = 2;
		ageDisplay.scrollFactor.set(0, 0);
		add(ageDisplay);
		
		expDisplay = new FlxText(35, 870, 0, PathTo._TEXT_EXPERIENCE + ":\t" + 0);
		expDisplay.setFormat(PathTo._STR_FONT, 40, PathTo._COLOR_EXPERIENCE_DARK, null, FlxText.BORDER_OUTLINE, FlxColor.BLACK);
		expDisplay.addFormat(new FlxTextFormat(PathTo._COLOR_EXPERIENCE, false, false, FlxColor.BLACK, PathTo._TEXT_EXPERIENCE.length + 1, 100));
		expDisplay.borderSize = 2;
		expDisplay.scrollFactor.set(0, 0);
		add(expDisplay);
		
	}
	
	/** 
	 * Funcion que elige el evento "Recluirse"
	*/
	public function skipHand():Void
	{
		
	}
}