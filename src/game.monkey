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
		FlxAssetsManager.AddImage("bg", "images/bg.png")
		FlxAssetsManager.AddImage("floor", "images/floor.png")
	
		FlxAssetsManager.AddImage("player", "images/player.png")
		
		FlxAssetsManager.AddImage("poison", "images/poison.png")
		FlxAssetsManager.AddImage("brick", "images/brick.png")
		FlxAssetsManager.AddImage("bonus", "images/bonus_sheet.png")
		
		FlxAssetsManager.AddImage("barrel", "images/barrel.png")
		FlxAssetsManager.AddImage("barrel_bubble", "images/barrel_bubble.png")
		
		FlxAssetsManager.AddImage("lifebar", "images/bar_life.png")
		FlxAssetsManager.AddImage("poisonbar", "images/bar_poison.png")
		
		FlxAssetsManager.AddImage("professor", "images/professor.png")
		FlxAssetsManager.AddImage("professor_mask", "images/professor_mask.png")
		
		FlxAssetsManager.AddSound("jump", "sounds/jump." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound("kill", "sounds/kill." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound("brick", "sounds/brick." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound("bonus", "sounds/bonus." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound("shoot", "sounds/shoot." + FlxSound.GetValidExt())
		
		FlxAssetsManager.AddMusic("mad", "music/mad." + FlxMusic.GetValidExt())
	
		FlxTextFontMachineDriver.Init()
		FlxText.SetDefaultDriver(GetClass("FlxTextFontMachineDriver"))
		
		Local defaultFont:FlxFont = FlxAssetsManager.AddFont("default", FlxText.DRIVER_FONTMACHINE)
		defaultFont.SetPath(36, "fonts/default_" + 36 + ".txt")
	End Method

End Class