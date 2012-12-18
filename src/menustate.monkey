Strict

Import flixel

Class MenuState Extends FlxState

	Field bg:FlxSprite
	
	Field start:FlxText
	
	Field startTween:NumTween
	
	Method Create:Void()
	
		startTween = New NumTween(Null, FlxTween.PINGPONG)
		startTween.Tween(1, 0, 1, Ease.SineInOut)
		AddTween(startTween, True)		
		
		start = New FlxText(20, FlxG.Height - 70, FlxG.Width - 40)
		start.SetFormat("default", 36, FlxG.WHITE, FlxText.ALIGN_CENTER)
		
		start.Text = "PRESS SPACE TO START"		
		Add(start)
	End Method
	
	Method Update:Void()
		Super.Update()
		start.Alpha = startTween.value
		
		If (FlxG.Touch().JustPressed() Or FlxG.Keys.JustPressed(KEY_SPACE)) Then
			FlxG.SwitchState(New PlayState())
		End If
	End Method

End Class