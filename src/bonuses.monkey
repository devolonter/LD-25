Strict

Import flixel
Import player

Class Bonuses Extends FlxGroup Implements FlxOverlapNotifyListener
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		Player(object2).ActivateBonus(object1)
		object1.Kill()
	End Method

End Class