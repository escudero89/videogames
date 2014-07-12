package ;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

/**
 * ...
 * @author 
 */
class Timmy extends FlxTypedGroup<FlxSprite>
{

	// para la cabeza y el cuerpo
	private var _head:FlxSprite;
	private var _body:FlxSprite;
	
	private var _platform:FlxSprite;
	private var _blockCollection:FlxTypedGroup<FlxSprite>;
	
	public function new() 
	{
		super();
		
		_blockCollection = new FlxTypedGroup<FlxSprite>();
		
		_platform = new FlxSprite(142, 500, "assets/images/platform.png");
		add(_platform);
		
		_head = new FlxSprite(250, 380);
		_body = new FlxSprite(265, 480);
		
		_head.loadGraphic("assets/images/timmy/cabezas.png", true, 150);
		_body.loadGraphic("assets/images/timmy/cuerpos.png", true,142);
		
		_body.animation.add("joven_frente", [0]);
		_body.animation.add("joven_espalda", [1]);
		_body.animation.add("joven_apuntando", [2]);
		_body.animation.add("adulto_frente", [3]);
		_body.animation.add("adulto_espalda", [4]);
		_body.animation.add("adulto_apuntando", [5]);
		_body.animation.add("anciano_frente", [6]);
		_body.animation.add("anciano_espalda", [7]);
		_body.animation.add("anciano_apuntando", [8]);
		
		_head.animation.add("joven_espalda", [0]);
		_head.animation.add("joven_frente", [1]);
		_head.animation.add("joven_frente_1", [2]);
		_head.animation.add("joven_frente_2", [3]);
		_head.animation.add("adulto_espalda", [4]);
		_head.animation.add("adulto_frente", [5]);
		_head.animation.add("adulto_frente_1", [6]);
		_head.animation.add("adulto_frente_2", [7]);
		_head.animation.add("anciano_espalda", [8]);
		_head.animation.add("anciano_frente", [9]);
		_head.animation.add("anciano_frente_1", [10]);
		_head.animation.add("anciano_frente_2", [11]);
		
		add(_body);
		add(_head);
	}

	override public function update():Void
	{
		_body.animation.play("joven_apuntando");
		super.update();
	}
	
	
	public function updatePayer():Void
	{
		
	}
		
	
	// Esta funcion se llama cada vez que se elige una nueva carta
	// Como argumento se le pasa el valor 1, 2, o 3, dependiendo la posicion de la carta (izq, centro y der respectivamente)
	// Y el ID_EVENTO de la carta elegida, para poder acceder a MenuState.eventCollection[cardIdEvento] y tomar el evento adecuado
	public function newChoice(choseCard:Int, cardIdEvento:String) {
		
		
	}
	
}