Strict

Import flixel

Class Brick Extends FlxSprite

	Global ClassObject:Object
	
	Method New()
		Super.New(0, 0, "brick")
	End Method
	
	Method Kill:Void()
		Super.Kill()
		FlxG.Play("brick")
	End Method

End Class