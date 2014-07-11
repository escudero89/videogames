package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import Event;

//import Interface;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	
	public static var eventCollection:Map<String, Event>;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		populateEvents();
		
		FlxG.switchState(new PlayState());
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
	
	// Creara todos los eventos de forma hardcodeada
	private function populateEvents():Void
	{
		eventCollection = new Map<String, Event>();

		eventCollection.set('E1', new Event('E1','Recluirse','La soledad a la larga no hace bien.',220,12,0,0,0,0,0,0,0,0,0,'R1',0,0,5,0,0,0,0,0));
		eventCollection.set('E2', new Event('E2','Pasar al otro mundo','La muerte le llega a todos.',0,0,0,0,0,0,0,0,0,0,0,'R1',0,0,0,0,0,0,0,0));
		eventCollection.set('E3', new Event('E3','Hacerse notar','Entre tantas máscaras sociales.',70,12,0,0,0,0,0,0,0,0,0,'R1',0,0,0,0,5,0,0,0));
		eventCollection.set('E4', new Event('E4','Dedicarse a las artes','Fomentar tu expresion artistica',70,12,0,0,0,0,0,0,0,0,0,'R1',0,5,0,0,0,0,0,0));
		eventCollection.set('E5', new Event('E5','Pasear','La vida es más preciosa vista desde otros lados.',70,12,0,0,0,0,0,0,0,0,0,'R1',0,0,0,0,0,0,0,5));
		eventCollection.set('E6', new Event('E6','Tener un amor frugal','¿Cuántos poemas van ya?',70,12,0,0,0,0,0,0,0,0,0,'R1',5,0,0,0,0,0,0,0));
		eventCollection.set('E7', new Event('E7','Hacer deporte','¿A quién no le gusta un cuerpo atlético?',70,12,0,0,0,0,0,0,0,0,0,'R1',0,0,0,0,0,5,0,0));
		eventCollection.set('E8', new Event('E8','Trabajar','Alguien tiene que poner el pan en la mesa.',70,12,0,0,0,0,0,0,0,0,0,'R1',0,0,0,0,0,0,5,0));
		eventCollection.set('E9', new Event('E9','Dedicarse a los estudios','Para ser un cádaver culto.',70,12,0,0,0,0,0,0,0,0,0,'R2',0,0,0,5,0,0,0,0));
		eventCollection.set('E10', new Event('E10','Ir en una gira artistica','Luego no te termines mareando.',220,12,0,30,0,0,0,0,0,0,1,'R3',0,10,0,0,10,0,0,0));
		eventCollection.set('E11', new Event('E11','Viajar en barco','¿Quién no disfruta de un lindo viaje en barco?',120,12,0,0,0,0,0,0,0,30,3,'R4',0,0,-5,5,0,0,0,15));
		eventCollection.set('E12', new Event('E12','Avanzar un paso en la relación amorosa','No vayas a terminar pisándola.',270,12,30,0,0,0,0,0,0,0,1,'R5',15,0,0,0,0,0,0,0));
		eventCollection.set('E13', new Event('E13','Entrenar para atleta','No es fácil tener pie de atleta.',170,12,0,0,0,0,0,30,0,0,1,'R6',0,0,0,0,5,20,0,0));
		eventCollection.set('E14', new Event('E14','Obtener un mejor trabajo','Ahora te encargas del café además.',120,12,0,0,0,0,0,0,30,0,3,'R6',0,0,-5,5,0,0,15,0));
		eventCollection.set('E15', new Event('E15','Realizar una carrera de grado','Hay cierto grado de necesidad en hacerla.',360,36,0,0,0,30,0,0,0,0,3,'R6',0,0,0,30,0,0,0,0));
		eventCollection.set('E16', new Event('E16','Publicar un libro','Aunque lo lea sólo tu mamá.',270,12,0,0,0,50,0,0,0,0,1,'R7',0,5,0,15,5,0,5,5));
		eventCollection.set('E17', new Event('E17','Romper con tu pareja','Al parecer no le gustó descubrir tus fantasías.',970,12,50,0,0,0,0,0,0,0,3,'R7',-5,0,20,0,0,0,5,5));
		eventCollection.set('E18', new Event('E18','Renunciar al trabajo','Y mandar al jefe a volar.',870,12,0,0,0,0,0,0,30,0,1,'R8',0,0,20,0,0,10,-15,0));
		eventCollection.set('E19', new Event('E19','Compartir la vida con tu otra mitad','No es necesario aclarar que es figurativo.',370,12,60,0,0,0,0,0,30,0,1,'R9',30,5,-10,5,0,0,0,5));
		eventCollection.set('E20', new Event('E20','Producir una película','El género de la película se mantiene secreto.',820,12,0,50,0,0,50,0,0,0,3,'R10',0,10,0,0,10,0,5,5));
		eventCollection.set('E21', new Event('E21','Viajar por el mundo','Puede que tardes un poco más de 80 días.',220,12,0,0,0,0,0,0,0,50,3,'R11',0,5,-5,5,0,0,0,20));
		eventCollection.set('E22', new Event('E22','Ir a por un premio artistico','Y salir segundo por creativo.',780,3,0,70,0,0,50,0,0,0,1,'R11',0,15,0,0,15,0,15,0));
		eventCollection.set('E23', new Event('E23','Ir a por un premio Nóbel','Y arrebatarlo cuando nadie está mirando.',880,3,0,0,0,70,40,0,0,0,1,'R12',0,0,0,0,10,0,15,0));
		eventCollection.set('E24', new Event('E24','Fundar una empresa','No confundir con "fundir" una empresa.',920,12,0,0,0,40,0,0,70,0,3,'R6',0,0,0,0,5,0,20,5));
		eventCollection.set('E25', new Event('E25','Agrandar la familia','Una boca más que alimentar.',740,24,70,0,0,0,0,0,40,0,1,'R5',30,0,-10,0,5,5,0,0));
		eventCollection.set('E26', new Event('E26','Ser parte del equipo deportivo nacional','Alguien tiene que ser el aguatero nacional.',810,6,0,0,0,0,40,70,0,0,3,'R6',5,0,0,0,5,15,5,5));
		eventCollection.set('E27', new Event('E27','Rock and Roll, baby','Fiebre de sábado por la noche todos los días.',1570,12,0,40,0,0,70,0,0,0,5,'R13',0,20,20,0,0,-10,-10,5));
		eventCollection.set('E28', new Event('E28','Viajar por el trabajo','El puesto de choripán no se atiende solo.',1520,12,0,0,0,0,0,0,70,40,3,'R14',0,0,20,0,0,0,10,0));
		eventCollection.set('E29', new Event('E29','Realizar experimentos peligrosos','¿Peligrosos para quién?',1670,12,0,0,0,80,0,0,60,0,5,'R6',0,0,20,10,0,0,10,5));
		eventCollection.set('E30', new Event('E30','Vivir para el deporte','O morir por él.',1420,12,0,0,0,0,70,80,15,0,3,'R1',0,5,20,5,15,35,5,10));
	}
	
}