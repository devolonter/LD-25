Strict

Import flixel

Class Bonuses Extends FlxGroup Implements FlxOverlapNotifyListener
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		object1.Kill()
	End Method

End Class