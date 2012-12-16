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

Class PlayState Extends FlxState Implements FlxTimerListener

	Const HEIGHT:Float = 300
	
	Const GRAVITY:Float = 550
		
	Field walls:Walls
	
	Field player:Player
	
	Field lifeBar:Bar
	
	Field poisons:Poisons
	
	Field professors:Professors
	
	Field professorsTimer:FlxTimer
	
	Field bricks:Bricks
	
	Field bricksTimer:FlxTimer
	
	Field barrels:Barrels
	
	Field poisonBar:Bar
	
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
		
		player = New Player(lifeBar, poisonBar, poisons)
		player.Reset( (FlxG.Width - player.width) * 0.5, HEIGHT - player.height)
		Add(player)
		
		Add(poisonBar)
		Add(lifeBar)
		
		professorsTimer = New FlxTimer()
		FlxTimer.Manager().Add(professorsTimer)
		
		bricksTimer = New FlxTimer()
		FlxTimer.Manager().Add(bricksTimer)
		
		professorsTimer.Start(5, 0, Self)
		bricksTimer.Start(2, 0, Self)
	End Method
	
	Method Update:Void()
		FlxG.Overlap(barrels, player, barrels)
		
		If ( Not player.Flickering) Then
			FlxG.Overlap(professors, player, professors)
			FlxG.Overlap(bricks, player, bricks)
		End If
	
		Super.Update()
		
		FlxG.Collide(player, walls)
		FlxG.Collide(bricks, walls, bricks)
		FlxG.Collide(poisons, professors, poisons)
		
		If ( Not player.alive) Then
			Error "Game Over!"
		End If
	End Method
	
	Method OnTimerTick:Void(timer:FlxTimer)
		Select(timer)
			Case professorsTimer
				Local ladder:Int = Max(Min(Int(FlxG.Random() * 4), 3), 1)
				Local professor:Professor = Professor(professors.Recycle(ClassInfo(Professor.ClassObject)))
				
				professor.Reset(75 + (ladder - 1) * 145, FlxG.Height)
				professor.velocity.y = -professor.maxVelocity.y
				
			Case bricksTimer
				Local brick:Brick = Brick(bricks.Recycle(ClassInfo(Brick.ClassObject)))				
				brick.Reset(FlxG.Random() * (FlxG.Width - brick.width - 20) + 10, -brick.height)
		End Select
		
	End Method
	
End Class