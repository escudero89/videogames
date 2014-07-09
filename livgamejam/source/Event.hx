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
	private var _txt_stats:FlxText;
	
	private var _str_titleShort = 'CASARTE';
	private var _str_titleLarge = 'CASARTE CON LA MUJER DE TU VIDA';
	private var _str_experience = ' meses';
	private var _str_duration = ' exp';
	
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
		_icono.y = this.y + 22;
		
		return _icono;
	}
	
	// Coloca el texto
	
	public function setText():FlxText
	{
		_txt_title = new FlxText(15 + this.x, 15 + this.y, 150, null, 20, true);
		
		_txt_title.setFormat(_STR_FONT, 36, FlxColor.WHITE, "center", FlxText.BORDER_OUTLINE, FlxColor.BLACK);
		
		_txt_title.borderQuality = 1;
		_txt_title.borderSize = 2;
		
		return _txt_title;
	}
	
	public function setTextStats():FlxText
	{
		_txt_stats = new FlxText(15 + this.x, 180 + this.y, 150, '+12 meses\n+250 exp', 20, true);
		
		var txtLength = _txt_stats.text.length;
		
		_txt_stats.setFormat(_STR_FONT, 30, 0xd41b1b, "left");
		
		_txt_stats.addFormat(new FlxTextFormat(0xd41b1b, false, false, null, 1, 3));
		_txt_stats.addFormat(new FlxTextFormat(0x9e0b0b, false, false, null, 4, 9));
		_txt_stats.addFormat(new FlxTextFormat(0x278bd1, false, false, null, 10, txtLength - 4));
		_txt_stats.addFormat(new FlxTextFormat(0x114f7a, false, false, null, txtLength - 4, txtLength));
		
		return _txt_stats;
	}
	
	// Para el control del mouse en la carta
	
	private function onMouseDown(sprite:FlxSprite) {}
	private function onMouseUp(sprite:FlxSprite) {}
	
	private function onMouseOver(sprite:FlxSprite)
	{
		_txt_title.text = _str_titleLarge;
		_txt_stats.text = ' ';
		color = FlxColor.BLACK;
		//scale.x = 1.1;
		//scale.y = 1.1;
	}
	
	private function onMouseOut(sprite:FlxSprite)
	{
		_txt_title.text = ' ';
		_txt_stats.text = '+12 meses\n+250 exp';
		color = FlxColor.WHITE;
	}

}