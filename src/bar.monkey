Strict

Import flixel

Class Bar Extends FlxBasic

	Const LEFT_TO_RIGHT:Int = 1
	
	Const RIGHT_TO_LEFT:Int = -1

	Field x:Float
	
	Field y:Float
	
	Field width:Float
	
	Field height:Float

Private
	Field value:Int = 0
	
	Field max:Int = 0
	
	Field items:FlxSprite[]
	
	Field dir:Int
	
	Field graphic:String
	
Public
	Method New(x:Float, y:Float, graphic:String, countItems:Int, dir:Int = LEFT_TO_RIGHT)
		Super.New()
	
		Self.x = x
		Self.y = y
		Self.dir = dir
		Self.graphic = graphic
	
		items = items.Resize(countItems)
		For Local i:Int = 0 Until countItems
			AddItem()
		Next
		
		Value = max
	End Method
	
	Method AddItem:Void()
		If (max = items.Length()) items = items.Resize(items.Length() +5)
		
		Local sprite:FlxSprite = New FlxSprite(0, 0)
		sprite.LoadGraphic(graphic, True)
		
		Local offset:Float = 0
		If (dir < 0) offset = -sprite.width
		
		sprite.Reset(x + offset + (sprite.width + 5) * max * dir, y)
		sprite.Frame = 1
		items[max] = sprite
		
		max += 1
		width += sprite.width + 5
		height = sprite.height
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