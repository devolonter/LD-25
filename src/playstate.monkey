Strict

Import flixel
Import player
Import walls
Import poison

Class PlayState Extends FlxState

	Const HEIGHT:Float = 300
	
	Field walls:Walls
	
	Field player:Player
	
	Field poison:Poison
	
	Method Create:Void()
		walls = Walls(Add(New Walls(HEIGHT)))
		poison = Poison(Add(New Poison(HEIGHT)))
		
		player = New Player()
		player.Reset( (FlxG.Width - player.width) * 0.5, HEIGHT - player.height)
		Add(player)
	End Method
	
	Method Update:Void()
		Super.Update()
		
		FlxG.Collide(walls, player)
		FlxG.Overlap(poison, player, poison)
	End Method
	

End Class