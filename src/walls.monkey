Strict

Import flixel

Class Walls Extends FlxGroup

	Method New(floor:Float)
		Super.New(3)
		
		Local w:FlxObject = New FlxObject(-25, 0, 25, FlxG.Height)
		w.immovable = True
		w.allowCollisions = FlxObject.RIGHT
		Add(w)
		
		w = New FlxObject(FlxG.Width, 0, 25, FlxG.Height)
		w.immovable = True
		w.allowCollisions = FlxObject.LEFT
		Add(w)
		
		w = New FlxObject(0, floor, FlxG.Width, 25)
		w.immovable = True
		w.allowCollisions = FlxObject.UP
		Add(w)
	End Method

End Class