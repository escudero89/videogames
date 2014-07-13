package ;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.util.FlxPoint;

import flixel.plugin.MouseEventManager;

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
	//private var _SUBTITLE:String = "El camino recorrido";
	private var _AGE:Int;
	private var _EXP:Int;
	private var _historyEventsIDs:Array<String>;
	private var _HeightBlock:Int = 202;
	private var _WidthBlock:Int = 180;
	private var _FULLHEIGHT:Int;
	private var _initialPosBlocks:Int = 350;
	private var _separationInBlocks:Int = -22;
	
	// Para guardar la posicion anterior en y del mouse, antes de hacer el scroll
	private var _lastPosY:Float;
	
	var _closeButton:FlxButton;
	
	var _camera:FlxCamera;	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		FlxG.plugins.add(new MouseEventManager());
		
		_recordPlayer = PlayState._recordPlayer;
		// Cargar algunos eventos para probarlo
		/*_recordPlayer = new RecordPlayer();
		_recordPlayer.update(MenuState.eventCollection.get("E2"));
		_recordPlayer.update(MenuState.eventCollection.get("E8"));
		_recordPlayer.update(MenuState.eventCollection.get("E7"));
		_recordPlayer.update(MenuState.eventCollection.get("E12"));
		_recordPlayer.update(MenuState.eventCollection.get("E18"));
		_recordPlayer.update(MenuState.eventCollection.get("E27"));
		_recordPlayer.update(MenuState.eventCollection.get("E28"));
		_recordPlayer.update(MenuState.eventCollection.get("X1"));
		**/
		// setear valores generales
		_AGE = _recordPlayer.getAgeInYears();
		_EXP = _recordPlayer._experiencePlayer;
		_historyEventsIDs = _recordPlayer.getEventsIds();
		_FULLHEIGHT = _initialPosBlocks + (_HeightBlock + _separationInBlocks) * _historyEventsIDs.length + 50;
		
		var _fondoColina:FlxSprite = new FlxSprite(0, 0, "assets/images/colinaSumario.png");
		add(_fondoColina);
		
		FlxG.camera.focusOn(new FlxPoint(0, 0));
		FlxG.camera.bgColor = 0xff171200;
		
		var _txTitle:FlxText = new FlxText(0, 0, FlxG.width, _TITLE);
		_txTitle.setFormat(_FONT, 128, FlxColor.WHITE, "center");
		add(_txTitle);
		
		//var _txSubTitle:FlxText = new FlxText(0, _txTitle.size, FlxG.width, _SUBTITLE);
		//_txSubTitle.setFormat(_FONT, 64, FlxColor.WHITE, "center");
		//add(_txSubTitle);
		
		var _txAge:FlxText = new FlxText(0, 240, FlxG.width, "Edad: "+_AGE+" años");
		_txAge.setFormat(_FONT, 32, FlxColor.WHITE, "center");
		add(_txAge);
		
		var _txExp:FlxText = new FlxText(0, 280, FlxG.width, "Exp.: "+_EXP+" puntos");
		_txExp.setFormat(_FONT, 32, FlxColor.WHITE, "center");
		add(_txExp);
		
		// Mostrar los bloques y textos de los eventos anteriores
		var _index:Int = _historyEventsIDs.length - 1;
		while (_index >= 0) {
			
			var _eventID:String = _historyEventsIDs[_index];
						
			// Poner los textos (si es el ultimo, hacemos una consideracion especial)
			var _eventName:String = MenuState.eventCollection.get(_eventID).nombre;
			var _eventDescription:String = MenuState.eventCollection.get(_eventID).descripcion;
			
			var idRiesgo:String = null;
			
			if (_index == _historyEventsIDs.length - 1) {
				idRiesgo = MenuState.eventCollection[_eventID].id_riesgo;
				
				_eventName = MenuState.riskCollection[idRiesgo].content["nombre"];
				_eventDescription = MenuState.riskCollection[idRiesgo].content["descripcion"];
			}
			
			// Ponerlos bloques
			var _posBlockX:Float = ((FlxG.width / 2) - (_WidthBlock / 2)) - 130;
			// Un bloque abajo del otro:
			// posicion inicial + altura de la carta + separacion entre cartas
			var _posBlockY:Float = _initialPosBlocks + (_HeightBlock + _separationInBlocks) * _index;
			eventBlock(_posBlockX, _posBlockY, _eventID, 0, idRiesgo);
			
			// Centrado en la pantalla en x
			var _posTextsX:Float = _posBlockX + _WidthBlock + 10;
			var _posTextsY:Float = _posBlockY + 40;
			var _txEventName:FlxText = new FlxText(_posTextsX, _posTextsY, FlxG.width - _posTextsX, _eventName);
			_txEventName.setFormat(_FONT, 32, FlxColor.WHITE, "left");
			add(_txEventName);
			var _txEventDescription:FlxText = new FlxText(_posTextsX, _posTextsY + 70, FlxG.width - _posTextsX, _eventDescription);
			_txEventDescription.setFormat(_FONT, 26, FlxColor.WHITE, "left");
			add(_txEventDescription);
			
			_index -= 1;
		}
		
		// Armar una linea del tiempo vertical
		var _timeLineWidth:Int = 10;
		var _timeLineHeight:Int = _FULLHEIGHT - _initialPosBlocks - 50;
		var _posTimeLineX:Float = 65;
		var _posTimeLineY:Float = _initialPosBlocks;
		var _timeLine:FlxSprite = new FlxSprite(_posTimeLineX, _posTimeLineY);
		_timeLine.makeGraphic(_timeLineWidth, _timeLineHeight, FlxColor.BLACK);
		add(_timeLine);
		
		var _timeLineHeightYear:Float = _timeLineHeight / (_AGE - 13);
		var _timeLineYear:Int = 14;
		
		var _markerWidth:Int = _timeLineWidth;
		var _markerHeight:Int = 4;
		var _posMarkerX:Float = _posTimeLineX;
		var _posMarkerY:Float = _initialPosBlocks + _timeLineHeightYear;
		while (_posMarkerY < _FULLHEIGHT) {
			var _timeLineMarker:FlxSprite = new FlxSprite(_posMarkerX, _posMarkerY);
			_timeLineMarker.makeGraphic(_markerWidth, _markerHeight, FlxColor.BLACK);
			add(_timeLineMarker);
			var _txTLFontSize:Int = 16;
			var _txTimeLineMarker:FlxText = new FlxText(0, _posMarkerY - (_txTLFontSize / 2), _posMarkerX, "" + _timeLineYear + " años");
			_txTimeLineMarker.setFormat(_FONT, _txTLFontSize, FlxColor.WHITE, "center");
			add(_txTimeLineMarker);
			_timeLineYear += 1;
			_posMarkerY += _timeLineHeightYear;
		}
		
		// Crear boton para salir del State
		var _closeButtonWidth:Int = 50;
		var _closeButtonHeight:Int = 50;
		_closeButton = new FlxButton(FlxG.width - _closeButtonWidth, 0, "", goMenuState);
		_closeButton.loadGraphic("assets/images/util/btnClose.png");
		add(_closeButton);
		
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
	 
	private function goMenuState():Void
	{
		FlxG.switchState(new MenuState());
	}
	
}