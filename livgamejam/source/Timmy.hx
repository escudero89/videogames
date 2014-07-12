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
		
		_platform = new FlxSprite(142, 400, "assets/images/platform.png");
		add(_platform);
		/*
		_head = new FlxSprite();
		_body = new FlxSprite();
		
		add(_head);
		add(_body);*/
	}

	override public function update():Void
	{
		super.update();
	}
	
	// Esta funcion se llama cada vez que se elige una nueva carta
	// Como argumento se le pasa el valor 1, 2, o 3, dependiendo la posicion de la carta (izq, centro y der respectivamente)
	// Y el ID_EVENTO de la carta elegida, para poder acceder a MenuState.eventCollection[cardIdEvento] y tomar el evento adecuado
	public function newChoice(choseCard:Int, cardIdEvento:String) {
		
		
	}
	
}