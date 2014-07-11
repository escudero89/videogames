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

	private var _template:FlxSprite;
	private var _cardWidth:Int;
	private var _cardHeight:Int;
	
	public static var _CARD_WIDTH:Int = 180;
	public static var _CARD_HEIGHT:Int = 270;
	
	private var _IS_MINI:Bool;
	
	private var _template_current_path:String;
	private var _TEMPLATE_PATH:String = "assets/images/template_basic.png";
	private var _TEMPLATE_MINI_PATH:String = "assets/images/template_mini_basic.png";
	
	// Mini tarjeta
	
	public static var _CARD_MINI_WIDTH:Int = 60;
	public static var _CARD_MINI_HEIGHT:Int = 60;
	
	// Icono

	private var _icono:FlxSprite;

	private var _icon_current_path:String;
	private var _ICON_NAME:String = "icon_default.png";	
	private var _ICON_PATH:String = "assets/images/icons_150/";
	private var _ICON_MINI_PATH:String = "assets/images/icons_50/";
	
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
	
	public function new(posCard:FlxPoint, IS_MINI = false) 
	{
		super();
		
		var X:Float = posCard.x;
		var Y:Float = posCard.y;
		
		_experience = 250;
		_duration = 12;
		
		_IS_MINI = IS_MINI;
		
		// Empezamos a asignar variables
		_template_current_path = _TEMPLATE_PATH;
		_icon_current_path = _ICON_PATH;
		_cardWidth = _CARD_WIDTH;
		_cardHeight = _CARD_HEIGHT;
		
		if (_IS_MINI) {
			_template_current_path = _TEMPLATE_MINI_PATH;
			_icon_current_path = _ICON_MINI_PATH;
			_cardWidth = _CARD_MINI_WIDTH;
			_cardHeight = _CARD_MINI_HEIGHT;
		}
		
		_template = new FlxSprite(X, Y);
		_template.loadGraphic( _template_current_path, false, _cardWidth, _cardHeight);
		
		MouseEventManager.add(_template, onMouseDown, onMouseUp, onMouseOver, onMouseOut);
		
		// Diferente tamanho de icono segun el tipo		
		setIcon();
		
		// Combinamos el template con el icono
		add(_template);
		add(_icono);

		// Si no es la version chica
		if (!IS_MINI) {
			setText();
			setTextStats();
			add(_txt_title);
			add(_txt_stats);
		}
		
	}
	
	// Coloca el icono central
	
	public function setIcon()
	{
		_icono = new FlxSprite();
		_icono.loadGraphic(_icon_current_path + _ICON_NAME);
		
		if (!_IS_MINI) {
			_icono.x = _template.x + Math.round(_template.width / 2) - Math.round(_icono.width / 2);
			_icono.y = _template.y + 22;			
		} else {
			_icono.x = _template.x + 5;
			_icono.y = _template.y + 5;
		}

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

	// Para el control del mouse en la carta
	
	private function onMouseDown(sprite:FlxSprite)
	{
		if (!_IS_MINI) {
			FlxG.cameras.flash(FlxColor.WHITE, 0.1);
		}
	}
	
	private function onMouseUp(sprite:FlxSprite) {}
	
	private function onMouseOver(sprite:FlxSprite)
	{
		if (!_IS_MINI) {
			_txt_title.text = _STR_TITLE;
			_txt_stats.text = ' ';			
			_template.color = FlxColor.BLACK;
		} else {
			_template.color = FlxColor.GOLDEN;
		}
	}
	
	private function onMouseOut(sprite:FlxSprite)
	{
		if (!_IS_MINI) {
			_txt_title.text = ' ';
			_txt_stats.text = '+12 meses\n+250 exp';
		}
		
		_template.color = FlxColor.WHITE;
	}
	
	/// FUNCIONES GET
	
	public function getPosition():FlxPoint
	{
		return new FlxPoint(_template.x, _template.y);
	}

}