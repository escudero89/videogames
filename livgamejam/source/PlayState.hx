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
	
	private var _FONT:String = "assets/fonts/LondrinaSolid-Regular.ttf";
	
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
	private var counter:Float = 6;
	private var txPassTurn:FlxText;
	private var txNumber:FlxText;
	private var txSeg:FlxText;

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

		counter -= FlxG.elapsed;
		txNumber.text = "" + Math.ceil(counter);
		txNumber.update();
		
		if ( _timmy.getChoice()) {
			counter = 6;
		}
		if (Math.floor(counter) == 0) {
			_handler.passTurn();
			counter = 6;
		}
		
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
		
		expDisplay.text = "EXP: " + _handler.getTimmyExp();
		ageDisplay.text = "EDAD: " + _handler.getTimmyAge();
		
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
		
		expDisplay = new FlxText(12, 825, 0, "EXP: " + 0);
		expDisplay.setFormat(_FONT, 40, FlxColor.BLACK);
		expDisplay.scrollFactor.set(0, 0);
		add(expDisplay);
		
<<<<<<< HEAD
		ageDisplay = new FlxText(12, 870, 0, "EDAD: " + 0);
		ageDisplay.setFormat("assets/fonts/LondrinaSolid-Regular.ttf", 40, FlxColor.BLACK);
=======
		ageDisplay = new FlxText(12, 870, 0, "AGE: " + 0);
		ageDisplay.setFormat(_FONT, 40, FlxColor.BLACK);
>>>>>>> origin/master
		ageDisplay.scrollFactor.set(0, 0);
		add(ageDisplay);
		
		txPassTurn = new FlxText(25, 404, -1, "Pasar turno");
		txPassTurn.setFormat(_FONT, 32, FlxColor.WHITE);
		txPassTurn.scrollFactor.set(0, 0);
		add(txPassTurn);
		txNumber = new FlxText(96, 443, -1, "" + Math.ceil(counter));
		txNumber.setFormat(_FONT, 44, FlxColor.WHITE);
		txNumber.scrollFactor.set(0, 0);
		add(txNumber);
		txSeg = new FlxText(126, 462, -1, "seg.");
		txSeg.setFormat(_FONT, 32, FlxColor.WHITE);
		txSeg.scrollFactor.set(0, 0);
		add(txSeg);
		
	}
	
	/** 
	 * Funcion que elige el evento "Recluirse"
	*/
	public function skipHand():Void
	{
		
	}
}