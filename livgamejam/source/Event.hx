package ;

/**
 * ...
 * @author 
 */
class Event
{
	
	// Atributos levantados desde la BD
	
	public var id_evento:String;
	public var nombre:String;
	public var descripcion:String;
	public var experiencia:Int;
	public var duracion:Int;
	public var rpi_amor:Int;
	public var rpi_creatividad:Int;
	public var rpi_depresion:Int;
	public var rpi_educacion:Int;
	public var rpi_fama:Int;
	public var rpi_resistencia:Int;
	public var rpi_trabajo:Int;
	public var rpi_viaje:Int;
	public var riesgo_porciento:Int;
	public var id_riesgo:String;
	public var c_amor:Int;
	public var c_creatividad:Int;
	public var c_depresion:Int;
	public var c_educacion:Int;
	public var c_fama:Int;
	public var c_resistencia:Int;
	public var c_trabajo:Int;
	public var c_viaje:Int;
	
	// Atributos extras (que no figuran en la BD)
	
	// Todos los pesos, por defecto, valen 1, al iniciar
	public var peso:Int = 1;

	public function new(
		_id_evento:String,
		_nombre:String,
		_descripcion:String,
		_experiencia:Int,
		_duracion:Int,
		_rpi_amor:Int,
		_rpi_creatividad:Int,
		_rpi_depresion:Int,
		_rpi_educacion:Int,
		_rpi_fama:Int,
		_rpi_resistencia:Int,
		_rpi_trabajo:Int,
		_rpi_viaje:Int,
		_riesgo_porciento:Int,
		_id_riesgo:String,
		_c_amor:Int,
		_c_creatividad:Int,
		_c_depresion:Int,
		_c_educacion:Int,
		_c_fama:Int,
		_c_resistencia:Int,
		_c_trabajo:Int,
		_c_viaje:Int) 
	{
		id_evento = _id_evento;
		nombre = _nombre;
		descripcion = _descripcion;
		experiencia = _experiencia;
		duracion = _duracion;
		rpi_amor = _rpi_amor;
		rpi_creatividad = _rpi_creatividad;
		rpi_depresion = _rpi_depresion;
		rpi_educacion = _rpi_educacion;
		rpi_fama = _rpi_fama;
		rpi_resistencia = _rpi_resistencia;
		rpi_trabajo = _rpi_trabajo;
		rpi_viaje = _rpi_viaje;
		riesgo_porciento = _riesgo_porciento;
		id_riesgo = _id_riesgo;
		c_amor = _c_amor;
		c_creatividad = _c_creatividad;
		c_depresion = _c_depresion;
		c_educacion = _c_educacion;
		c_fama = _c_fama;
		c_resistencia = _c_resistencia;
		c_trabajo = _c_trabajo;
		c_viaje = _c_viaje;
	}
	
}