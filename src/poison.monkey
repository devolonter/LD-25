Strict

Import flixel
Import player

Class Poison Extends FlxGroup Implements FlxOverlapNotifyListener

	Field player:Player

	Method New(y:Float)
		Super.New(2)
	
		Local p:FlxSprite = New FlxSprite(0, 0, "poison")
		p.Reset(0, y - p.height)
		Add(p)
		
		p = New FlxSprite(0, 0, "poison")
		p.Reset(FlxG.Width - p.width, y - p.height)
		Add(p)
	End Method
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		If (player = Null) Then
			player = Player(object2)
		End If
		
		
	End Method

End Class