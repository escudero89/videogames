package ;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import flixel.util.FlxColor;
import flixel.text.FlxText;

import Std.*;

/**
 * ...
 * @author ...
 */
class SummaryState extends FlxState
{
	
	public static var _recordPlayer:RecordPlayer;
	
	private var _FONT:String = null;
	private var _TITLE:String = "Sumario";
	private var _SUBTITLE:String = "El camino recorrido";
	private var _AGE:String;
	private var _EXP:String;
	private var _historyEventsIDs:Array<String>;
	private var _HeightCard:Int = 270;
	private var _WidthCard:Int = 180;
	private var _initialPosCards:Int = 600;
	private var _separationInCards:Int = 10;
	//private var _FULLHEGHT:Int;
	
	var _camera:FlxCamera;	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		// Cargar algunos eventos para probarlo
		_recordPlayer = new RecordPlayer();
		var _testEvent1:Event = new Event('E1', 'Hacerse notar', 'Entre tantas máscaras sociales.', 70, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'R1', 0, 0, 0, 0, 5, 0, 0, 0);
		_recordPlayer.update(_testEvent1);
		var _testEvent2:Event = new Event('E4', 'Tener un amor frugal', '¿Cuántos poemas van ya?', 70, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'R1', 5, 0, 0, 0, 0, 0, 0, 0);
		_recordPlayer.update(_testEvent2);
		var _testEvent3:Event = new Event('E20', 'Ir a por un premio artistico', 'Y salir segundo por creativo.', 780, 3, 0, 70, 0, 0, 50, 0, 0, 0, 1, 'R11', 0, 15, 0, 0, 15, 0, 15, 0);
		_recordPlayer.update(_testEvent3);
		var _testEvent4:Event = new Event('E14', 'Publicar un libro', 'Aunque lo lea sólo tu mamá.', 270, 12, 0, 0, 0, 50, 0, 0, 0, 0, 1, 'R7', 0, 5, 0, 15, 5, 0, 5, 5);
		_recordPlayer.update(_testEvent4);
		
		// setear valores generales
		_AGE = Std.string(_recordPlayer.getAgeInYears());
		_EXP = Std.string(_recordPlayer._experience);
		_historyEventsIDs = _recordPlayer.getEventsIds();
		
		//set_bgColor(FlxColor.FOREST_GREEN);
		var _fondoColina = new FlxSprite(0, 960);
		_fondoColina.loadGraphic("assets/images/colina.png");
		_fondoColina.y -= _fondoColina.height;
		add(_fondoColina);
		
		var _txTitle:FlxText = new FlxText(0, 50, FlxG.width, _TITLE);
		_txTitle.setFormat(_FONT, 94, FlxColor.WHITE, "center");
		add(_txTitle);
		
		var _txSubTitle:FlxText = new FlxText(0, 150, FlxG.width, _SUBTITLE);
		_txSubTitle.setFormat(_FONT, 48, FlxColor.WHITE, "center");
		add(_txSubTitle);
		
		var _txAge:FlxText = new FlxText(0, 260, FlxG.width, "Edad: "+_AGE+" años");
		_txAge.setFormat(_FONT, 20, FlxColor.WHITE, "right");
		add(_txAge);
		
		var _txExp:FlxText = new FlxText(0, 300, FlxG.width, "Exp.: "+_EXP+" puntos");
		_txExp.setFormat(_FONT, 20, FlxColor.WHITE, "right");
		add(_txExp);
		
		// Mostrar las cartas de los eventos anteriores
		var _index:Int = 0;
		while (_index < _historyEventsIDs.length) {
			var _eventID:String = _historyEventsIDs[_index];
			// Centrado en la pantalla en x
			var _posX:Float = ((FlxG.width / 2) - (_WidthCard / 2)) - 100;
			// Una carta abajo de otra:
			// posicion inicial + altura de la carta + separacion entre cartas
			var _posY:Float = _initialPosCards + (_HeightCard + _separationInCards) * _index;
			var _pos:FlxPoint = new FlxPoint(_posX, _posY);
			var _event:Event = MenuState.eventCollection.get(_eventID);
			var _card:Card = new Card(_event, _pos);
			
			
			
			add(_card);
			_index += 1;
		}
		
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
		
		if (FlxG.keys.pressed.DOWN) {
			FlxG.camera.scroll.y += 10;
		}
		if (FlxG.keys.pressed.UP) {
			FlxG.camera.scroll.y -= 10;
		}
		
	}
	
	private function formatDescription(_description:String):String
	{
		return _description;
	}
	
}