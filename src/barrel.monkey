Strict

Import flixel

Class Barrel Extends FlxSprite

	Field collided:Bool
	
	Field empty:Bool
	
	Field smoke:FlxSprite
	
	Method New()
		Super.New(0, 0, "barrel")
		collided = False
		
		smoke = New FlxSprite(x, y)
		Reset(x, y)
		smoke.LoadGraphic("barrel_smoke", True,, 16, 25)
		
		smoke.AddAnimation("smoke",[0, 1], 1 + FlxG.Random())
		smoke.Play("smoke")
	End Method
	
	Method Reset:Void(x:Float, y:Float)
		Super.Reset(x, y)
		smoke.Reset(x + (width - smoke.width) * 0.5, y - smoke.height - 5)
	End Method
	
	Method Draw:Void()
		Super.Draw()
		smoke.Draw()
	End Method
	
	Method PostUpdate:Void()
		Super.PostUpdate()
		smoke.PostUpdate()
	End Method
	
	Method Update:Void()
		If ( Not empty) Return
		
		If ( Not collided) Then
			empty = False
		End If
		
		collided = False
	End Method
	
End Class