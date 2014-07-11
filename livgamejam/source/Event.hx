package ;

/**
 * ...
 * @author 
 */
class Event
{
	public var id_evento:String;
	public var nombre:String;
	public var descripcion:String;
	public var experiencia:Int;
	public var duracion:Int;
	public var pi_amor:Int;
	public var pi_creatividad:Int;
	public var pi_depresion:Int;
	public var pi_educacion:Int;
	public var pi_fama:Int;
	public var pi_resistencia:Int;
	public var pi_trabajo:Int;
	public var pi_viaje:Int;
	public var riesgo_porciento:Int;
	public var id_riesgo:String;
	public var c_amor:Int;
	public var c_creatividad:Int;
	public var c_depresion:Int;
	public var c_educación:Int;
	public var c_fama:Int;
	public var c_resistencia:Int;
	public var c_trabajo:Int;
	public var c_viaje:Int;

	public function new(
		_id_evento:String
		_nombre:String
		_descripcion:String
		_experiencia:Int
		_duracion:Int
		_pi_amor:Int
		_pi_creatividad:Int
		_pi_depresion:Int
		_pi_educacion:Int
		_pi_fama:Int
		_pi_resistencia:Int
		_pi_trabajo:Int
		_pi_viaje:Int
		_riesgo_porciento:Int
		_id_riesgo:String
		_c_amor:Int
		_c_creatividad:Int
		_c_depresion:Int
		_c_educación:Int
		_c_fama:Int
		_c_resistencia:Int
		_c_trabajo:Int
		_c_viaje:Int) 
	{
		id_evento: = _id_evento;
		nombre = _nombre;
		descripcion = _descripcion;
		experiencia = _experiencia;
		duracion = _duracion;
		pi_amor = _pi_amor;
		pi_creatividad = _pi_creatividad;
		pi_depresion = _pi_depresion;
		pi_educacion = _pi_educacion;
		pi_fama = _pi_fama;
		pi_resistencia = _pi_resistencia;
		pi_trabajo = _pi_trabajo;
		pi_viaje = _pi_viaje;
		riesgo_porciento = _riesgo_porciento;
		id_riesgo = _id_riesgo;
		c_amor = _c_amor;
		c_creatividad = _c_creatividad;
		c_depresion = _c_depresion;
		c_educación = _c_educación;
		c_fama = _c_fama;
		c_resistencia = _c_resistencia;
		c_trabajo = _c_trabajo;
		c_viaje = _c_viaje;
	}
	
}