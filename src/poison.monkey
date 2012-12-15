Strict

Import flixel

Class Poison Extends FlxSprite

	Global ClassObject:Object
	
	Method New()
		Super.New(0, 0, "poison")
	End Method
	
	Method Update:Void()
		If (x < - width Or x > FlxG.Width Or y > FlxG.Height) Kill()
	End Method

End Class