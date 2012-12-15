Strict

Import flixel
Import player
Import walls

Class PlayState Extends FlxState

	Const HEIGHT:Float = 300
	
	Field walls:Walls
	
	Field player:Player
	
	Field toCollide:Player
	
	Method Create:Void()
		walls = Walls(Add(New Walls(HEIGHT)))
	
		player = New Player()
		player.Reset( (FlxG.Width - player.width) * 0.5, HEIGHT - player.height)
		Add(player)
	End Method
	
	Method Update:Void()
		Super.Update()
		
		FlxG.Collide(walls, player)
	End Method
	

End Class