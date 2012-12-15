Strict

Import flixel

Class Barrel Extends FlxSprite

	Field collided:Bool
	
	Field empty:Bool
	
	Method New()
		Super.New(0, 0, "barrel")
		collided = False
	End Method
	
	Method Update:Void()
		If ( Not empty) Return
		
		If ( Not collided) Then
			empty = False
		End If
		
		collided = False
	End Method
	
End Class