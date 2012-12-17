Strict

Import flixel
Import player
Import walls
Import barrels
Import bar
Import poison
Import professor
Import professors
Import brick
Import poisons
Import bricks
Import bonuses
Import bonus

Class PlayState Extends FlxState Implements FlxTimerListener

'Consts for game ballance
	Const HEIGHT:Float = 300
	
	Const GRAVITY:Float = 550
	
	Const COMPLEXITY_FACTOR_INC:Float = 0.01
	
	Const PLAYER_MAX_VELOCITY:Float = 150
	
	Const PLAYER_FLICKER_TIME:Float = 5
	
	Const PLAYER_MAX_POISONS_AMOUNT:Int = 3
	
	Const PROFESSORS_BASE_TIME:Float = 4
	
	Const PROFESSORS_MIN_TIME:Float = 2.5
	
	Const PROFESSORS_TIME_ZONE:Float = 2
	
	Const PROFESSORS_BASE_AMOUNT:Float = 5
	
	Const PROFESSORS_MAX_AMOUNT:Float = 10
	
	Const PROFESSORS_BASE_VELOCITY_Y:Float = 20
	
	Const PROFESSORS_VELOCITY_X:Float = 70
	
	Const PROFESSORS_MAX_VELOCITY_Y:Float = 100
	
	Const PROFESORS_ONE_LIMIT_FACTOR:Float = 0.25
	
	Const PROFESORS_TWO_LIMIT_FACTOR:Float = 0.5
	
	Const BRICKS_START_FACTOR:Float = 0.25
	
	Const BRICKS_BASE_TIME:Float = 10
	
	Const BRICKS_MIN_TIME:Float = 2
	
	Const BRICKS_TIME_ZONE:Float = 2
	
	Const BRICKS_CREATION_ZONE:Float = 0.3
	
	Const BONUSES_BASE_TIME:Float = 15
	
	Const BONUSES_BASE_LIFETIME:Float = 10
	
	Const BONUSES_BAD_FACTOR:Float = 0.1
	
	Const BONUS_INVICIBILITY_DURATION:Float = 10
	
	Const BONUS_EARTHQUAKE_DURATION:Float = 10
	
	Const BONUS_SPEED_UP_DOWN_DURATION:Float = 10
	
'Chances scale
	Const BONUS_BOMB_CHANCE:Int = 15
	
	Const BONUS_EARTHQUAKE_CHANCE:Int = 30
	
	Const BONUS_INVICIBILITY_CHANCE:Int = 40
	
	Const BONUS_BOTTLE_CHANCE:Int = 60
	
	Const BONUS_LIFE_CHANCE:Int = 70
	
	Const BONUS_SPEED_DOWN_CHANCE:Int = 80
	
	Const BONUS_SPEED_UP_CHANCE:Int = 100
'End consts

	Global Shaking:Float = 0
	
	Global SpeedUp:Float = 0
	
	Global SpeedDown:Float = 0
		
	Field walls:Walls
	
	Field player:Player
	
	Field lifeBar:Bar
	
	Field poisons:Poisons
	
	Field professors:Professors
	
	Field professorsTimer:FlxTimer
	
	Field bricks:Bricks
	
	Field bricksTimer:FlxTimer
	
	Field bonuses:Bonuses
	
	Field bonusesTimer:FlxTimer
	
	Field barrels:Barrels
	
	Field poisonBar:Bar
	
	Field complexityFactor:FLoat
	
	Field ladders:Int[3]
	
	Field lastBonusType:Int
	
	Method Create:Void()
		Add(New FlxSprite(0, 0, "bg"))
		walls = Walls(Add(New Walls(HEIGHT)))
		
		poisonBar = New Bar(10, 10, "poisonbar", 5)
		poisonBar.Max = 1
		poisonBar.Value = 1
		lifeBar = New Bar(FlxG.Width - 10, 10, "lifebar", 5, Bar.RIGHT_TO_LEFT)
		
		barrels = Barrels(Add(New Barrels(HEIGHT + 2, poisonBar)))
		poisons = New Poisons()
		
		professors = New Professors()
				
		bricks = Bricks(Add(New Bricks()))
		bonuses = Bonuses(Add(New Bonuses()))
		
		player = New Player(lifeBar, poisonBar, poisons, professors)
		player.Reset( (FlxG.Width - player.width) * 0.5, HEIGHT - player.height)
		Add(player)
		
		Add(poisonBar)
		Add(lifeBar)
		
		Add(New FlxSprite(0, HEIGHT, "floor"))
		Add(professors)
		Add(poisons)
		
		professorsTimer = New FlxTimer()
		FlxTimer.Manager().Add(professorsTimer)
		
		bricksTimer = New FlxTimer()
		FlxTimer.Manager().Add(bricksTimer)
		
		bonusesTimer = New FlxTimer()
		FlxTimer.Manager().Add(bonusesTimer)
		
		complexityFactor = 0
		GenerateProfessor(True)
		GenerateBonus()
	End Method
	
	Method Update:Void()
		If ( Not player.alive) Then
			Error "Game Over!"
		End If
		
		If (Shaking > 0) Then
			Shaking -= FlxG.Elapsed
			If (Shaking <= 0) FlxG.Camera.StopFX()
		End If
		
		If (SpeedUp > 0) Then
			SpeedUp -= FlxG.Elapsed
		End If
		
		If (SpeedDown > 0) Then
			SpeedDown -= FlxG.Elapsed
		End If
	
		FlxG.Overlap(barrels, player, barrels)
		FlxG.Overlap(bonuses, player, bonuses)
		
		If ( Not player.Flickering) Then
			FlxG.Overlap(professors, player, professors)
			FlxG.Overlap(bricks, player, bricks)
		End If
	
		Super.Update()
		
		FlxG.Collide(player, walls)
		FlxG.Collide(bonuses, walls)
		FlxG.Collide(bricks, walls, bricks)
		FlxG.Collide(poisons, professors, poisons)
	End Method
	
	Method GenerateProfessor:Void(first:Bool = False)
		Local count:Int = FlxG.Random() * 2 + 1
		count = Min(count, 3)
		
		If (complexityFactor < PROFESORS_ONE_LIMIT_FACTOR) Then
			count = 1
		ElseIf(complexityFactor < PROFESORS_TWO_LIMIT_FACTOR And count > 1) Then
			count = 2
		End If
		
		For Local c:Int = 0 Until count
			If (professors.CountLiving() < Int(PROFESSORS_BASE_AMOUNT + (PROFESSORS_MAX_AMOUNT - PROFESSORS_BASE_AMOUNT) * complexityFactor)) Then
				Local ladder:Int
				Local professor:Professor
				
				ladders[0] = 0; ladders[1] = 0; ladders[2] = 0
				
				For Local i:Int = 0 Until professors.Length
					professor = Professor(professors.Members[i])
				
					If (professor.alive And professor.velocity.x = 0) Then
						ladders[professor.ladder] += 1
					End If
				Next
				
				If (ladders[0] < ladders[1] And ladders[0] < ladders[2]) Then
					ladder = 0
				ElseIf(ladders[1] < ladders[0] And ladders[1] < ladders[2]) Then
					ladder = 1
				ElseIf(ladders[2] < ladders[0] And ladders[2] < ladders[1]) Then
					ladder = 2
				Else
					ladder = Min(Int(FlxG.Random() * 3), 2)
				End If
				
				professor = Professor(professors.Recycle(ClassInfo(Professor.ClassObject)))
				
				professor.ladder = ladder
				professor.Reset(77 + ladder * 143, FlxG.Height)
				professor.velocity.y = - (PROFESSORS_MAX_VELOCITY_Y - PROFESSORS_BASE_VELOCITY_Y) * complexityFactor * complexityFactor - PROFESSORS_BASE_VELOCITY_Y
				professor.maxVelocity.x = PROFESSORS_VELOCITY_X
			End If
		Next

		If ( Not first) Then
			professorsTimer.Start(PROFESSORS_BASE_TIME * (1 - complexityFactor) + (FlxG.Random() * PROFESSORS_TIME_ZONE - PROFESSORS_TIME_ZONE), 1, Self)
		Else
				professorsTimer.Start(PROFESSORS_BASE_TIME * 2, 1, Self)
		End If
		professorsTimer.time = Max(professorsTimer.time, PROFESSORS_MIN_TIME)
	End Method
	
	Method GenerateBrick:Void()
		Local brick:Brick = Brick(bricks.Recycle(ClassInfo(Brick.ClassObject)))
		Local x:Float = player.x + FlxG.Width * BRICKS_CREATION_ZONE * (1 - complexityFactor) * Floor(FlxG.Random() * 2 - 1)
		x = Min(Max(x, 0.0), FlxG.Width - brick.width)
		
		brick.Reset(x, -brick.height)
		brick.acceleration.y = GRAVITY
		
		If (Shaking > 0) Then
			bricksTimer.Start(BRICKS_BASE_TIME * 0.1 + (FlxG.Random() * BRICKS_TIME_ZONE - BRICKS_TIME_ZONE), 1, Self)
		Else
			bricksTimer.Start(BRICKS_BASE_TIME * (1 - complexityFactor) + (FlxG.Random() * BRICKS_TIME_ZONE - BRICKS_TIME_ZONE), 1, Self)
		End If
	
		bricksTimer.time = Max(bricksTimer.time, BRICKS_MIN_TIME)
	End Method
	
	Method GenerateBonus:Void()
		If ( Not bonusesTimer.finished) Then
			bonusesTimer.Start(BONUSES_BASE_TIME * (1 + complexityFactor), 1, Self)
			Return
		End If
	
		Local bonus:Bonus = Bonus(bonuses.Recycle(ClassInfo(Bonus.ClassObject)))
		bonus.Reset(FlxG.Random() * (FlxG.Width - bonus.width - 100) + 10, -bonus.height)
		bonus.acceleration.y = GRAVITY
		'bonus.Type = FlxG.Random() * Bonus.SPEED_UP
		bonus.lifeTime = BONUSES_BASE_LIFETIME * (1 - complexityFactor)
		bonus.Flicker(0)
		
		Local type:Int = FlxG.Random() * 100

		If (type <= BONUS_BOMB_CHANCE Or type = Bonus.BOMB) Then
			Local sumY:Float = 0
			Local minY:Float = 0
			Local professor:Professor
		
			For Local i:Int = 0 Until professors.Length
				professor = Professor(professors.Members[i])
			
				If (professor.alive And professor.velocity.x = 0) Then
					sumY += professor.y
					minY += HEIGHT
				End If
			Next
			
			minY = Max(minY, HEIGHT)
			Local chance:Float = (sumY / minY) * FlxG.Random()
			
			If (chance < 0.5) Then
				type = Bonus.BOMB
			Else
				type = Bonus.BOMB + FlxG.Random() * (Bonus.SPEED_UP - Bonus.BOMB)
			End If
		End If
		
		If (type > BONUS_BOMB_CHANCE And type <= BONUS_EARTHQUAKE_CHANCE) Then
			type = Bonus.EARTHQUAKE
		End If
		
		If (type > BONUS_EARTHQUAKE_CHANCE And type <= BONUS_INVICIBILITY_CHANCE) Then
			type = Bonus.INVICIBILITY
		End If

		If (type > BONUS_INVICIBILITY_CHANCE And type <= BONUS_BOTTLE_CHANCE) Then
			If (poisonBar.Max >= PLAYER_MAX_POISONS_AMOUNT) Then
				type = FlxG.Random() * Bonus.SPEED_UP
				
				If (type = Bonus.BOTTLE) Then
					If (FlxG.Random() > 0.5) Then
						type = Bonus.EARTHQUAKE
					Else
						type = Bonus.SPEED_UP
					End If
					
				End If
			Else
				type = Bonus.BOTTLE
			End If
		End If
		
		If (type > BONUS_BOTTLE_CHANCE And type <= BONUS_LIFE_CHANCE) Then
			Local chance:Float = (lifeBar.Value / lifeBar.Max)
			
			If (chance < 0.5) Then
				type = Bonus.LIFE
			Else
				type = Bonus.LIFE + FlxG.Random() * (Bonus.SPEED_UP - Bonus.LIFE)
			End If
		End If
		
		If (type > BONUS_LIFE_CHANCE And type <= BONUS_SPEED_DOWN_CHANCE) Then
			type = Bonus.SPEED_DOWN
		End If
		
		If (type > BONUS_SPEED_DOWN_CHANCE And type <= BONUS_SPEED_UP_CHANCE) Then
			type = Bonus.SPEED_UP
		End If
		
		If (complexityFactor < BONUSES_BAD_FACTOR) Then
			Local chance:Float = FlxG.Random()
			
			If (chance < 0.3) Then
				type = Bonus.BOTTLE
			ElseIf(chance < 0.7)
				type = Bonus.SPEED_DOWN
			End If
		End If
		
		bonus.Type = Min(type, Bonus.SPEED_UP)
		
		If (lastBonusType <> bonus.Type Or complexityFactor < BONUSES_BAD_FACTOR) Then
			bonusesTimer.Start(BONUSES_BASE_TIME * (1 - complexityFactor) * (1 + FlxG.Random() * complexityFactor), 1, Self)
			lastBonusType = bonus.Type
		Else
			bonus.Kill()
			GenerateBonus()
		End If
	End Method
	
	Method OnTimerTick:Void(timer:FlxTimer)
		Select(timer)
			Case professorsTimer
				complexityFactor += COMPLEXITY_FACTOR_INC * (1 - complexityFactor)
				
				GenerateProfessor()
				
				If (complexityFactor > BRICKS_START_FACTOR And Not bricksTimer.TimeLeft) Then
					GenerateBrick()
				ElseIf(Shaking > 0) Then
					GenerateBrick()
				End If
			Case bricksTimer
				GenerateBrick()
				
			Case bonusesTimer				
				GenerateBonus()
		End Select
		
	End Method
	
End Class