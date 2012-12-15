Strict

Import flixel
Import playstate
Import flixel.flxtext.driver.fontmachine

Class Game Extends FlxGame

	Global MinY:Float
	
	Global MaxY:Float

	Method New()
		Super.New(480, 800, GetClass("PlayState"), 1, 60, 60)
		forceDebugger = True
	End Method

	Method OnContentInit:Void()
		FlxAssetsManager.AddImage("bar_poison", "images/bar_poison.png")
	
		FlxAssetsManager.AddImage("player", "images/player.png")
		FlxAssetsManager.AddImage("poison", "images/poison.png")
	
		FlxTextFontMachineDriver.Init()
		FlxText.SetDefaultDriver(GetClass("FlxTextFontMachineDriver"))
	End Method

End Class