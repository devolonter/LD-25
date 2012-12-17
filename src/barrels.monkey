Strict

Import flixel
Import player
Import barrel

Class Barrels Extends FlxGroup Implements FlxOverlapNotifyListener

	Field barrel:Barrel
	
	Field poisonbar:Bar	

	Method New(y:Float, poisonBar:Bar)
		Super.New(2)
	
		Local b:Barrel = New Barrel()
		b.Reset(5, y - b.height)
		Add(b)
		
		b = New Barrel()
		b.Reset(FlxG.Width - b.width - 5, y - b.height)
		Add(b)
		
		Self.poisonbar = poisonBar
	End Method
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		barrel = Barrel(object1)
		barrel.collided = True

		If ( Not barrel.empty) Then
			poisonbar.Value = poisonbar.Max
			barrel.empty = True
		End If
	End Method
	
End Class