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
	
	public var rpi_atributes:Map<String, Int>;
	public var c_atributes:Map<String, Int>;

	public var riesgo_porciento:Int;
	public var id_riesgo:String;
	
	// Atributos extras (que no figuran en la BD)
	
	// Todos los pesos, por defecto, valen 1, al iniciar
	public var peso:Int = 1;
	private var _MAX_WEIGHT:Int = 2; // maximo peso posible
	
	// si el numero que sale esta en este rango, esta es el evento elegido
	public var rango_i:Int = 0; 
	public var rango_f:Int = 0; 

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
		
		riesgo_porciento = _riesgo_porciento;
		id_riesgo = _id_riesgo;

		
		rpi_atributes = new Map<String, Int>();
		
		rpi_atributes.set('amor', _rpi_amor);
		rpi_atributes.set('creatividad', _rpi_creatividad);
		rpi_atributes.set('depresion', _rpi_depresion);
		rpi_atributes.set('educacion', _rpi_educacion);
		rpi_atributes.set('fama', _rpi_fama);
		rpi_atributes.set('resistencia', _rpi_resistencia);
		rpi_atributes.set('trabajo', _rpi_trabajo);
		rpi_atributes.set('viaje', _rpi_viaje);
		
		c_atributes = new Map<String, Int>();
		
		c_atributes.set('amor', _c_amor);
		c_atributes.set('creatividad', _c_creatividad);
		c_atributes.set('depresion', _c_depresion);
		c_atributes.set('educacion', _c_educacion);
		c_atributes.set('fama', _c_fama);
		c_atributes.set('resistencia', _c_resistencia);
		c_atributes.set('trabajo', _c_trabajo);
		c_atributes.set('viaje', _c_viaje);
		
	}
	
	// Inicializa el peso, es 1 para los normales y 0 para los que tienen requerimientos
	public function setWeight(atributesPlayer:Map<String, Int> = null):Void
	{
		var requirementWeight = getRequirementTotalWeight(atributesPlayer);
			
		peso = Math.round(Math.max(0, peso - requirementWeight));
		peso = Math.round(Math.min(peso, _MAX_WEIGHT));
		
		// Estos son casos especiales (recluirse por ejemplo)
		if (id_evento.indexOf("X") != -1) {
			peso = -1;
		}
	}
	
	// Hace la diferencia con los requerimientos. Si el requerimiento es mayor qeu el atributo, retorna positivo
	private function getRequirementTotalWeight(atributesPlayer:Map<String, Int>):Int
	{
		var weightReturn = 0;
		var weightDifference:Int;
		
		for (key in rpi_atributes.keys()) {
			weightDifference = rpi_atributes[key];
			
			if (atributesPlayer != null && rpi_atributes[key] > 0) {
				weightDifference -= atributesPlayer[key];
			}
			
			weightReturn += weightDifference;
		}
	
		return weightReturn;
	}
	
}