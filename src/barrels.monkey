Strict

Import flixel
Import player
Import bar

Class Barrels Extends FlxGroup Implements FlxOverlapNotifyListener

	Field player:Player
	
	Field poisonbar:Bar

	Method New(y:Float, poisonBar:Bar)
		Super.New(2)
	
		Local p:FlxSprite = New FlxSprite(0, 0, "barrel")
		p.Reset(0, y - p.height)
		Add(p)
		
		p = New FlxSprite(0, 0, "barrel")
		p.Reset(FlxG.Width - p.width, y - p.height)
		Add(p)
		
		Self.poisonbar = poisonBar
	End Method
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		poisonbar.Value = poisonbar.Max
	End Method

End Class