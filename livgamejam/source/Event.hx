package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;

import flixel.plugin.MouseEventManager;

/**
 * ...
 * @author 
 */
class Event extends FlxSprite
{
	
	// Icono
	
	private var _icono:FlxSprite;
	
	// Atributos internos
	
	private var _experience:Int;
	private var _duration:Int;
	
	// Para las strings
	
	private static var _STR_FONT = "assets/fonts/LondrinaSolid-Regular.ttf";
	
	private var _txt_title:FlxText;
	
	private var _str_title = 'CASARTE';
	private var _str_experience = ' meses';
	private var _str_duration = ' ptos. de exp.';
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic("assets/images/template_basic.png");
		
		MouseEventManager.add(this, onMouseDown, onMouseUp, onMouseOver, onMouseOut);
		
		_experience = 250;
		_duration = 12;
		
	}
	
	// Coloca el icono central
	
	public function setIcon():FlxSprite
	{
		_icono = new FlxSprite();
		_icono.loadGraphic("assets/images/icon_default.png");
		
		_icono.x = this.x + Math.round(this.width / 2) - Math.round(_icono.width / 2);
		_icono.y = this.y + 61;
		
		return _icono;
	}
	
	// Coloca el texto
	
	public function setText():FlxText
	{
		_txt_title = new FlxText(15 + this.x, 15 + this.y, 150, _str_title, 20, true);
		
		_txt_title.setFormat(_STR_FONT, 36, FlxColor.WHITE, "center", FlxText.BORDER_OUTLINE, FlxColor.BLACK);
		//_txt_title.setFormat(null, 18, FlxColor.WHITE, "left", FlxText.BORDER_OUTLINE, FlxColor.BLACK);
		
		_txt_title.borderQuality = 1;
		_txt_title.borderSize = 2;
		
		return _txt_title;
	}
	
	
	// Para el control del mouse en la carta
	
	private function onMouseDown(sprite:FlxSprite) {}
	private function onMouseUp(sprite:FlxSprite) {}
	
	private function onMouseOver(sprite:FlxSprite)
	{
		_txt_title.text = 'CASARTE CON LA MUJER DE TU VIDA';
		color = FlxColor.BLACK;
		//scale.x = 1.1;
		//scale.y = 1.1;
	}
	
	private function onMouseOut(sprite:FlxSprite)
	{
		color = FlxColor.WHITE;
	}

}