Strict

Import flixel
Import playstate
Import poison

Class Professor Extends FlxSprite

	Global ClassObject:Object
	
	Method New()
		Super.New(0, 0, "professor")
		maxVelocity.x = 30
		maxVelocity.y = 30
	End Method
	
	Method Update:Void()
		If (velocity.y < 0) Then
			If (y + height < PlayState.HEIGHT) Then
				velocity.y = 0
				
				If (FlxG.Random() < 0.5) Then
					velocity.x = -maxVelocity.x
				Else
					velocity.x = maxVelocity.x
				End If
			End If
		ElseIf(x < 0 Or x > FlxG.Width - width) Then
			velocity.x = -velocity.x
		End If
	End Method

End Class