Strict

Import flixel
Import player

Class Professors Extends FlxGroup Implements FlxOverlapNotifyListener
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		If (object2.Flickering) Return
		object2.Hurt(1)
	End Method

End Class