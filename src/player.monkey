Strict

Import flixel
Import bar

Class Player Extends FlxSprite

	Field jumpPower:Float
	
	Field lifeBar:Bar
	
	Field poisonBar:Bar
	
	Method New(lifeBar:Bar, poisonBar:Bar)
		Super.New(0, 0)
		
		LoadGraphic("player", True, True, 55, 50)
		AddAnimation("run",[0, 1, 2, 3, 4, 5], 15)
		
		maxVelocity.x = 150
		drag.x = maxVelocity.x * 10
		acceleration.y = FlxG.Height
		jumpPower = acceleration.y * 0.5
		
		Self.lifeBar = lifeBar
		Self.poisonBar = poisonBar
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
		
		If (velocity.y = 0) Then
			If (FlxG.Keys.JustPressed(KEY_UP))
				velocity.y -= jumpPower
			End If
		End If
		
		If (velocity.x = 0 Or velocity.y <> 0) Then
			Frame = 0
		Else
			Play("run")
		End If
	End Method

End Class