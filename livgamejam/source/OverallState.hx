package ;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.util.FlxPoint;

/**
 * ...
 * @author ...
 */
class OverallState extends FlxState
{
	public static var _recordGame:Array<RecordPlayer> = new Array<RecordPlayer>();
	
	private var _FONT:String = "assets/fonts/LondrinaSolid-Regular.ttf";
	private var _TITLE:String = "Vidas Pasadas";
	
	private var _HeightBlock:Int = 202;
	private var _WidthBlock:Int = 180;
	private var _FULLHEIGHT:Int;
	private var _initialPosText:Int = 100;
	private var _initialPosBlocks:Int = 200;
	private var _separationInBlocks:Int = -22;
	
	// Para guardar la posicion anterior en y del mouse, antes de hacer el scroll
	private var _lastPosY:Float;
	
	private var _closeButton:FlxButton;

	override public function create():Void
	{
		
		super.create();
		
		//// Cargar algunos eventos para probarlo
		//var _recordPlayer = new RecordPlayer();
		//_recordPlayer.update("E2");
		//_recordPlayer.update("E8");
		//_recordPlayer.update("E13");
		//_recordPlayer.update("E19");
		//_recordPlayer.update("E4");
		//_recordPlayer.update("E2");
		//_recordPlayer.update("E2");
		//_recordPlayer.update("X1");
		//
		//_recordGame = new Array<RecordPlayer>();
		//_recordGame.push(_recordPlayer);
		//_recordGame.push(_recordPlayer);
		//_recordGame.push(_recordPlayer);
		
		_recordGame = SummaryState._recordGame;
		
		var _fondoColina:FlxSprite = new FlxSprite(0, 0, "assets/images/colinaSumario.png");
		add(_fondoColina);
		
		var _txTitle:FlxText = new FlxText(0, 0, FlxG.width, _TITLE);
		_txTitle.setFormat(_FONT, 96, FlxColor.WHITE, "center");
		add(_txTitle);
		
		// Setear la posicion inicial de la lista de bloques y textos actuales
		var _currentPosBlock:Int = _initialPosBlocks;
		var _currentPosText:Int = _initialPosText;
		_FULLHEIGHT = _initialPosText;
		
		if (_recordGame.length < 1) {
			_FULLHEIGHT = FlxG.height;
		}
		
		var index1:Int = 0;
		for (recordPlayer in _recordGame.iterator()) {
			
			var _eventsIDs:Array<String> = recordPlayer.getEventsIds();
			
			// setear valores generales
			var _age:Int = recordPlayer.getAgeInYears();
			var _exp:Int = recordPlayer._experiencePlayer;		
			
			var _heightEvents:Int;
			_heightEvents = drawEventsPlayer(_currentPosBlock, _WidthBlock, _HeightBlock, _separationInBlocks, recordPlayer.getEventsIds());
			
			// Armar una linea del tiempo vertical
			drawTimeLine(65, _currentPosBlock + 22, 10, _heightEvents, FlxColor.BLACK, FlxColor.WHITE, _age);
			
			var _posSubTitleY:Int = _currentPosText;
			var _txSubTitle:FlxText = new FlxText(0, _posSubTitleY, FlxG.width, "Vida " + (index1+1) + " (" + _exp + " pts.):");
			_txSubTitle.setFormat(_FONT, 64, FlxColor.WHITE, "center");
			add(_txSubTitle);
			
			_FULLHEIGHT += Math.floor(_txSubTitle.size) + _heightEvents + 100;
			_currentPosText = _FULLHEIGHT;
			_currentPosBlock = _FULLHEIGHT + 100;
			
			index1 += 1;
			
		}
		
		// Crear boton para salir del State
		var _closeButtonWidth:Int = 50;
		var _closeButtonHeight:Int = 50;
		_closeButton = new FlxButton(FlxG.width - _closeButtonWidth, 0, "", goMenuState);
		_closeButton.loadGraphic("assets/images/util/btnClose.png");
		add(_closeButton);
		
		// Setear los limites de la camara, para que le scroll no se salga de "pantalla"
		FlxG.camera.focusOn(new FlxPoint(0, 0));
		FlxG.camera.bgColor = 0xff171200;
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
	 * Funcion que se encarga de ubicar la lista completa de eventos
	 * del jugador y devolver la altura en pantalla de la misma
	 * 
	 * @param 	posInitialY	Int. Altura inicial, en la pantalla, donde se dibujara
	 * @param 	widthBlock	Int. Ancho de los bloques
	 * @param 	heightBlock	Int. Altura de los bloques
	 * @param 	separationBlocks	Int. Separacion entre los bloques
	 * @param 	historyEventsIDs	Array<String>. Listado de IDs de los eventos
	 */ 	
	private function drawEventsPlayer(posInitialY:Int, widthBlock:Int, heightBlock:Int, separationBlocks:Int, historyEventsIDs:Array<String>):Int
	{
		// Mostrar los bloques y textos de los eventos anteriores
		var _index:Int = historyEventsIDs.length - 1;
		while (_index >= 0) {
			
			var _eventID:String = historyEventsIDs[_index];
						
			// Poner los textos (si es el ultimo, hacemos una consideracion especial)
			var _eventName:String = MenuState.eventCollection.get(_eventID).nombre;
			var _eventDescription:String = MenuState.eventCollection.get(_eventID).descripcion;
			
			var idRiesgo:String = null;
			
			if (_index == historyEventsIDs.length - 1) {
				idRiesgo = MenuState.eventCollection.get(_eventID).id_riesgo;
				
				_eventName = MenuState.riskCollection[idRiesgo].content["nombre"];
				_eventDescription = MenuState.riskCollection[idRiesgo].content["descripcion"];
			}
			
			// Ponerlos bloques
			var _posBlockX:Float = ((FlxG.width / 2) - (widthBlock / 2)) - 130;
			// Un bloque abajo del otro:
			// posicion inicial + altura de la carta + separacion entre cartas
			var _posBlockY:Float = posInitialY + ((heightBlock + separationBlocks) * _index);
			eventBlock(_posBlockX, _posBlockY, _eventID, 0, idRiesgo);
			
			// Centrado en la pantalla en x
			var _posTextsX:Float = _posBlockX + widthBlock + 10;
			var _posTextsY:Float = _posBlockY + 40;
			var _txEventName:FlxText = new FlxText(_posTextsX, _posTextsY, FlxG.width - _posTextsX, _eventName);
			_txEventName.setFormat(_FONT, 32, FlxColor.WHITE, "left");
			add(_txEventName);
			var _txEventDescription:FlxText = new FlxText(_posTextsX, _posTextsY + 70, FlxG.width - _posTextsX, _eventDescription);
			_txEventDescription.setFormat(_FONT, 26, FlxColor.WHITE, "left");
			add(_txEventDescription);
			
			_index -= 1;
		}
		
		return (heightBlock + separationBlocks) * historyEventsIDs.length;
	}
	
	/**
	 * Esta funcion se llama cuando se tienen que ubicar los bloques de evento en
	 * la pantalla
	 * 
	 * @param 	posX	Posicion en x (en coordenadas de pantalla)
	 * @param 	posY	Posicion en y (en coordenadas de pantalla)
	 * @param 	eventID	El ID del evento a mostrar
	 * @param 	typeEvent	El tipo de evento (normal, dorado)
	 */ 
	private function eventBlock(posX:Float, posY:Float, eventID:String, typeEvent:Int = 0, idRiesgo:String = null):Void
	{
		var iconoBloque = new FlxSprite(posX + 15, posY + 37, "assets/images/icons_150/" + eventID.toLowerCase() + ".png");
		 
		if (idRiesgo != null) {
			add(new FlxSprite(posX, posY, "assets/images/block_risk.png"));
			iconoBloque.loadGraphic("assets/images/icons_150/e1.png");
		} else {
			add(new FlxSprite(posX, posY, "assets/images/block.png"));
		}
		
		add(iconoBloque);
	}
	
	/**
	 * Esta funcion se encarga de dibujar la linea de tiempo
	 * 
	 * @param 	posX	Posicion inicial en x (en coordenadas de pantalla)
	 * @param 	posY	Posicion inicial en y (en coordenadas de pantalla)
	 * @param 	width	Ancho de la linea
	 * @param 	height	Largo de la linea
	 * @param 	colorLine	Color de la linea
	 * @param 	colorMarker	Color de los marcadores de anio
	 * @param 	maxYear	Anio maximo a incluir
	 * @param 	minYear	Anio minimo a incluir. Por defecto es 13
	 */
	private function drawTimeLine(posX:Int, posY:Int, width:Int, height:Int, colorLine:Int, colorMarker:Int, maxYear:Int, minYear:Int = 13):Void
	{
		var _timeLine:FlxSprite = new FlxSprite(posX, posY);
		_timeLine.makeGraphic(width, height, colorLine);
		add(_timeLine);
		
		var _timeLineHeightYear:Float = height / (maxYear - minYear);
		var _timeLineYear:Int = minYear;
		
		var _markerWidth:Int = width;
		var _markerHeight:Int = 4;
		var _posMarkerX:Float = posX;
		var _posMarkerY:Float = posY;
		while (_timeLineYear <= maxYear) {
			_posMarkerY = posY + (_timeLineHeightYear * (_timeLineYear - minYear));
			var _timeLineMarker:FlxSprite = new FlxSprite(_posMarkerX, _posMarkerY);
			_timeLineMarker.makeGraphic(_markerWidth, _markerHeight, colorMarker);
			add(_timeLineMarker);
			var _txTLFontSize:Int = 16;
			var _txTimeLineMarker:FlxText = new FlxText(0, _posMarkerY - (_txTLFontSize / 2), _posMarkerX, "" + _timeLineYear + " años");
			_txTimeLineMarker.setFormat(_FONT, _txTLFontSize, FlxColor.WHITE, "center");
			add(_txTimeLineMarker);
			_timeLineYear += 1;
		}
	}
	
	private function goMenuState():Void
	{
		FlxG.switchState(new MenuState());
	}	
}