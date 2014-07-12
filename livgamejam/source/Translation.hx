package ;

/**
 * ...
 * @author 
 */
class Translation
{
	public var content:Map<String, String>;
	
	public function new(nombre:String, descripcion:String)
	{
		content = new Map<String, String> ();
		
		content.set("nombre", nombre);
		content.set("descripcion", descripcion);
	}
	
}