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
	
	private var _FONT:String = "assets/fonts/LondrinaSolid-Regular.ttf";
	private var _TITLE:String = "Sumario";
	private var _SUBTITLE:String = "El camino recorrido";
	private var _AGE:String;
	private var _EXP:String;
	private var _historyEventsIDs:Array<String>;
	private var _HeightBlock:Int = 202;
	private var _WidthBlock:Int = 180;
	private var _FULLHEIGHT:Int;
	private var _initialPosBlocks:Int = 400;
	private var _separationInBlocks:Int = 0;
	
	// Para guardar la posicion anterior en y del mouse, antes de hacer el scroll
	private var _lastPosY:Float;
	
	var _camera:FlxCamera;	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		// Cargar algunos eventos para probarlo
		_recordPlayer = new RecordPlayer();
		_recordPlayer.update(MenuState.eventCollection.get("E2"));
		_recordPlayer.update(MenuState.eventCollection.get("E8"));
		_recordPlayer.update(MenuState.eventCollection.get("E7"));
		_recordPlayer.update(MenuState.eventCollection.get("E12"));
		_recordPlayer.update(MenuState.eventCollection.get("E18"));
		_recordPlayer.update(MenuState.eventCollection.get("E27"));
		_recordPlayer.update(MenuState.eventCollection.get("E28"));
		_recordPlayer.update(MenuState.eventCollection.get("X1"));
		
		// setear valores generales
		_AGE = Std.string(_recordPlayer.getAgeInYears());
		_EXP = Std.string(_recordPlayer._experiencePlayer);
		_historyEventsIDs = _recordPlayer.getEventsIds();
		_FULLHEIGHT = _initialPosBlocks + (_HeightBlock + _separationInBlocks) * _historyEventsIDs.length + 50;
		
		//set_bgColor(FlxColor.FOREST_GREEN);
		var _fondoColina = new FlxSprite(0, 960);
		_fondoColina.loadGraphic("assets/images/colina.png");
		_fondoColina.y -= _fondoColina.height;
		add(_fondoColina);
		
		var _txTitle:FlxText = new FlxText(0, 32, FlxG.width, _TITLE);
		_txTitle.setFormat(_FONT, 128, FlxColor.WHITE, "center");
		add(_txTitle);
		
		var _txSubTitle:FlxText = new FlxText(0, 150, FlxG.width, _SUBTITLE);
		_txSubTitle.setFormat(_FONT, 64, FlxColor.WHITE, "center");
		add(_txSubTitle);
		
		var _txAge:FlxText = new FlxText(0, 260, FlxG.width, "Edad: "+_AGE+" años");
		_txAge.setFormat(_FONT, 32, FlxColor.WHITE, "center");
		add(_txAge);
		
		var _txExp:FlxText = new FlxText(0, 300, FlxG.width, "Exp.: "+_EXP+" puntos");
		_txExp.setFormat(_FONT, 32, FlxColor.WHITE, "center");
		add(_txExp);
		
		// Mostrar los bloques y textos de los eventos anteriores
		var _index:Int = 0;
		while (_index < _historyEventsIDs.length) {
			
			var _eventID:String = _historyEventsIDs[_index];
			
			// Ponerlos bloques
			var _posBlockX:Float = ((FlxG.width / 2) - (_WidthBlock / 2)) - 130;
			// Un bloque abajo del otro:
			// posicion inicial + altura de la carta + separacion entre cartas
			var _posBlockY:Float = _initialPosBlocks + (_HeightBlock + _separationInBlocks) * _index;
			eventBlock(_posBlockX, _posBlockY, _eventID);
			
			// Poner los textos
			var _eventName:String = MenuState.eventCollection.get(_eventID).nombre;
			var _eventDescription:String = MenuState.eventCollection.get(_eventID).descripcion;
			// Centrado en la pantalla en x
			var _posTextsX:Float = _posBlockX + _WidthBlock + 10;
			var _posTextsY:Float = _posBlockY + 40;
			var _txEventName:FlxText = new FlxText(_posTextsX, _posTextsY, FlxG.width - _posTextsX, _eventName);
			_txEventName.setFormat(_FONT, 32, FlxColor.WHITE, "center");
			add(_txEventName);
			var _txEventDescription:FlxText = new FlxText(_posTextsX, _posTextsY + 70, FlxG.width - _posTextsX, _eventDescription);
			_txEventDescription.setFormat(_FONT, 26, FlxColor.WHITE, "center");
			add(_txEventDescription);
			
			// Armar la linea de tiempo
			var _eventDuration:Int = MenuState.eventCollection.get(_eventID).duracion;
			var _eventExperience:Int = MenuState.eventCollection.get(_eventID).experiencia;
			var _timeLineWidth:Int = 10;
			var _markerWidth:Int = 10;
			var _markerHeight:Int = 4;
			var _posTimeLineX:Float = _posBlockX - (_timeLineWidth * 2);
			var _posTimeLineY:Float = _posBlockY + (_markerHeight / 2);
			// Linea base
			var _timeLineSprite1:FlxSprite = new FlxSprite(_posTimeLineX, _posTimeLineY);
			_timeLineSprite1.makeGraphic(_timeLineWidth, _HeightBlock, FlxColor.YELLOW);
			add(_timeLineSprite1);
			// Marcador negro
			var _timeLineSprite2:FlxSprite = new FlxSprite(_posTimeLineX - (_markerWidth - _timeLineWidth), _posTimeLineY + _HeightBlock - (_markerHeight / 2));
			_timeLineSprite2.makeGraphic(_markerWidth, _markerHeight, FlxColor.BLACK);
			add(_timeLineSprite2);
			var _fontLineSize:Int = 18;
			var _txTimeLineDuration:FlxText = new FlxText(0, _posTimeLineY + _HeightBlock - _markerHeight -_fontLineSize, 0, "+"+_eventDuration+" meses"); 
			_txTimeLineDuration.setFormat(_FONT, _fontLineSize, FlxColor.WHITE, "right");
			add(_txTimeLineDuration);
			var _txTimeLineExperience:FlxText = new FlxText(0, _posTimeLineY + _HeightBlock, 0, "+"+_eventExperience+" pts."); 
			_txTimeLineExperience.setFormat(_FONT, _fontLineSize, FlxColor.WHITE, "right");
			add(_txTimeLineExperience);
			_index += 1;
		}
		
		// Setear los limites de la camara, para que le scroll no se salga de "pantalla"
		FlxG.camera.setBounds(0, 0, FlxG.width, _FULLHEIGHT);
		
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
		
		// Si el boton del mouse se pulsa, entonces no hay posicion anterior para trabajar
		// por lo que se toma esta como la posicion actual
		if (FlxG.mouse.justPressed) {
			_lastPosY = FlxG.mouse.screenY;
		}
		
		// Mientras el boton del mouse continue pulsado
		// 1) Calcular cuanto se movio el mouse desde la posicion inicial
		// 2) Mover la camara tanto como se movio el mouse
		// 3) Actualizar la posicion actual de mouse para la proxima llamada de update
		if (FlxG.mouse.pressed) {
			FlxG.camera.scroll.y -= FlxG.mouse.screenY - _lastPosY;
			_lastPosY = FlxG.mouse.screenY;			
		}
		
	}
	
	/**
	 * Esta funcion se llama cuando se tienen que ubicar los bloques de evento en
	 * la pantalla del sumario
	 * 
	 * @param 	posX	Posicion en x (en coordenadas de pantalla)
	 * @param 	posY	Posicion en y (en coordenadas de pantalla)
	 * @param 	eventID	El ID del evento a mostrar
	 * @param 	typeEvent	El tipo de evento (normal, dorado)
	 */ 
	 private function eventBlock(posX:Float, posY:Float, eventID:String, typeEvent:Int = 0):Void
	 {
		add(new FlxSprite(posX, posY, "assets/images/block.png"));
		add(new FlxSprite(posX + 15, posY + 37, "assets/images/icons_150/" + eventID.toLowerCase() + ".png"));
	 }
	
}