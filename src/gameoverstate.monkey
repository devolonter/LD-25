Strict

Import flixel
Import menustate

Class GameOverState Extends FlxState

	Field caption:FlxText
	
	Field score:FlxText
	
	Field start:FlxText
	
	Field startTween:NumTween
	
	Method Create:Void()
		caption = New FlxText(20, 20, FlxG.Width - 40, "YOUR SCORE")
		caption.SetFormat("default", 36, FlxG.WHITE, FlxText.ALIGN_CENTER)
		Add(caption)
		
		score = New FlxText(20, 65, FlxG.Width - 40, FlxG.Score)
		score.SetFormat("default", 36, FlxG.WHITE, FlxText.ALIGN_CENTER)
		Add(score)
		
		startTween = New NumTween(Null, FlxTween.PINGPONG)
		startTween.Tween(1, 0, 1, Ease.SineInOut)
		AddTween(startTween, True)		
		
		start = New FlxText(20, FlxG.Height - 100, FlxG.Width - 40)
		start.SetFormat("default", 36, FlxG.WHITE, FlxText.ALIGN_CENTER)
		start.Text = "PRESS SPACE TO RESTART"
		Add(start)

		FlxG.Score = 0
	End Method
	
	Method Update:Void()
		Super.Update()
		start.Alpha = startTween.value
		
		If (FlxG.Keys.JustReleased(KEY_SPACE)) Then
			FlxG.SwitchState(New MenuState())
		End If
	End Method

End Class