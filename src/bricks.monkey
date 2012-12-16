Strict

Import flixel
Import player

Class Bricks Extends FlxGroup Implements FlxOverlapNotifyListener
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		If (Player(object2)) Then
			object1.Kill()
			object2.Hurt(1)
		Else
			object1.Kill()	
		End If
	End Method

End Class