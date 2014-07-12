package ;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.util.FlxRect;
import flixel.util.FlxPoint;

/**
 * ...
 * @author 
 */
class Timmy extends FlxTypedGroup<FlxTypedGroup<FlxSprite> >
{

	// Un grupo para la parte delantera, y otro para la trasera
	private var _interfaceFront:FlxTypedGroup<FlxSprite>;
	private var _interfaceBack:FlxTypedGroup<FlxSprite>;
	
	// para la cabeza y el cuerpo
	private var _head:FlxSprite;
	private var _body:FlxSprite;
	
	private var _fondoColina:FlxSprite;
	private var _platform:FlxSprite;
	private var _blockCollection:FlxTypedGroup<FlxSprite>;
	
	public function new() 
	{
		super();
		
		_interfaceFront = new FlxTypedGroup<FlxSprite>();
		_interfaceBack = new FlxTypedGroup<FlxSprite>();
		
		// colina
		
		_fondoColina = new FlxSprite(0, 960);
		_fondoColina.loadGraphic("assets/images/colina.png");
		_fondoColina.y -= _fondoColina.height;
		
		_interfaceBack.add(_fondoColina);
		
		// Plataforma
		
		_platform = new FlxSprite(142, 500, "assets/images/platform.png");
		
		// Controlamos la camara que siga a la plataforma
		FlxG.camera.follow(_platform);
		FlxG.camera.setBounds(0, -20000, 640, 20960);
		var rect = new FlxRect(0, _platform.y, 640, _platform.height);
		FlxG.camera.deadzone = rect;
		FlxG.camera.followLerp = 3;
		
		_interfaceFront.add(_platform);
		
		// Resto del cuerpo
		
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
		
		_interfaceFront.add(_body);
		_interfaceFront.add(_head);
		
		// Agregamos la parte delarenta, y luego la parte trasera
		add(_interfaceBack);
		add(_interfaceFront);
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
		

		updateBackground(cardIdEvento);
	}
	
	// Actualiza el fondo
	private function updateBackground(cardIdEvento:String) {
		
		FlxG.camera.flash(FlxColor.WHITE, 0.1);
		
		FlxTween.tween(_fondoColina, { y: (_fondoColina.y - 90) }, 5);
		FlxTween.tween(_platform, { y: (_platform.y - 180) }, 5);
		FlxTween.tween(_head, { y: (_head.y - 180) }, 5);
		FlxTween.tween(_body, { y: (_body.y - 180) }, 5);		
		
		// Y creamos los bloques
		var posY = _platform.y + 100;
		
		_interfaceBack.add(new FlxSprite(230, posY, "assets/images/block.png"));
		_interfaceBack.add(new FlxSprite(245, posY + 37, "assets/images/icons_150/" + cardIdEvento.toLowerCase() + ".png"));
	}

	/// FUNCIONES GETS
	public function getInterfaceBack():FlxTypedGroup<FlxSprite>
	{
		return _interfaceBack;
	}
	
	public function getInterfaceFront():FlxTypedGroup<FlxSprite>
	{
		return _interfaceFront;
	}
		
}