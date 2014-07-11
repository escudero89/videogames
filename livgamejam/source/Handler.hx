package ;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;

import Card;

/**
 * Esta clase se encarga de manejar las tarjetas a mostrar. Desde las 3 principales a las 9 secundarias
 * @author 
 */
class Handler extends FlxTypedGroup<FlxBasic>
{
	
	// Aqui se va a guardar toda la coleccion de cartas
	private var _cardGroup:FlxTypedGroup<Card>;
	
	// Posicion de todas las cartas (ver getInfrastructure)
	private var _posCardArray:Array<FlxPoint>;
	
	public function new(cardGroup:FlxTypedGroup<Card> = null)
	{
		super();
		
		_cardGroup = cardGroup;
		_posCardArray = getInfrastructure();
		
		var tarjeta1 = new Card(_posCardArray[0].x, _posCardArray[0].y);
		var tarjeta2 = new Card(_posCardArray[4].x, _posCardArray[4].y);
		var tarjeta3 = new Card(_posCardArray[8].x, _posCardArray[8].y);

		add(tarjeta1); 
		add(tarjeta1.getMiniCard(_posCardArray[1]));
		add(tarjeta1.getMiniCard(_posCardArray[2]));
		add(tarjeta1.getMiniCard(_posCardArray[3]));
		
		add(tarjeta2);
		add(tarjeta2.getMiniCard(_posCardArray[5]));
		add(tarjeta2.getMiniCard(_posCardArray[6]));
		add(tarjeta2.getMiniCard(_posCardArray[7]));
		
		add(tarjeta3);
		add(tarjeta3.getMiniCard(_posCardArray[9]));
		add(tarjeta3.getMiniCard(_posCardArray[10]));
		add(tarjeta3.getMiniCard(_posCardArray[11]));
		
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
		miniCardPos.x += Math.round(Card._CARD_WIDTH / 2 - Card._MINICARD_WIDTH / 2);
		
		if (type == 0) { // LEFT MINICARD
			miniCardPos.x -= 64;
			
		} else if (type == 2) { // RIGHT MINICARD
			miniCardPos.x += 64;
		}
		
		return miniCardPos;
	}
	
}