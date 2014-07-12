package ;

/**
 * ...
 * @author ...
 */
class RecordPlayer
{
	public var _eventsIDs:Array<String>;
	public var _age:Int;// en meses
	public var _experience:Int;
	public var _amor:Int;
	public var _creatividad:Int;
	public var _depresion:Int;
	public var _educacion:Int;
	public var _fama:Int;
	public var _resistencia:Int;
	public var _trabajo:Int;
	public var _viaje:Int;

	public function new() 
	{
		_eventsIDs = new Array<String>();
		_age = 13*12;//13 años * 12 meses = 156 meses
		_experience = 0;
		_amor = 0;
		_creatividad = 0;
		_depresion = 0;
		_educacion = 0;
		_fama = 0;
		_resistencia = 0;
		_trabajo = 0;
		_viaje = 0;
	}
	
	public function update(_event:Event):Void
	{
		_eventsIDs.push(_event.id_evento);
		_age += _event.duracion;
		_experience += _event.experiencia;
		_amor += _event.c_atributes.get("amor");
		_creatividad += _event.c_atributes.get("creatividad");
		_depresion += _event.c_atributes.get("depresion");
		_educacion += _event.c_atributes.get("educacion");
		_fama += _event.c_atributes.get("fama");
		_resistencia += _event.c_atributes.get("resistencia");
		_trabajo += _event.c_atributes.get("trabajo");
		_viaje += _event.c_atributes.get("viaje");
	}
	
	public function getEventsIds():Array<String>
	{
		return _eventsIDs;
	}
	
	public function getAgeInYears():Int
	{
		return Math.floor(_age / 12);
	}
	
}