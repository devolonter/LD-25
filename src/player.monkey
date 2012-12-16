Strict

Import flixel
Import bar
Import poison

Class Player Extends FlxSprite

	Field lifeBar:Bar
	
	Field poisonBar:Bar
	
	Field poisons:FlxGroup
	
	Field poison:Poison
	
	Method New(lifeBar:Bar, poisonBar:Bar, poisons:FlxGroup)
		Super.New(0, 0)
		
		LoadGraphic("player", True, True, 55, 50)
		AddAnimation("run",[0, 1, 2, 3, 4, 5], 15)
		
		maxVelocity.x = 200
		drag.x = maxVelocity.x * 10
		acceleration.y = FlxG.Height * 0.7
		
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
				velocity.y -= acceleration.y * 0.6
				
			ElseIf(FlxG.Keys.JustPressed(KEY_Z) Or FlxG.Keys.JustPressed(KEY_X)) Then
				If (poisonBar.Value > 0) Then
					poison = Poison(poisons.Recycle(ClassInfo(Poison.ClassObject)))
					poisonBar.Value -= 1
					
					poison.acceleration.y = 0
					poison.velocity.x = 0
					
					If (Facing = LEFT) Then
						poison.Reset(x - 10, y + 10)
					Else
						poison.Reset(x + width + 10, y + 10)
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
		
		If (velocity.x = 0 Or velocity.y <> 0) Then
			Frame = 0
		Else
			Play("run")
		End If
	End Method
	
	Method Hurt:Void(damage:Float = 1)
		lifeBar.Value -= damage
		
		If (lifeBar.Value <= 0) Then
			Kill()
		Else
			Flicker(5)
		End If
	End Method


End Class