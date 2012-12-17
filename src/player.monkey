Strict

Import flixel
Import bar
Import poison
Import playstate

Class Player Extends FlxSprite

	Field lifeBar:Bar
	
	Field poisonBar:Bar
	
	Field poisons:FlxGroup
	
	Field poison:Poison
	
	Method New(lifeBar:Bar, poisonBar:Bar, poisons:FlxGroup)
		Super.New(0, 0)
		
		LoadGraphic("player", True, True, 40, 80)
		AddAnimation("run",[0, 1, 2, 3, 4, 5, 6, 7], PlayState.PLAYER_MAX_VELOCITY / 12)
		
		maxVelocity.x = PlayState.PLAYER_MAX_VELOCITY
		drag.x = maxVelocity.x * 10
		acceleration.y = PlayState.GRAVITY
		
		Self.lifeBar = lifeBar
		Self.poisonBar = poisonBar
		Self.poisons = poisons
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
				velocity.y -= acceleration.y * 0.5
				
			ElseIf(FlxG.Keys.JustPressed(KEY_Z) Or FlxG.Keys.JustPressed(KEY_X)) Then
				If (poisonBar.Value > 0) Then
					poison = Poison(poisons.Recycle(ClassInfo(Poison.ClassObject)))
					poisonBar.Value -= 1
					
					poison.acceleration.y = 0
					poison.velocity.x = 0
					
					If (Facing = LEFT) Then
						poison.Reset(x - poison.width + 7, y + height * 0.4)
					Else
						poison.Reset(x + width - 7, y + height * 0.4)
					End If
				
					If (FlxG.Keys.JustPressed(KEY_Z)) Then
						poison.acceleration.y = acceleration.y
					Else
						If (Facing = LEFT) Then
							poison.velocity.x = -maxVelocity.x * 2
						Else
							poison.velocity.x = maxVelocity.x * 2
						End If
					End If
				End If
			End If
		End If
		
		If (velocity.y <> 0) Then
			Frame = 7
		ElseIf(velocity.x = 0) Then
			Frame = 0
		Else
			Play("run")
		End If
	End Method
	
	Method Hurt:Void(damage:Float = 1)
		If (Flickering) Return
	
		lifeBar.Value -= damage
		
		If (lifeBar.Value <= 0) Then
			Kill()
		Else
			Flicker(5)
		End If
	End Method


End Class