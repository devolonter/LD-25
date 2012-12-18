Strict

Import flixel
Import bar
Import poison
Import playstate
Import bonus

Class Player Extends FlxSprite

	Field lifeBar:Bar
	
	Field poisonBar:Bar
	
	Field poisons:FlxGroup
	
	Field professors:FlxGroup
	
	Field poison:Poison
	
	Method New(lifeBar:Bar, poisonBar:Bar, poisons:FlxGroup, professors:FlxGroup)
		Super.New(0, 0)
		
		LoadGraphic("player", True, True, 35, 70)
		AddAnimation("run",[1, 2, 3, 4, 5, 6], 12)
		
		maxVelocity.x = PlayState.PLAYER_MAX_VELOCITY
		drag.x = maxVelocity.x * 10
		acceleration.y = PlayState.GRAVITY
		
		Self.lifeBar = lifeBar
		Self.poisonBar = poisonBar
		Self.poisons = poisons
		Self.professors = professors
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
				velocity.y -= acceleration.y * 0.55
				FlxG.Play("jump")
				
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
					
					FlxG.Play("shoot")
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
			Flicker(PlayState.PLAYER_FLICKER_TIME)
		End If
	End Method
	
	Method ActivateBonus:Void(bonus:FlxObject)
		Select(Bonus(bonus).Type)
			Case Bonus.BOMB
				professors.Kill()
				professors.Revive()
				FlxG.Play("kill")
			
			Case Bonus.EARTHQUAKE				
				PlayState.Shaking = PlayState.BONUS_EARTHQUAKE_DURATION
				FlxG.Shake(0.005, PlayState.BONUS_EARTHQUAKE_DURATION)
		
			Case Bonus.INVICIBILITY
				Flicker(PlayState.BONUS_INVICIBILITY_DURATION)
				
			Case Bonus.BOTTLE
				poisonBar.AddItem()
				
			Case Bonus.LIFE
				lifeBar.Value += 1
				
			Case Bonus.SPEED_DOWN
				If (PlayState.SpeedUp > 0) Return
				PlayState.SpeedDown = PlayState.BONUS_SPEED_UP_DOWN_DURATION
				
			Case Bonus.SPEED_UP
				If (PlayState.SpeedDown > 0) Return
				PlayState.SpeedUp = PlayState.BONUS_SPEED_UP_DOWN_DURATION
		End Select
	End Method


End Class