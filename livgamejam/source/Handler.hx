package ;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.text.FlxText; // << puede borrarse si no se usa
import flixel.util.FlxPoint;

import Card;
import Event;
import Timmy;

/**
 * Esta clase se encarga de manejar las tarjetas a mostrar. Desde las 3 principales a las 9 secundarias
 * @author 
 */
class Handler extends FlxTypedGroup<FlxBasic>
{
	
	// Timmy
	private var _timmy:Timmy;
	
	// Bandera de fin de partida
	public var _end_of_game:Bool = false;
	
	// Coleccion de eventos
	private var _eventCollection:Map<String, Event>;
	private var _eventCollectionIdsAvailable:Array<String>; // guarda todos los eventos con peso > 0
	private var _eventCollectionTotalWeight:Int = 0;
	
	// Los atributos del protagonista iran aqui
	private var _atributes:Map<String, Int>;
	
	private var _experiencePlayer:Int = 0;
	private var _monthsOldPlayer:Int = 13 * 12;
	
	private var _experienceTitle:FlxText;
	private var _monthsOldTitle:FlxText;
	
	// Aqui estan las cartas mostradas
	private var _cardCurrentCollection:FlxTypedGroup<Card>;
	
	// Aqui se va a guardar toda la coleccion de cartas
	private var _cardCollection:FlxTypedGroup<Card>;
	
	// Posicion de todas las cartas (ver getInfrastructure)
	private var _posCardArray:Array<FlxPoint>;
	
	//////////////////////////////////////////////////////////////
	
	public function new(eventCollection:Map<String, Event> = null, timmy:Timmy = null)
	{
		super();
		
		_timmy = timmy;
		
		/// RELACIONADO AL EVENT COLLECTION
		
		_eventCollection = eventCollection;
		
		_eventCollectionIdsAvailable = new Array<String>();
		
		// Inicializamos los atributos disponibles
		_atributes = new Map<String, Int>();
		
		_atributes.set('amor', 0);
		_atributes.set('creatividad', 0);
		_atributes.set('depresion', 0);
		_atributes.set('educacion', 0);
		_atributes.set('fama', 0);
		_atributes.set('resistencia', 0);
		_atributes.set('trabajo', 0);
		_atributes.set('viaje', 0);
		
		// Actualizamos pesos
		updateEventsWeight();
		
		/// RELACIONADO A LA INTERFAZ
		
		_posCardArray = getInfrastructure();
		
		_cardCurrentCollection = new FlxTypedGroup<Card>();
		
		getNewHand();
		
		// @@@ BORRABLE
		_experienceTitle = new FlxText(50, 600, 500, "Experiencia: " + _experiencePlayer, 40);
		_monthsOldTitle = new FlxText(50, 700, 500, "Edad: " + Math.round(_monthsOldPlayer / 12), 40);
		add(_experienceTitle);
		add(_monthsOldTitle);
		
	}
	
	// Llamamos esta funcion cada frame
	
	override public function update():Void
	{
		super.update();		
		
		_cardCurrentCollection.forEachAlive(getCurrentCardsState);
	}
	
	// A partir de la carta elegida, actua en consecuencia (reparte nueva mano, ajusta atributos)
	
	public function getCurrentCardsState(card:Card):Void
	{
		if (card.getChosedCard()) {
			
			// Revisamos que no sea una carta de muerte
			if (card.getDeadStatus()) {
				_end_of_game = true;
			}
			
			// Obtengo los atributos de contribucion
			var atributesChoseCard = _eventCollection[card.getIdEvent()].c_atributes;
			
			for (keyAtribute in atributesChoseCard.keys()) {
				_atributes[keyAtribute] += atributesChoseCard[keyAtribute];
			}	

			// Actualizamos los valores de experiencia y meses de vida respectivamente
			_experiencePlayer += _eventCollection[card.getIdEvent()].experiencia;
			_monthsOldPlayer += _eventCollection[card.getIdEvent()].duracion;
			
			// Actualizamos los pesos
			updateEventsWeight();
			
			_timmy.newChoice(card.getPositionGallery(), card.getIdEvent());
			_timmy.setAge(_monthsOldPlayer);
			
			// Y destruimos la carta 
			card.destroy();
			
			// y pedimos una nueva mano (pero antes revisamos que este vivo)
			var isGoingToDie = isLastBreath(_eventCollection[card.getIdEvent()]);
			
			getNewHand(card.getPositionGallery(), card.getIdEvent(), isGoingToDie);
			
			// @@@ BORRABLE
			_experienceTitle = new FlxText(50, 600, 500, "Experiencia: " + _experiencePlayer, 40);
			_monthsOldTitle = new FlxText(50, 700, 500, "Edad: " + Math.round(_monthsOldPlayer / 12), 40);
			add(_experienceTitle);
			add(_monthsOldTitle);
		}
	}
	
	// Es la ultima carta? => Se va a morir? True si es asi, False sino
	private function isLastBreath(currentEvent:Event):Bool
	{
		var agePlayer:Float = Math.floor(_monthsOldPlayer / 12);
		var riskNaturalDeathPercent:Float = ( 0.00009 * agePlayer - 0.0045 ) * agePlayer + 0.065;
		var isGoingToDie = false;
		
		// Le sumamoso el riesgo por la actividad
		riskNaturalDeathPercent += currentEvent.riesgo_porciento / 100;
		
		// Porcentaje de riesgo por muerte natural (cambia cuadraticamente con la edad)
		if (Math.random() < (riskNaturalDeathPercent)) {
			isGoingToDie = true;
		}
		
		return isGoingToDie;
	}
	
	
	// Sumamos y recalcumos los pesos de todos los eventos
	private function updateEventsWeight() {
		
		// Lo vaciamos y limpiamos
		_eventCollectionIdsAvailable = new Array<String>();
		_eventCollectionTotalWeight = 0;
		
		for (keyEvent in _eventCollection.keys()) {
			_eventCollection[keyEvent].setWeight(_atributes);
			_eventCollectionTotalWeight += _eventCollection[keyEvent].peso;
			
			if (_eventCollection[keyEvent].peso > 0) {
				_eventCollectionIdsAvailable.push(keyEvent);
			}
		}
		
		// Y seteamos las probabilidades
		setEventProbabilities();
	}

	// Retorna una nueva mano de cartas (a partir de la eleccion sabe que 3 cartas primarias mostrar)
	// 1, 2, o 3 (cada una en una posicion
	private function getNewHand(chose:Int = 0, previousIdEvent:String = "", isGoingToDie:Bool = false):Void
	{
		var cardKeepFromChoice = new Array<String>();
		
		// Si tenemos cartas futuras, las colocamos adelante
		if (chose != 0) {
			for (card in _cardCurrentCollection) {
				// Basicamente, se juega con los indices para que seleccione las 3 cartas de arriba
				if	(Math.ceil(card.getPositionGallery() / 3) - 1 == chose) {
					cardKeepFromChoice.push(card.getIdEvent());
				}
			}
		}
		
		// Vaciamos las cartas actuales y las que estaban guardadas en el Handler
		_cardCurrentCollection.clear();
		this.clear();
		
		// Si vamos a morir no nos molestamos en elegir otras cartas
		if (isGoingToDie) {
			add(_cardCurrentCollection.add(new Card(_eventCollection[previousIdEvent], _posCardArray[4], 2, false, true))); 
		} else {
			getNewHandHelper(cardKeepFromChoice);
		}

	}
	
	private function getNewHandHelper(cardKeepFromChoice:Array<String>):Void
	{
		var chosenEvent:Event;
		var nextThreeFutureEvents:Array<String>;
		
		var nextThreeEvents:Array<String> = getNextThreeEvents();
				
		// Normalcards
		for (i in 0...3) {
			
			if (cardKeepFromChoice.length > 0) {
				chosenEvent = _eventCollection[cardKeepFromChoice[i]];
			} else {
				chosenEvent = _eventCollection[nextThreeEvents[i]];
			}
			
			add(_cardCurrentCollection.add(new Card(chosenEvent, _posCardArray[i + 3 * i], i + 1))); // 0 , 4, 8
			
			// Minicards
			nextThreeFutureEvents = getNextThreeEvents();
			for (j in 0...3) {
				chosenEvent = _eventCollection[nextThreeFutureEvents[j]];				
				add(_cardCurrentCollection.add(new Card(chosenEvent, _posCardArray[i + j + 1 + 3 * i], 3 * (i + 1) + j + 1, true))); // 1,2,3,5,6,7,...
			}
		}
	}
	
	// Calcula las tres proximas cartas a tocar desde el mismo estado de vida
	private function getNextThreeEvents():Array<String>
	{
		var amountCards = 3;
		var rangoNextEvent:Int;
		
		var keyEvent:String;
		var keyRetornada:Array<String> = new Array<String>();
		
		while (amountCards > 0) {
			
			// Arroja un numero entre 0 al peso total de la coleccion
			rangoNextEvent = Math.round(Math.random() * _eventCollectionTotalWeight);
			
			for (i in 0..._eventCollectionIdsAvailable.length) {
				keyEvent = _eventCollectionIdsAvailable[i];
				
				if (rangoNextEvent >= _eventCollection[keyEvent].rango_i  &&
					rangoNextEvent <= _eventCollection[keyEvent].rango_f) {
					
					keyRetornada.push(keyEvent);
					break;
				}
			}
			
			amountCards--;
		}
		
		return keyRetornada;
	}
	
	// Setea las probabilidades de todas las cartas
	private function setEventProbabilities():Void
	{
		var keyEvent:String;
		
		var rangoActual_i:Int = 0;
		var rangoActual_f:Int = 0;
		
		// Calculamos todas las probabilidades y las guardamos
		for (i in 0..._eventCollectionIdsAvailable.length) {
			keyEvent = _eventCollectionIdsAvailable[i];
			
			rangoActual_f += _eventCollection[keyEvent].peso;
			
			_eventCollection[keyEvent].rango_i = rangoActual_i;
			_eventCollection[keyEvent].rango_f = rangoActual_f;
			
			// Luego actualizamos el inicial
			rangoActual_i += _eventCollection[keyEvent].peso;
		}
	}
	
	
	// Obtiene la infraestructura (las posiciones de cada carta)
	// El formato es [ posCard1 , posMiniCard1, posMiniCard2, posMiniCard3, posCard2, ...] => array.length = 12
	private function getInfrastructure():Array<FlxPoint>
	{
		var infrastructure = new Array<FlxPoint>();
		
		var basePositionX = 31;
		var basePositionY = 128;
		
		var amountCards = 3;
		
		while (amountCards > 0) {
			
			infrastructure.push(new FlxPoint(basePositionX, basePositionY));
			
			// Por cada 3 cartas superiores
			for ( i in 0...3) {
				infrastructure.push(getInfraestructureHelper(new FlxPoint(basePositionX, basePositionY), i));
			}
			
			// Decrementamos la cantidad de cartas y movemos la posicion en x
			basePositionX += 200;
			amountCards--;
		
		}
		
		return infrastructure;
	}
	
	// Retorna los puntos para posicionar las 3 tarjetas superiores (type 1: left, 2: center: 3:right)
	private function getInfraestructureHelper(miniCardPos:FlxPoint, type:Int):FlxPoint
	{
		miniCardPos.y -= 64;
		miniCardPos.x += Math.round(Card._CARD_WIDTH / 2 - Card._CARD_MINI_WIDTH / 2);
		
		if (type == 0) { // LEFT MINICARD
			miniCardPos.x -= 64;
			
		} else if (type == 2) { // RIGHT MINICARD
			miniCardPos.x += 64;
		}
		
		return miniCardPos;
	}
	
}