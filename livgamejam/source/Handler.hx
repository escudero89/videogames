package ;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;

import Card;
import Event;

/**
 * Esta clase se encarga de manejar las tarjetas a mostrar. Desde las 3 principales a las 9 secundarias
 * @author 
 */
class Handler extends FlxTypedGroup<FlxBasic>
{
	
	// Coleccion de eventos
	private var _eventCollection:Array<Event>;
	
	// Aqui estan las cartas mostradas
	private var _cardCurrentCollection:FlxTypedGroup<Card>;
	
	// Aqui se va a guardar toda la coleccion de cartas
	private var _cardCollection:FlxTypedGroup<Card>;
	
	// Posicion de todas las cartas (ver getInfrastructure)
	private var _posCardArray:Array<FlxPoint>;
	
	public function new(eventCollection:Array<Event> = null)
	{
		super();
		
		_eventCollection = eventCollection;
		_posCardArray = getInfrastructure();
		
		_cardCurrentCollection = new FlxTypedGroup<Card>();
		
		//var eventoPrueba = new Event('E1', 'Saltar turno', '', 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'R1', 0, 0, 10, 0, 0, 0, 0, 0);
		
		// tomando un evento de la base de datos, para pobar si carga bien
		var eventoPrueba = _eventCollection[1];
		
		// Normalcards
		for (i in 0...3) {
			add(_cardCurrentCollection.add(new Card(eventoPrueba, _posCardArray[i + 3 * i]))); // 0 , 4, 8
			
			// Minicards
			for (j in 0...3) {
				add(_cardCurrentCollection.add(new Card(eventoPrueba, _posCardArray[i + j + 1 + 3 * i], true))); // 1,2,3,5,6,7,...
			}
		}

	}
	
	// Retorna las cartas para la visualizacion adecuada
	
	public function getCurrentCards()
	{
		
	}
	
	// Obtiene la infraestructura (las posiciones de cada carta)
	// El formato es [ posCard1 , posMiniCard1, posMiniCard2, posMiniCard3, posCard2, ...] => array.length = 12
	private function getInfrastructure():Array<FlxPoint>
	{
		var infrastructure = new Array<FlxPoint>();
		
		var basePositionX = 31;
		var basePositionY = 128;
		
		var amountCards = 3;
		
		while (amountCards > 0) {
			
			infrastructure.push(new FlxPoint(basePositionX, basePositionY));
			
			// Por cada 3 cartas superiores
			for ( i in 0...3) {
				infrastructure.push(getInfraestructureHelper(new FlxPoint(basePositionX, basePositionY), i));
			}
			
			// Decrementamos la cantidad de cartas y movemos la posicion en x
			basePositionX += 200;
			amountCards--;
		
		}
		
		return infrastructure;
	}
	
	// Retorna los puntos para posicionar las 3 tarjetas superiores (type 1: left, 2: center: 3:right)
	private function getInfraestructureHelper(miniCardPos:FlxPoint, type:Int):FlxPoint
	{
		miniCardPos.y -= 64;
		miniCardPos.x += Math.round(Card._CARD_WIDTH / 2 - Card._CARD_MINI_WIDTH / 2);
		
		if (type == 0) { // LEFT MINICARD
			miniCardPos.x -= 64;
			
		} else if (type == 2) { // RIGHT MINICARD
			miniCardPos.x += 64;
		}
		
		return miniCardPos;
	}
	
}