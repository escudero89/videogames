package ;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;

/**
 * ...
 * @author ...
 */
class OverallState extends FlxState
{
	public static var _recordGame:Array<RecordPlayer>;
	
	private var _FONT:String = "assets/fonts/LondrinaSolid-Regular.ttf";
	private var _TITLE:String = "Vidas Pasadas";
	
	private var _HeightBlock:Int = 202;
	private var _WidthBlock:Int = 180;
	private var _FULLHEIGHT:Int;
	private var _initialPosTexts:Int = 100;
	private var _initialPosBlocks:Int = 150;
	private var _separationInBlocks:Int = 0;
	
	// Para guardar la posicion anterior en y del mouse, antes de hacer el scroll
	private var _lastPosY:Float;

	override public function create():Void
	{
		
		super.create();
		
		// Cargar algunos eventos para probarlo
		var _recordPlayer = new RecordPlayer();
		_recordPlayer.update(MenuState.eventCollection.get("E2"));
		_recordPlayer.update(MenuState.eventCollection.get("E8"));
		_recordPlayer.update(MenuState.eventCollection.get("E7"));
		_recordPlayer.update(MenuState.eventCollection.get("E12"));
		_recordPlayer.update(MenuState.eventCollection.get("E18"));
		_recordPlayer.update(MenuState.eventCollection.get("E27"));
		_recordPlayer.update(MenuState.eventCollection.get("E28"));
		_recordPlayer.update(MenuState.eventCollection.get("X1"));
		
		_recordGame = new Array<RecordPlayer>();
		_recordGame.push(_recordPlayer);
		_recordGame.push(_recordPlayer);
		_recordGame.push(_recordPlayer);
		
		var _txTitle:FlxText = new FlxText(0, 0, FlxG.width, _TITLE);
		_txTitle.setFormat(_FONT, 96, FlxColor.WHITE, "center");
		add(_txTitle);
		
		_FULLHEIGHT = 0;
		
		var index:Int = 0;
		for (recordPlayer in _recordGame.iterator()) {
			
			var _eventsIDs:Array<String> = recordPlayer.getEventsIds();
			var _posSubTitleY:Int = _initialPosTexts + (((_HeightBlock + _separationInBlocks) * _eventsIDs.length) + 50) * index;
			var _txSubTitle:FlxText = new FlxText(0, _posSubTitleY, FlxG.width, "Vida " + (index+1));
			_txSubTitle.setFormat(_FONT, 64, FlxColor.WHITE, "center");
			add(_txSubTitle);
			
			for 
			
			_FULLHEIGHT += _initialPosTexts + (((_HeightBlock + _separationInBlocks) * recordPlayer.getEventsIds().length + 50) * (index + 1));
			
			index += 1;
			
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
	 * la pantalla
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