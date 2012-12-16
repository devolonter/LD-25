Strict

Import flixel
Import player
Import walls
Import barrels
Import bar
Import poison
Import professor
Import professors

Class PlayState Extends FlxState Implements FlxTimerListener

	Const HEIGHT:Float = 300
		
	Field walls:Walls
	
	Field player:Player
	
	Field lifeBar:Bar
	
	Field poisons:FlxGroup
	
	Field professors:Professors
	
	Field timer:FlxTimer
	
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
		poisons = FlxGroup(Add(New FlxGroup()))
		
		professors = Professors(Add(New Professors()))
		
		player = New Player(lifeBar, poisonBar, poisons)
		player.Reset( (FlxG.Width - player.width) * 0.5, HEIGHT - player.height)
		Add(player)
		
		Add(poisonBar)
		Add(lifeBar)
		
		timer = New FlxTimer()
		FlxTimer.Manager().Add(timer)
		
		timer.Start(5, 0, Self)
	End Method
	
	Method Update:Void()
		FlxG.Overlap(barrels, player, barrels)
	
		Super.Update()
		
		FlxG.Collide(walls, player)
		FlxG.Collide(professors, poisons, professors)
	End Method
	
	Method OnTimerTick:Void(timer:FlxTimer)
		Local ladder:Int = Max(Min(Int(FlxG.Random() * 4), 3), 1)
		Local professor:Professor = Professor(professors.Recycle(ClassInfo(Professor.ClassObject)))
		
		professor.Reset(75 + (ladder - 1) * 145, FlxG.Height)
		professor.velocity.y = -professor.maxVelocity.y
	End Method
	
End Class