Strict

Import flixel
Import player
Import walls
Import barrels
Import bar

Class PlayState Extends FlxState

	Const HEIGHT:Float = 300
	
	Field walls:Walls
	
	Field player:Player
	
	Field lifeBar:Bar
	
	Field barrels:Barrels
	
	Field poisonBar:Bar
	
	Method Create:Void()
		walls = Walls(Add(New Walls(HEIGHT)))
		
		barrels = Barrels(Add(New Barrels(HEIGHT)))
		poisonBar = New Bar(10, 10, "poisonbar", 5)
		poisonBar.Max = 1
		poisonBar.Value = 1
		
		player = New Player()
		player.Reset( (FlxG.Width - player.width) * 0.5, HEIGHT - player.height)
		Add(player)
		
		lifeBar = New Bar(FlxG.Width - 90, 10, "lifebar", 5)
		
		Add(poisonBar)
		Add(lifeBar)
	End Method
	
	Method Update:Void()
		Super.Update()
		
		FlxG.Collide(walls, player)
		FlxG.Overlap(barrels, player, barrels)
	End Method
	

End Class