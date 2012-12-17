Strict

Import flixel
Import playstate
Import poison

Class Professor Extends FlxSprite

	Global ClassObject:Object
	
	Field ladder:Int
	
	Method New()
		Super.New(0, 0)
		LoadGraphic("professor", True, True, 40, 80)
		ladder = 0
		
		AddAnimation("crawl",[0, 1, 2, 3], 8)
		AddAnimation("walk",[4, 5, 6, 7, 8, 9, 10, 11], 8)
	End Method
	
	Method Reset:Void(x:Float, y:Float)
		Super.Reset(x, y)
		Play("crawl")
	End Method
	
	Method Update:Void()
		If (velocity.y < 0) Then
			If (y < PlayState.HEIGHT) Then
				velocity.y = 0
				y = PlayState.HEIGHT - height
				
				If (FlxG.Random() < 0.5) Then
					velocity.x = -maxVelocity.x
					Facing = LEFT
				Else
					velocity.x = maxVelocity.x
				End If
				
				Play("walk")
			End If
		ElseIf(x < 0 Or x > FlxG.Width - width) Then
			velocity.x = -velocity.x
			If (velocity.x < 0) Then
				Facing = LEFT
			Else
				Facing = RIGHT
			End If
		End If
	End Method
	
	Method PostUpdate:Void()
		Super.PostUpdate()
		If (velocity.y = 0) Return
		
		If (PlayState.SpeedDown > 0) Then
			y = last.y - (last.y - y) * 0.5
		ElseIf(PlayState.SpeedUp > 0) Then
			y = last.y - (last.y - y) * 2
		End If
	End Method

End Class