Strict

Import flixel
Import playstate

Class Brick Extends FlxSprite

	Global ClassObject:Object
	
	Method New()
		Super.New(0, 0)
		MakeGraphic(30, 15)
		
		acceleration.y = PlayState.GRAVITY
	End Method

End Class