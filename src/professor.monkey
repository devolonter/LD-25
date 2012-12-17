Strict

Import flixel
Import playstate
Import poison

Class Professor Extends FlxSprite

	Global ClassObject:Object
	
	Field ladder:Int
	
	Method New()
		Super.New(0, 0, "professor")
		ladder = 0
	End Method
	
	Method Reset:Void(x:Float, y:Float)
		Super.Reset(x, y)
		
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
	
	Method PostUpdate:Void()
		Super.PostUpdate()
		
		If (PlayState.SpeedDown > 0) Then
			y = last.y - (last.y - y) * 0.5
		ElseIf(PlayState.SpeedUp > 0) Then
			y = last.y - (last.y - y) * 2
		End If
	End Method

End Class