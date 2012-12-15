Strict

Import flixel
Import playstate

Class Player Extends FlxSprite

	Field jumpPower:Float
	
	Method New(x:Float = 0, y:Float = 0)
		Super.New(x, y)
		
		LoadGraphic("player", True, True, 55, 50)
		AddAnimation("run",[0, 1, 2, 3, 4, 5], 15)
		
		maxVelocity.x = 150
		drag.x = maxVelocity.x * 10
		acceleration.y = FlxG.Height
		jumpPower = acceleration.y * .5
	End Method
	
	Method Update:Void()	
		acceleration.x = 0

		If (FlxG.Keys.Left) Then
			Facing = LEFT
			acceleration.x -= drag.x
		ElseIf(FlxG.Keys.Right) Then
			Facing = RIGHT
			acceleration.x += drag.x
		End If
		
		If (FlxG.Keys.JustPressed(KEY_UP) And velocity.y = 0) Then
			velocity.y -= jumpPower
		End If	
		
		If (velocity.x = 0) Then
			Frame = 0
		Else
			Play("run")
		End If
	End Method

End Class