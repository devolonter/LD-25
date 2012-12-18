Strict

Import flixel
Import player
Import playstate

Class Poisons Extends FlxGroup Implements FlxOverlapNotifyListener
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		object1.Kill()
		object2.Kill()
		FlxG.Play("kill")
		
		FlxG.Score += 1
		PlayState.Score.Text =FlxG.Score
	End Method

End Class