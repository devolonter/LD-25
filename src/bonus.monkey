Strict

Import flixel

Class Bonus Extends FlxSprite

	Global ClassObject:Object
	
	Field lifeTime:Float
	
	Method New()
		Super.New(0, 0)
		MakeGraphic(32, 32, FlxG.BLUE)
	End Method
	
	Method Update:Void()
		lifeTime -= FlxG.Elapsed
		If (lifeTime < 2 And Not Flickering) Flicker(2)
		If (lifeTime <= 0) Kill()
	End Method

End Class