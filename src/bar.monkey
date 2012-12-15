Strict

Import flixel

Class Bar Extends FlxBasic

	Field x:Float
	
	Field y:Float
	
	Field width:Float
	
	Field height:Float

Private
	Field value:Int = 0
	
	Field max:Int = 0
	
	Field items:FlxSprite[]
	
Public
	Method New(x:Float, y:Float, graphic:String, countItems:Int)
		Super.New()
	
		Self.x = x
		Self.y = y
	
		items = items.Resize(countItems)
		
		Local sprite:FlxSprite
		
		For Local i:Int = 0 Until countItems
			sprite = New FlxSprite(x, y)
			sprite.LoadGraphic(graphic, True)
			sprite.Reset(x + sprite.width * i, y)
			sprite.Frame = 1
			items[i] = sprite
		Next
		
		width = sprite.width * countItems
		height = sprite.height
		max = countItems
	End Method
	
	Method Value:Void(newValue:Int) Property
		If (value = newValue) Return
		
		For Local i:Int = 0 Until max
			If (i < newValue) Then
				items[i].Frame = 0
			Else
				items[i].Frame = 1
			End If
		Next
		
		value = newValue
	End Method
	
	Method Draw:Void()
		For Local i:Int = 0 Until max
			items[i].Draw()
		Next
	End Method
	
	Method Value:Int() Property
		Return value
	End Method
	
	Method Max:Void(value:Int) Property
		max = Min(value, items.Length())
	End Method
	
	Method Max:Int() Property
		Return max
	End Method

End Class