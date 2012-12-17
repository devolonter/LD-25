Strict

Import flixel

Class Barrel Extends FlxSprite

	Field collided:Bool
	
	Field empty:Bool
	
Private
	Field bubbles:FlxEmitter
	
Public
	Method New()
		Super.New(0, 0, "barrel")
		collided = False
		
		bubbles = New FlxEmitter(0, 0, 10)
		bubbles.SetYSpeed(-10, -30)
		bubbles.SetXSpeed(0, 0)
		
		bubbles.width = width - 10
		
		Local bubble:FlxParticle
		For Local i:Int = 0 Until bubbles.MaxSize
			bubble = New FlxParticle()
			bubble.LoadGraphic("barrel_bubble")
			bubble.scale.x = FlxG.Random() * 0.5 + 0.5
			bubble.scale.y = bubble.scale.x
			'buuble.visible = False
			bubbles.Add(bubble)
		Next
		
		Reset(x, y)
		bubbles.Start(False, 1, 0.2)
	End Method
	
	Method Reset:Void(x:Float, y:Float)
		Super.Reset(x, y)
		bubbles.x = x + 5
		bubbles.y = y - 5
	End Method
	
	Method Draw:Void()
		Super.Draw()
		bubbles.Draw()
	End Method
	
	Method PostUpdate:Void()
		Super.PostUpdate()
		bubbles.PostUpdate()
	End Method
	
	Method Update:Void()
		bubbles.Update()
		If ( Not empty) Return
		
		If ( Not collided) Then
			empty = False
		End If
		
		collided = False
	End Method
	
End Class