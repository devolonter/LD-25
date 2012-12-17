Strict

Import flixel

Class Bonus Extends FlxSprite

	Global ClassObject:Object
	
	Const BOMB:Int = 0
	
	Const EARTHQUAKE:Int = 1
	
	Const INVICIBILITY:Int = 2
	
	Const BOTTLE:Int = 3
	
	Const LIFE:Int = 4
	
	Const SPEED_DOWN:Int = 5
	
	Const SPEED_UP:Int = 6
	
	Field lifeTime:Float
	
	Method New()
		Super.New(0, 0)
		LoadGraphic("bonus", True)
	End Method
	
	Method Update:Void()
		lifeTime -= FlxG.Elapsed
		If (lifeTime < 2 And Not Flickering) Flicker(2)
		If (lifeTime <= 0) Kill()
	End Method
	
	Method Type:Void(type:Int) Property
		Frame = type
	End Method
	
	Method Type:Int() Property
		Return Frame
	End Method

End Class