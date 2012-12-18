Strict

Import flixel
Import player

Class Poisons Extends FlxGroup Implements FlxOverlapNotifyListener
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		object1.Kill()
		object2.Kill()
		FlxG.Play("kill")
	End Method

End Class