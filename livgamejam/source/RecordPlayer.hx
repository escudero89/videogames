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
	
	public function update(_event:Event):Void
	{
		_eventsIDs.push(_event.id_evento);
		_monthsOldPlayer += _event.duracion;
		_experiencePlayer += _event.experiencia;
		var atribute:Int;
		for (key in _atributes.keys()) {
			atribute = _atributes.get(key);
			atribute += _event.c_atributes.get(key);
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