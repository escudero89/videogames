package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

import flixel.plugin.MouseEventManager;

/**
 * ...
 * @author 
 */
class Card extends FlxSprite
{
	// Tarjeta
	
	
	// Mini tarjeta
	
	private var _miniCardGroup:FlxTypedGroup<FlxSprite>;
	
	private var _MINICARD_WIDTH:Int = 60;
	private var _MINICARD_HEIGHT:Int = 60;
	
	// Icono

	private var _icono:FlxSprite;

	private var _ICON_NAME:String = "icon_default.png";
	private var _ICON_PATH_NORMAL:String = "assets/images/icons_150/";
	private var _ICON_PATH_SMALL:String = "assets/images/icons_50/";
	
	// Atributos internos
	
	private var _experience:Int;
	private var _duration:Int;
	
	// Para las strings
	
	private static var _STR_FONT:String = "assets/fonts/LondrinaSolid-Regular.ttf";
	
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
		_icono.loadGraphic(_ICON_PATH_NORMAL + _ICON_NAME);
		
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
	
	// Forma la minitarjeta
	
	public function getMiniCard(posX:Int, posY:Int):FlxTypedGroup<FlxSprite>
	{
		// Va a contener todo lo relacionado a la minicard
		// FlxGroup itself is nothing but a shortcut for FlxTypedGroup<FlxBasic>
		_miniCardGroup = new FlxTypedGroup<FlxSprite>();
		
		var miniCard = new FlxSprite(posX, posY);
		var miniIcon = new FlxSprite(posX + 5, posY + 5);
		
		miniCard.loadGraphic("assets/images/template_minicard_basic.png", false, _MINICARD_WIDTH, _MINICARD_HEIGHT);
		
		miniIcon.loadGraphic(_ICON_PATH_SMALL + _ICON_NAME);
		
		// Ahora agregamos los graficos
		_miniCardGroup.add(miniCard);
		_miniCardGroup.add(miniIcon);
		
		return _miniCardGroup;
	}
	
	// Para el control del mouse en la carta
	
	private function onMouseDown(sprite:FlxSprite)
	{
		FlxG.cameras.flash(FlxColor.WHITE, 0.1);
	}
	
	private function onMouseUp(sprite:FlxSprite) {}
	
	private function onMouseOver(sprite:FlxSprite)
	{
		_txt_title.text = _str_titleLarge;
		_txt_stats.text = ' ';
		color = FlxColor.BLACK;
	}
	
	private function onMouseOut(sprite:FlxSprite)
	{
		_txt_title.text = ' ';
		_txt_stats.text = '+12 meses\n+250 exp';
		color = FlxColor.WHITE;
	}

}