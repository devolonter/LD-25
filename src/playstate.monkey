Strict

Import flixel
Import player
Import walls
Import barrels
Import bar
Import poison

Class PlayState Extends FlxState

	Const HEIGHT:Float = 300
		
	Field walls:Walls
	
	Field player:Player
	
	Field lifeBar:Bar
	
	Field poisons:FlxGroup
	
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
		
		player = New Player(lifeBar, poisonBar, poisons)
		player.Reset( (FlxG.Width - player.width) * 0.5, HEIGHT - player.height)
		Add(player)
		
		Add(poisonBar)
		Add(lifeBar)
	End Method
	
	Method Update:Void()
		FlxG.Overlap(barrels, player, barrels)
	
		Super.Update()
		
		FlxG.Collide(walls, player)
	End Method
	

End Class