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
	
	public function new(cardGroup:FlxTypedGroup<Card> = null)
	{
		super();
		
		_cardGroup = cardGroup;
		
		var tarjeta1 = new Card(31, 128);
		var tarjeta2 = new Card(231, 128);
		var tarjeta3 = new Card(431, 128);
		
		add(tarjeta1); add(tarjeta1.setIcon()); add(tarjeta1.setText()); add(tarjeta1.setTextStats()); add(tarjeta1.getMiniCard(24, 64));
		add(tarjeta2); add(tarjeta2.setIcon()); add(tarjeta2.setText()); add(tarjeta2.setTextStats()); add(tarjeta2.getMiniCard(86, 64));
		add(tarjeta3); add(tarjeta3.setIcon()); add(tarjeta3.setText()); add(tarjeta3.setTextStats()); add(tarjeta3.getMiniCard(148, 64));
		
	}
	
	// Retorna las cartas para la visualizacion adecuada
	
	public function getCurrentCards()
	{
		
	}
	
	// Obtiene la infraestructura (las posiciones de cada carta)
	private function getInfrastructure():Array<FlxPoint>
	{
		var infrastructure = new Array<FlxPoint>();
		
		var basePosition = new FlxPoint(31, 128);
		
		var amountCards = 3;
		
		while (amountCards > 0) {
			
			infrastructure.push(basePosition);
			
			// Por cada 3 cartas superiores
			for ( i in 1...3) {
				getInfraestructureHelper(infrastructure[infrastructure.length - 1], i);
			}
			
			// Decrementamos la cantidad de cartas y movemos la posicion en x
			basePosition.x += 200;
			amountCards--;
		
		}
		
		return infrastructure;
	}
	
	// Retorna los puntos para posicionar las 3 tarjetas superiores (type 1: left, 2: center: 3:right)
	private function getInfraestructureHelper(initialPos:FlxPoint, type:Int):FlxPoint
	{
		var miniCardPos:FlxPoint = new FlxPoint(initialPos.x, initialPos.y);
		
		miniCardPos.y -= 64;
		miniCardPos.x += Math.round(Card._CARD_WIDTH / 2 - Card._MINICARD_WIDTH / 2);
		
		if (type == 1) { // LEFT MINICARD
			miniCardPos.x -= 64;
			
		} else if (type == 3) { // RIGHT MINICARD
			miniCardPos.x += 64;
		}
		
		return miniCardPos;
	}
	
}