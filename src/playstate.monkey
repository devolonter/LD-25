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
	
	Const PROFESSORS_BASE_TIME:Float = 3
	
	Const PROFESSORS_BASE_AMOUNT:Float = 5
	
	Const PROFESSORS_MAX_AMOUNT:Float = 10
	
	Const PROFESSORS_BASE_VELOCITY_Y:Float = 20
	
	Const PROFESSORS_VELOCITY_X:Float = 70
	
	Const PROFESSORS_MAX_VELOCITY_Y:Float = 100
	
	Const PROFFESORS_ONE_LIMIT_FACTOR:Float = 0.25
	
	Const PROFFESORS_TWO_LIMIT_FACTOR:Float = 0.5
	
	Const BRICKS_START_FACTOR:Float = 0.25
	
	Const BRICKS_BASE_TIME:Float = 10
	
	Const BRICKS_GREEN_ZONE:Float = 0.25
	
	Const BONUSES_BASE_TIME:Float = 20
	
	Const BONUSES_BASE_LIFETIME:Float = 10
'End consts
		
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
	
	Method Create:Void()
		Add(New FlxSprite(0, 0, "bg"))
		walls = Walls(Add(New Walls(HEIGHT)))
		
		poisonBar = New Bar(10, 10, "poisonbar", 5)
		poisonBar.Max = 1
		poisonBar.Value = 1
		lifeBar = New Bar(FlxG.Width - 10, 10, "lifebar", 5, Bar.RIGHT_TO_LEFT)
		
		barrels = Barrels(Add(New Barrels(HEIGHT, poisonBar)))
		poisons = New Poisons()
				
		bricks = Bricks(Add(New Bricks()))
		bonuses = Bonuses(Add(New Bonuses()))
		
		player = New Player(lifeBar, poisonBar, poisons)
		player.Reset( (FlxG.Width - player.width) * 0.5, HEIGHT - player.height)
		Add(player)
		
		Add(poisonBar)
		Add(lifeBar)
		
		Add(New FlxSprite(0, HEIGHT - 2, "floor"))
		professors = Professors(Add(New Professors()))
		Add(poisons)
		
		Add(New FlxSprite(95, HEIGHT - 2, "stairs"))
		Add(New FlxSprite(238, HEIGHT - 2, "stairs"))
		Add(New FlxSprite(381, HEIGHT - 2, "stairs"))
		
		professorsTimer = New FlxTimer()
		FlxTimer.Manager().Add(professorsTimer)
		
		bricksTimer = New FlxTimer()
		FlxTimer.Manager().Add(bricksTimer)
		
		bonusesTimer = New FlxTimer()
		FlxTimer.Manager().Add(bonusesTimer)
		
		complexityFactor = 0
		GenerateProfessor()
		GenerateBonus()
	End Method
	
	Method Update:Void()
		If ( Not player.alive) Then
			Error "Game Over!"
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
	
	Method GenerateProfessor:Void()
		Local count:Int = FlxG.Random() * 2 + 1
		count = Min(count, 3)
		
		If (complexityFactor < PROFFESORS_ONE_LIMIT_FACTOR) Then
			count = 1
		ElseIf(complexityFactor < PROFFESORS_TWO_LIMIT_FACTOR And count > 1) Then
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
		
		professorsTimer.Start(PROFESSORS_BASE_TIME * (1 - complexityFactor), 1, Self)
	End Method
	
	Method GenerateBrick:Void()
		Local brick:Brick = Brick(bricks.Recycle(ClassInfo(Brick.ClassObject)))
		Local x:Float = player.x + FlxG.Width * BRICKS_GREEN_ZONE * (1 - complexityFactor) * Floor(FlxG.Random() * 2 - 1)
		x = Min(Max(x, 0.0), FlxG.Width - brick.width)
		
		brick.Reset(x, -brick.height)
		brick.acceleration.y = GRAVITY
		
		bricksTimer.Start(BRICKS_BASE_TIME * (1 - complexityFactor), 1, Self)
	End Method
	
	Method GenerateBonus:Void()
		If ( Not bonusesTimer.finished) Then
			bonusesTimer.Start(BONUSES_BASE_TIME * (1 + complexityFactor), 1, Self)
			Return
		End If
	
		Local bonus:Bonus = Bonus(bonuses.Recycle(ClassInfo(Bonus.ClassObject)))
		bonus.Reset(FlxG.Random() * (FlxG.Width - bonus.width - 20) + 10, -bonus.height)
		bonus.acceleration.y = GRAVITY
		bonus.lifeTime = BONUSES_BASE_LIFETIME * (1 - complexityFactor)
		bonus.Flicker(0)
		
		bonusesTimer.Start(BONUSES_BASE_TIME * (1 + complexityFactor) * (1 + FlxG.Random() * complexityFactor), 1, Self)
	End Method
	
	Method OnTimerTick:Void(timer:FlxTimer)
		Select(timer)
			Case professorsTimer
				complexityFactor += COMPLEXITY_FACTOR_INC * (1 - complexityFactor)
				
				GenerateProfessor()
				
				If (complexityFactor > BRICKS_START_FACTOR And Not bricksTimer.TimeLeft) Then
					GenerateBrick()
				End If
			Case bricksTimer
				GenerateBrick()
				
			Case bonusesTimer				
				GenerateBonus()
		End Select
		
	End Method
	
End Class