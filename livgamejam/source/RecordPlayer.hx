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
		var amor:Int = _atributes.get("amor") + _event.c_atributes.get("amor");
		_atributes.set("amor", amor);
		var creatividad:Int = _atributes.get("creatividad") + _event.c_atributes.get("creatividad");
		_atributes.set("creatividad", creatividad);
		var depresion:Int = _atributes.get("depresion") + _event.c_atributes.get("depresion");
		_atributes.set("depresion", depresion);
		var educacion:Int = _atributes.get("educacion") + _event.c_atributes.get("educacion");
		_atributes.set("educacion", educacion);
		var fama:Int = _atributes.get("fama") + _event.c_atributes.get("fama");
		_atributes.set("fama", fama);
		var resistencia:Int = _atributes.get("resistencia") + _event.c_atributes.get("resistencia");
		_atributes.set("resistencia", resistencia);
		var trabajo:Int = _atributes.get("trabajo") + _event.c_atributes.get("trabajo");
		_atributes.set("trabajo", trabajo);
		var viaje:Int = _atributes.get("viaje") + _event.c_atributes.get("viaje");
		_atributes.set("viaje", viaje);
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