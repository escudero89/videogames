/*package ;

import Std;

/**
 * ...
 * Esta clase carga desde la base de datos, todos los eventos y los agrupa en un Array<Event>
 * @author ...
 *//*
class DataBase
{
	// Array de eventos
	private var _eventCollection:Array<Event>;
	
	// Embeber el archivo con los textos
	// Si hubiese mas de un idioma, aca se verificaria el que esta activo y se
	// seleccionaria un archivo de idioma acorde
	[Embed (source = "assets/data/lang_es.csv", mimeType = "application/octet-stream")]
	private var langText:Class;
	
	// Embeber el archivo con los datos
	[Embed (source = "assets/data/dataBase.csv", mimeType = "application/octet-stream")]
	private var dataTxt:Class;
	
	public function new() 
	{
		
		// Archivo de lenguaje
		
		// Transformar el contenido en un string
		var langString:String = new langTxt();
		
		// Separar cada linea del string y guardarlas en un array
		var langStringArray:Array = langString.split("\n");
		
		// Poner los textos en dos archivos map, para acceder a ellos mas facilmente
		// names<ID, nombre> / descriptions<ID, descripción>
		var names:Map<String,String> = new Map<String,String>();
		var descriptions:Map<String,String> = new Map<String,String>();
		
		// Recorrer el array de strings, guardando todos los textos en los maps
		while (langStringArray.length < > 0) {
			var textString:String = langStringArray.pop();
			if (textString.charAt(0) < > "#") {
				var textStringArray:Array = eventString.split(",");
				names.set(textStringArray[0], textStringArray[1]);
				descriptions.set(textStringArray[0], textStringArray[2]);
			}
		}
		
		// Archivo de datos
		
		// Transformar el contenido en un string
		var dataString:String = new dataTxt();
		
		// Separar cada linea del string, datos del evento, y guardarlas en un array
		var dataStringArray:Array = dataString.split("\n");
		
		// Recorrer el array de strings, guardando todos los datos en el array de eventos
		while (dataStringArray.length < > 0) {
			var eventString:String = dataStringArray.pop();
			if (eventString.charAt(0) < > "#") {
				var eventStringArray:Array = eventString.split(",");
				var id_evento:String = eventStringArray[0];
				var nombre:String = names.get(eventStringArray[0]);
				var descripcion:String = descriptions.get(eventStringArray[0]);
				var experiencia:Int = parseInt(eventStringArray[1]);
				var duracion:Int = parseInt(eventStringArray[2]);
				var rpi_amor:Int = parseInt(eventStringArray[3]);
				var rpi_creatividad:Int = parseInt(eventStringArray[4]);
				var rpi_depresion:Int = parseInt(eventStringArray[5]);
				var rpi_educacion:Int = parseInt(eventStringArray[6]);
				var rpi_fama:Int = parseInt(eventStringArray[7]);
				var rpi_resistencia:Int = parseInt(eventStringArray[8]);
				var rpi_trabajo:Int = parseInt(eventStringArray[9]);
				var rpi_viaje:Int = parseInt(eventStringArray[10]);
				var riesgo_porciento:Int = parseInt(eventStringArray[11]);
				var id_riesgo:String = eventStringArray[12];
				var c_amor:Int = parseInt(eventStringArray[13]);
				var c_creatividad:Int = parseInt(eventStringArray[14]);
				var c_depresion:Int = parseInt(eventStringArray[15]);
				var c_educacion:Int = parseInt(eventStringArray[16]);
				var c_fama:Int = parseInt(eventStringArray[17]);
				var c_resistencia:Int = parseInt(eventStringArray[18]);
				var c_trabajo:Int = parseInt(eventStringArray[19]);
				var c_viaje:Int = parseInt(eventStringArray[20]);
				_eventCollection.push(new Event(id_evento, nombre, descripcion, experiencia, duracion, rpi_amor, rpi_creatividad, rpi_depresion, rpi_educacion, rpi_fama, rpi_resistencia, rpi_trabajo, rpi_viaje, riesgo_porciento, id_riesgo, c_amor, c_creatividad, c_depresion, c_educacion, c_fama, c_resistencia, c_trabajo, c_viaje);
			}
		}
		
	}
	
	public function getEventCollection():Array<Event>
	{
		return _eventCollection;
	}
	
}*/