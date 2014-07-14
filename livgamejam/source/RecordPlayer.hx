package ;

/**
 * ...
 * @author ...
 */
class RecordPlayer
{
	public var _eventsIDs:Array<String>;
	public var _monthsOldPlayer:Int;// en meses
	public var _experiencePlayer:Int;
	public var _atributes:Map<String, Int>;
	
	public function new() 
	{
		_eventsIDs = new Array<String>();
		_monthsOldPlayer = 13*12;//13 años * 12 meses = 156 meses
		_experiencePlayer = 0;
		_atributes = new Map<String,Int>();
		_atributes.set("amor", 0);
		_atributes.set("creatividad", 0);
		_atributes.set("depresion", 0);
		_atributes.set("educacion", 0);
		_atributes.set("fama", 0);
		_atributes.set("resistencia", 0);
		_atributes.set("trabajo", 0);
		_atributes.set("viaje", 0);
	}
	
	public function update(_eventId:String, goldenMultiplier:Float):Void
	{
		_eventsIDs.push(_eventId);
		_monthsOldPlayer += MenuState.eventCollection[_eventId].duracion;
		_experiencePlayer += MenuState.eventCollection[_eventId].experiencia * ((goldenMultiplier > 1) ? Math.round((goldenMultiplier - 1) * 10) : 1);
		
		var atribute:Int;
		
		for (key in _atributes.keys()) {
			atribute = _atributes.get(key);
			atribute += Math.round(MenuState.eventCollection[_eventId].c_atributes.get(key) * goldenMultiplier);
			_atributes.set(key, atribute);
		}
	}
	
	public function getEventsIds():Array<String>
	{
		return _eventsIDs;
	}
	
	public function getAgeInYears():Int
	{
		return Math.floor(_monthsOldPlayer / 12);
	}
	
}