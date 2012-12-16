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
	
	Const COMPLEXITY_FACTOR_INC:Float = 0.02
	
	Const PROFESSORS_BASE_TIME:Float = 5
	
	Const PROFESSORS_BASE_AMOUNT:Float = 3
	
	Const PROFESSORS_MAX_AMOUNT:Float = 15
	
	Const PROFESSORS_BASE_VELOCITY_Y:Float = 30
	
	Const PROFESSORS_BASE_VELOCITY_X:Float = 100
	
	Const PROFESSORS_MAX_VELOCITY_X:Float = 200
	
	Const PROFESSORS_MAX_VELOCITY_Y:Float = 150
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
		
		barrels = Barrels(Add(New Barrels(HEIGHT, poisonBar)))
		
		lifeBar = New Bar(FlxG.Width - 90, 10, "lifebar", 5)
		poisons = Poisons(Add(New Poisons()))
		
		professors = Professors(Add(New Professors()))
		bricks = Bricks(Add(New Bricks()))
		bonuses = Bonuses(Add(New Bonuses()))
		
		player = New Player(lifeBar, poisonBar, poisons)
		player.Reset( (FlxG.Width - player.width) * 0.5, HEIGHT - player.height)
		Add(player)
		
		Add(poisonBar)
		Add(lifeBar)
		
		professorsTimer = New FlxTimer()
		FlxTimer.Manager().Add(professorsTimer)
		
		bricksTimer = New FlxTimer()
		FlxTimer.Manager().Add(bricksTimer)
		
		bonusesTimer = New FlxTimer()
		FlxTimer.Manager().Add(bonusesTimer)
		
		complexityFactor = 0
		
		'bricksTimer.Start(2, 0, Self)
		'bonusesTimer.Start(3, 0, Self)
		
		AddProfessor()
	End Method
	
	Method Update:Void()
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
		
		If ( Not player.alive) Then
			Error "Game Over!"
		End If
	End Method
	
	Method AddProfessor:Void()
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
			professor.velocity.y = - (PROFESSORS_MAX_VELOCITY_Y - PROFESSORS_BASE_VELOCITY_Y) * complexityFactor - PROFESSORS_BASE_VELOCITY_Y
			professor.maxVelocity.x = (PROFESSORS_MAX_VELOCITY_X - PROFESSORS_BASE_VELOCITY_X) * complexityFactor + PROFESSORS_BASE_VELOCITY_X
		End If
		
		professorsTimer.Start(PROFESSORS_BASE_TIME * (1 - complexityFactor), 1, Self)
	End Method
	
	Method OnTimerTick:Void(timer:FlxTimer)
		Select(timer)
			Case professorsTimer
				complexityFactor += COMPLEXITY_FACTOR_INC * (1 - complexityFactor)
				AddProfessor()
								
			Case bricksTimer
				Local brick:Brick = Brick(bricks.Recycle(ClassInfo(Brick.ClassObject)))				
				brick.Reset(FlxG.Random() * (FlxG.Width - brick.width - 20) + 10, -brick.height)
				brick.acceleration.y = GRAVITY
				
			Case bonusesTimer				
				Local bonus:Bonus = Bonus(bonuses.Recycle(ClassInfo(Bonus.ClassObject)))
				bonus.Reset(FlxG.Random() * (FlxG.Width - bonus.width - 20) + 10, -bonus.height)
				bonus.acceleration.y = GRAVITY
		End Select
		
	End Method
	
End Class