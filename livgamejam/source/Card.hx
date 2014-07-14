package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

import haxe.Timer;

import flixel.plugin.MouseEventManager;

import Event;

/**
 * Esta clase maneja las tarjetas de forma individual
 * @author 
 */
class Card extends FlxTypedGroup<FlxSprite>
{
	// Tarjeta
	private var _isAvailable:Bool = false;
	
	private var _template:FlxSprite;
	private var _cardWidth:Int;
	private var _cardHeight:Int;
	
	private var _choseCard:Bool = false;
	private var _positionGallery:Int = 0; // posicion como carta (1 izq, 2 cent, 3 der ; 4 5 6 = las 3 superiores izq , ...)
	
	public static var _CARD_WIDTH:Int = 180;
	public static var _CARD_HEIGHT:Int = 270;
	
	// Banderas para cartas especiales
	private var _IS_DEAD_CARD:Bool = false;
	private var _IS_PASS_TURN:Bool = false;
	private var _IS_MINI:Bool = false;
	
	private var _IS_GOLDEN:Bool = false; // con cierta probabilidad
	private var _IS_GOLDEN_PROBABILITY:Float = 0.02; // con cierta probabilidad
	private var _EXP_GOLDEN_MULTIPLIER:Float = 10;
	
	public static var _ICON_DEATH_NAME:String = "rip.png";
	
	private var _template_current_path:String;
	private var _TEMPLATE_PATH:String = "assets/images/template_basic.png";
	private var _TEMPLATE_PATH_GOLDEN:String = "assets/images/template_golden.png";
	private var _TEMPLATE_PATH_RISK:String = "assets/images/template_risk.png";
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
	
	private var _txt_title_text:String = "";
	
	private var _txt_title:FlxText;
	private var _txt_stats:FlxText;
	
	private static var _STR_EXPERIENCE = ' exp';
	private static var _STR_DURATION = ' meses';
	
	// A partir de la clase Event, obtenemos toda la informacion de la BD
	
	private var _cardEventInfo:Event;
	
	public function new(cardEventInfo:Event, posCard:FlxPoint, newPosGallery:Int = 0,  IS_MINI:Bool = false, deathFromRisk:Bool = false) 
	{
		super();
		
		// Variables respecto a las cartas mostradas en la interfaz
		
		_cardEventInfo = cardEventInfo;
		
		_positionGallery = newPosGallery;
		_experience = _cardEventInfo.experiencia;
		_duration = _cardEventInfo.duracion;
		
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
		
		if (deathFromRisk) {
			_template_current_path = _TEMPLATE_PATH_RISK;
			_IS_DEAD_CARD = true;
			
			// Reemplazo el nombre por el riesgo concretado del suceso
			_txt_title_text = MenuState.riskCollection[_cardEventInfo.id_riesgo].content["nombre"];
		}
		
		// Si no es mini ni dead card, probamos a ver si es golden
		if (!_IS_MINI && !_IS_DEAD_CARD && Math.random() < _IS_GOLDEN_PROBABILITY) {
			_template_current_path = _TEMPLATE_PATH_GOLDEN;
			
			// Multiplica la experiencia (y los atributos que contribuye tambien, pero en handler)
			_experience *= Math.round(_EXP_GOLDEN_MULTIPLIER);
			
			_IS_GOLDEN = true;
		}
		
		_template = new FlxSprite(posCard.x, posCard.y);
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
			
			// No hay stats si te moris
			if (!_IS_DEAD_CARD) {
				add(_txt_stats);	
			}
		}
		
		// No voy a scrollear ninguna carta
		this.forEachAlive(setFixedCamera);
		
	}
	
	private function setFixedCamera(sprite:FlxSprite):Void
	{
		sprite.scrollFactor.set(0, 0);
	}
	
	// Coloca el icono central
	
	public function setIcon()
	{
		_icono = new FlxSprite();

		_ICON_NAME = _cardEventInfo.id_evento.toLowerCase() + ".png";
		
		if (_IS_DEAD_CARD) {
			_ICON_NAME = _ICON_DEATH_NAME;
			_icono.color = 0x00CCCCCC;
		}
		
		
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
		
		_txt_title.setFormat(PathTo._STR_FONT, 36, FlxColor.WHITE, "center", FlxText.BORDER_OUTLINE, FlxColor.BLACK);
		
		_txt_title.borderQuality = 1;
		_txt_title.borderSize = 2;
	}
	
	public function setTextStats()
	{
		_txt_stats = new FlxText(15 + _template.x, 180 + _template.y, 150, getStringWithMonthsAndExp(), 20, true);
		
		_txt_stats.setFormat(PathTo._STR_FONT, 30, 0xd41b1b, "left");
		
		var idxStartMonth = 1 + _txt_stats.text.indexOf(_STR_DURATION);
		var idxStartExperience = 1 + _txt_stats.text.indexOf(_STR_EXPERIENCE);
		
		_txt_stats.addFormat(new FlxTextFormat(PathTo._COLOR_DURATION, false, false, null, 1, idxStartMonth));
		_txt_stats.addFormat(new FlxTextFormat(PathTo._COLOR_DURATION_DARK, false, false, null, idxStartMonth, idxStartMonth + _STR_DURATION.length));
		_txt_stats.addFormat(new FlxTextFormat(PathTo._COLOR_EXPERIENCE, false, false, null, idxStartMonth + _STR_DURATION.length, idxStartExperience));
		_txt_stats.addFormat(new FlxTextFormat(PathTo._COLOR_EXPERIENCE_DARK, false, false, null, idxStartExperience, _txt_stats.text.length));
	}
	
	public function setPassTurn(_passTurn:Bool):Void
	{
		_IS_PASS_TURN = _passTurn;
	}
	
	public function choseCard():Void
	{
		_choseCard = true;
	}

	// Para el control del mouse en la carta
	
	private function onMouseDown(sprite:FlxSprite)
	{
		if ((!_IS_MINI && _isAvailable) || (_IS_PASS_TURN && _IS_MINI)) {
			_choseCard = true;
			
			// Hacemos ruidito de carta
			if (_IS_DEAD_CARD) {
				MenuState.playSound('deathCard');
			} else {
				if (_IS_GOLDEN) {
					MenuState.playSound('goldenCard');
				} else {
					MenuState.playSound('card');
				}
			}			
		}
	}
	
	private function onMouseUp(sprite:FlxSprite) {}
	
	private function onMouseOver(sprite:FlxSprite)
	{
		if (!_IS_MINI) {
			if (this.exists) {
				MenuState.playSound('menuhover');
			}
			
			_txt_title.text = (_txt_title_text != "") ? _txt_title_text : _cardEventInfo.nombre;
			_txt_stats.text = ' ';
			
			if (!_IS_DEAD_CARD) { // ya es negra, no necesita ser mas negra
				_template.color = FlxColor.BLACK;
			}
		} else {
			if (_IS_PASS_TURN) {
				_template.color = FlxColor.RED;	
			} else {
				_template.color = FlxColor.GOLDEN;	
			}
		}
	}
	
	private function onMouseOut(sprite:FlxSprite)
	{
		if (!_IS_MINI) {
			_txt_title.text = ' ';
			_txt_stats.text = getStringWithMonthsAndExp();
		}
		
		_template.color = FlxColor.WHITE;
	}

	// Efecto de luces
	
	public function cardTransform():FlxSprite
	{
		var transformedCard = new FlxSprite(_template.x, _template.y);
		transformedCard.loadGraphic("assets/images/cardTransform.png", true, 180, 270);
		transformedCard.animation.add("magic", [0, 1, 2, 3, 4, 5, 6, 7], 30, false);
		transformedCard.animation.add("sphere", [7, 8, 9], 9, true);
		
		transformedCard.animation.play("magic");
		
		// Borramos lo que quede
		this.clear();

		return transformedCard;
	}
	
	public function setAvailability(available:Bool = true):Void
	{
		_isAvailable = available;
	}
	
	/// FUNCIONES GET
	
	public function getStringWithMonthsAndExp():String
	{
		var monthAndExp:String = '';
		monthAndExp += '+' + _cardEventInfo.duracion + _STR_DURATION + '\n';
		monthAndExp += '+' + _experience + _STR_EXPERIENCE;
		
		return monthAndExp;
	}
	
	public function getPosition():FlxPoint
	{
		return new FlxPoint(_template.x, _template.y);
	}
	
	public function getChosedCard():Bool
	{
		var chose = _choseCard;
		_choseCard = false;
		return chose;
	}
	
	public function getPositionGallery():Int
	{
		return _positionGallery;
	}
	
	public function getIdEvent():String
	{
		return _cardEventInfo.id_evento;
	}
	
	public function getDeadStatus():Bool
	{
		return _IS_DEAD_CARD;
	}
	
	public function getGoldenStatus():Bool
	{
		return _IS_GOLDEN;
	}
	
	public function getGoldenMultiplier():Float
	{
		var retorno:Float = 1;
		
		if (_IS_GOLDEN) {
			retorno = 1 + _EXP_GOLDEN_MULTIPLIER / 10.0;
		}
		
		return retorno;
	}
	
	// Siempre le damos el camino del icono grande
	public function getPathIcon():String
	{
		return _ICON_PATH + _ICON_NAME;
	}
	
	/// DESTROY
	
	override public function destroy()
	{
		// Make sure that this object is removed from the MouseEventManager for GC
		MouseEventManager.remove(_template);
		
		this.clear();
		
		super.destroy();
	}
	
}