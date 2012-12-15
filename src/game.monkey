Strict

Import flixel
Import playstate
Import flixel.flxtext.driver.fontmachine

Class Game Extends FlxGame

	Global MinY:Float
	
	Global MaxY:Float

	Method New()
		Super.New(640, 480, GetClass("PlayState"), 1, 60, 60)
	End Method

	Method OnContentInit:Void()
		FlxTextFontMachineDriver.Init()
		FlxText.SetDefaultDriver(GetClass("FlxTextFontMachineDriver"))
	End Method

End Class