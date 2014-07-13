package ;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.util.FlxRect;
import flixel.util.FlxPoint;
import haxe.Timer;

import flixel.util.FlxGradient;

/**
 * ...
 * @author 
 */
class Timmy extends FlxTypedGroup<FlxTypedGroup<FlxSprite> >
{

	// Un grupo para la parte delantera, y otro para la trasera
	private var _interfaceFront:FlxTypedGroup<FlxSprite>;
	private var _interfaceBack:FlxTypedGroup<FlxSprite>;
	private var _flag_choice:Bool;
	private var _valor_ref_old:Float;
	private var _flag_izq:Bool;
	private var _timmy_skin:String;
	
	// Quiero tener la edad a mano (en anhos), la maxima edad la uso para interpolar
	private var _age:Int;
	private var _maxAge:Int = 100;
	
	// para la cabeza y el cuerpo
	private var _head:FlxSprite;
	private var _body:FlxSprite;
	
	private var _currentOffset:Int = 0;
	private var _currentBlock:FlxSprite;
	
	// Para el cielo =>
	
	private var _skyBackground:FlxSprite;
	private var _nightBackground:FlxSprite;
	
	private var _SKY_COLOR_TOP:Int = 0xff61dcff;
	private var _SKY_COLOR_BOTTOM:Int = 0xffffffff;
	
	private var _NIGHT_COLOR_TOP:Int = 0xff000000;
	private var _NIGHT_COLOR_BOTTOM:Int = 0xff0033b4;
	// <=
	
	private var _fondoColina:FlxSprite;
	private var _ladder:FlxSprite;
	private var _platform:FlxSprite;
	private var _blockCollection:FlxTypedGroup<FlxSprite>;
	
	public function new() 
	{
		super();
		
		_interfaceFront = new FlxTypedGroup<FlxSprite>();
		_interfaceBack = new FlxTypedGroup<FlxSprite>();
		_flag_choice = true;
		_flag_izq = false;
		
		// creamos el cielo de dia y el de noche, pero este ultimo sin alpha
		
		_skyBackground = FlxGradient.createGradientFlxSprite(640, 960, [_SKY_COLOR_TOP, _SKY_COLOR_BOTTOM]);
		_nightBackground = FlxGradient.createGradientFlxSprite(640, 960, [_NIGHT_COLOR_TOP, _NIGHT_COLOR_BOTTOM]);
		
		_skyBackground.scrollFactor.set(0, 0);
		_nightBackground.scrollFactor.set(0, 0);
		
		_nightBackground.alpha = (_age - 13)/_maxAge;
		
		_interfaceBack.add(_skyBackground);
		_interfaceBack.add(_nightBackground);
		
		// Y luego la colina
		
		_fondoColina = new FlxSprite(0, 1500, "assets/images/colina.png");
		_fondoColina.y -= _fondoColina.height;
		
		_interfaceBack.add(_fondoColina);

		// Escaleras
		
		_ladder = new FlxSprite(0, 720, "assets/images/escaleras.png");
		_interfaceBack.add(_ladder);
		
		// Plataforma
		
		_platform = new FlxSprite(142, 495, "assets/images/platform.png");
		
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
		_body.loadGraphic("assets/images/timmy/cuerpos.png", true, 141);//142);
		
		_body.animation.add("joven_espalda", [0]);
		_body.animation.add("joven_frente", [1]);
		_body.animation.add("joven_apuntando", [2]);
		_body.animation.add("adulto_espalda", [3]);
		_body.animation.add("adulto_frente", [4]);
		_body.animation.add("adulto_apuntando", [5]);
		_body.animation.add("anciano_espalda", [6]);
		_body.animation.add("anciano_frente", [7]);
		_body.animation.add("anciano_apuntando", [8]);
		
		_head.animation.add("joven_espalda", [0]);
		_head.animation.add("joven_pestaneando", [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,3,3]);
		//_head.animation.add("joven_frente_1", [2]);
		//_head.animation.add("joven_frente_2", [3]);
		_head.animation.add("adulto_espalda", [4]);
		_head.animation.add("adulto_pestaneando", [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,7,7]);
		//_head.animation.add("adulto_frente_1", [6]);
		//_head.animation.add("adulto_frente_2", [7]);
		_head.animation.add("anciano_espalda", [8]);
		_head.animation.add("anciano_pestaneando", [9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,10,11,11]);
		//_head.animation.add("anciano_frente_1", [10]);
		//_head.animation.add("anciano_frente_2", [11]);
		
		_interfaceFront.add(_body);
		_interfaceFront.add(_head);
		_valor_ref_old = _body.y - 20;
		_timmy_skin = "joven";
	}

	override public function update():Void
	{
		super.update();
		
		if (((_valor_ref_old - 20) >= _body.y) && _flag_choice == false) {
			_body.flipX = false;
			_body.animation.play(_timmy_skin + "_frente");
			_head.animation.play(_timmy_skin + "_pestaneando");
			if (_flag_izq) {
				_flag_izq = false;
				_body.x = _body.x +  24;
			}
		}
		
		if ((_valor_ref_old - 180) == _body.y) {
			_flag_choice = true;
			_body.animation.play(_timmy_skin + "_espalda");
			_head.animation.play(_timmy_skin + "_espalda");
		}
		
	}
		
	
	// Esta funcion se llama cada vez que se elige una nueva carta
	// Como argumento se le pasa el valor 1, 2, o 3, dependiendo la posicion de la carta (izq, centro y der respectivamente)
	// Y el ID_EVENTO de la carta elegida, para poder acceder a MenuState.eventCollection[cardIdEvento] y tomar el evento adecuado
	public function newChoice(choseCard:Int, cardIdEvento:String) {
		updateMoves(choseCard,_body.y);
		updateBackground(cardIdEvento);
	}
	
	//Actualiza movimientos de timmy
	public function updateMoves(_flag_arm:Int,_val_ref:Float)
	{
		_flag_choice = false;
		_valor_ref_old = _val_ref;
		
		if (_flag_arm == 1) {
			_body.animation.play(_timmy_skin + "_apuntando");
			_body.flipX = true;
			_body.x = _body.x - 24;
			_flag_izq = true;
		}
		else{
			_body.animation.play(_timmy_skin + "_apuntando");
		}		
	}
	
	// Actualiza el fondo
	private function updateBackground(cardIdEvento:String):Void
	{
		
		FlxG.camera.flash(FlxColor.WHITE, 0.1);
		
		FlxTween.tween(_fondoColina, { y: (_fondoColina.y - 90) }, 5);
		FlxTween.tween(_platform, { y: (_platform.y - 180) }, 5);
		FlxTween.tween(_head, { y: (_head.y - 180) }, 5);
		FlxTween.tween(_body, { y: (_body.y - 180) }, 5);		
		
		// Y creamos los bloques, aunque aun no le agregamos el evento
		_currentBlock = new FlxSprite(230, _platform.y + 100, "assets/images/block.png");
		_interfaceBack.add(_currentBlock);

	}
	
	// Hace la magia del movimiento
	public function moveMagic(cardIdEvento:String, magic:FlxSprite):Void
	{
		// Esto no anda :c (el magic se define en Card)
		if (magic.animation.finished) {
			magic.animation.play("sphere");	
		}
		
		magic.y -= _currentOffset;
		
		_interfaceFront.add(magic);
		
		FlxTween.tween(magic, { x : 320 - magic.width / 2 , y: _platform.y + _platform.height / 2 }, 3);
		
		// Cambia el color del cielo (lo vamos oscureciendo) al ponerle el fondo mas opaco arriba
		_nightBackground.alpha = Math.min((_age - 13) / _maxAge, 1); 
		
		Timer.delay(function() {
			magic.destroy();
			_interfaceBack.add(new FlxSprite(245, _currentBlock.y + 37, "assets/images/icons_150/" + cardIdEvento.toLowerCase() + ".png"));
			
			// Esto es para informarle al resto cuanto estamos desplazados
			_currentOffset += 180;
		}, 3000);
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
		
	public function getEsaBandera() {
		return _flag_choice;
	}
	
	public function setAge(ageMonthly:Int) {
		
		_age = Math.floor(ageMonthly / 12);
		
		if (_age <= 25) {
			_timmy_skin = "joven";
		}
		if (_age > 25 && _age < 65) {
			_timmy_skin = "adulto";
		}
		if(_age > 65){
			_timmy_skin = "anciano";
		}
		
	}
	
	override public function destroy():Void
	{
		this.forEach(function(group:FlxTypedGroup<FlxSprite>) {
			group.forEach(function(sprite:FlxSprite) { sprite.destroy(); } );
			} );
			
		super.destroy();
	}
}