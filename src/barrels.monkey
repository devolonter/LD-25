Strict

Import flixel
Import player
Import bar

Class Barrels Extends FlxGroup Implements FlxOverlapNotifyListener

	Field player:Player
	
	Field poisonbar:Bar
	
	Field curIndex:Int

	Method New(y:Float, poisonBar:Bar)
		Super.New(2)
	
		Local p:FlxSprite = New FlxSprite(0, 0, "barrel")
		p.Reset(0, y - p.height)
		Add(p)
		
		p = New FlxSprite(0, 0, "barrel")
		p.Reset(FlxG.Width - p.width, y - p.height)
		Add(p)
		
		Self.poisonbar = poisonBar
		
		curIndex = -1
	End Method
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		poisonbar.Value = poisonbar.Max
		object1.Solid = False
		
		If (curIndex < 0) Then
			For Local i:Int = 0 Until Length
				If (object1 = Members[i]) Then
					curIndex = i
					Exit
				End If
			Next
		End If
		
		curIndex = Not curIndex
		FlxObject(Members[curIndex]).Solid = True
	End Method

End Class