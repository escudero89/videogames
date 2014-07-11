package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

import flixel.plugin.MouseEventManager;

/**
 * Esta clase maneja las tarjetas de forma individual
 * @author 
 */
class Card extends FlxTypedGroup<FlxSprite>
{
	// Tarjeta

	public var _template:FlxSprite;
	
	public static var _CARD_WIDTH:Int = 180;
	public static var _CARD_HEIGHT:Int = 270;
	
	// Mini tarjeta
	
	private var _miniCardGroup:FlxTypedGroup<FlxSprite>;
	
	public static var _MINICARD_WIDTH:Int = 60;
	public static var _MINICARD_HEIGHT:Int = 60;
	
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
	
	private var _STR_TITLE = 'CASARTE CON LA MUJER DE TU VIDA';
	
	private static var _STR_EXPERIENCE = ' meses';
	private static var _STR_DURATION = ' exp';
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super();
		
		_template = new FlxSprite(X, Y, "assets/images/template_basic.png");
		
		MouseEventManager.add(_template, onMouseDown, onMouseUp, onMouseOver, onMouseOut);
		
		_experience = 250;
		_duration = 12;
		
		setIcon();
		setText();
		setTextStats();
		
		// Combinamos todo
		add(_template);
		add(_icono);
		add(_txt_title);
		add(_txt_stats);
	}
	
	// Coloca el icono central
	
	public function setIcon()
	{
		_icono = new FlxSprite();
		_icono.loadGraphic(_ICON_PATH_NORMAL + _ICON_NAME);
		
		_icono.x = _template.x + Math.round(_template.width / 2) - Math.round(_icono.width / 2);
		_icono.y = _template.y + 22;
	}
	
	// Coloca el texto
	
	public function setText()
	{
		_txt_title = new FlxText(15 + _template.x, 15 + _template.y, 150, null, 20, true);
		
		_txt_title.setFormat(_STR_FONT, 36, FlxColor.WHITE, "center", FlxText.BORDER_OUTLINE, FlxColor.BLACK);
		
		_txt_title.borderQuality = 1;
		_txt_title.borderSize = 2;
	}
	
	public function setTextStats()
	{
		_txt_stats = new FlxText(15 + _template.x, 180 + _template.y, 150, '+12 meses\n+250 exp', 20, true);
		
		var txtLength = _txt_stats.text.length;
		
		_txt_stats.setFormat(_STR_FONT, 30, 0xd41b1b, "left");
		
		_txt_stats.addFormat(new FlxTextFormat(0xd41b1b, false, false, null, 1, 3));
		_txt_stats.addFormat(new FlxTextFormat(0x9e0b0b, false, false, null, 4, 9));
		_txt_stats.addFormat(new FlxTextFormat(0x278bd1, false, false, null, 10, txtLength - 4));
		_txt_stats.addFormat(new FlxTextFormat(0x114f7a, false, false, null, txtLength - 4, txtLength));
	}
	
	// Forma la minitarjeta	
		
	public function getMiniCard(position:FlxPoint):FlxTypedGroup<FlxSprite>
	{
		// Va a contener todo lo relacionado a la minicard
		// FlxGroup itself is nothing but a shortcut for FlxTypedGroup<FlxBasic>
		_miniCardGroup = new FlxTypedGroup<FlxSprite>();

		var posX:Int = Math.round(position.x);
		var posY:Int = Math.round(position.y);
		
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
		_txt_title.text = _STR_TITLE;
		_txt_stats.text = ' ';
		_template.color = FlxColor.BLACK;
	}
	
	private function onMouseOut(sprite:FlxSprite)
	{
		_txt_title.text = ' ';
		_txt_stats.text = '+12 meses\n+250 exp';
		_template.color = FlxColor.WHITE;
	}
	
	/// FUNCIONES GET
	
	public function getPosition():FlxPoint
	{
		return new FlxPoint(_template.x, _template.y);
	}

}